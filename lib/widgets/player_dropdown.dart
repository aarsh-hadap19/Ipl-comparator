// player_dropdown.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/firebase_service.dart';

class PlayerDropdown extends StatefulWidget {
  final String? selectedPlayer;
  final List<String> players;
  final String hintText;
  final ValueChanged<String?> onChanged;
  final String? excludedPlayer;

  const PlayerDropdown({
    Key? key,
    required this.selectedPlayer,
    required this.players,
    required this.hintText,
    required this.onChanged,
    this.excludedPlayer,
  }) : super(key: key);

  @override
  State<PlayerDropdown> createState() => _PlayerDropdownState();
}

class _PlayerDropdownState extends State<PlayerDropdown> {
  final FirebaseService _firebaseService = FirebaseService();
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    if (widget.selectedPlayer != null) {
      _loadPlayerImage();
    }
  }

  @override
  void didUpdateWidget(PlayerDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedPlayer != oldWidget.selectedPlayer) {
      _loadPlayerImage();
    }
  }

  Future<void> _loadPlayerImage() async {
    if (widget.selectedPlayer != null) {
      final playerData = await _firebaseService.getPlayerData(widget.selectedPlayer!);
      setState(() {
        imageUrl = playerData['imgUrl'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: imageUrl != null
                ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ),
            )
                : const Icon(Icons.person, size: 30, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.selectedPlayer,
              hint: Text(widget.hintText),
              isExpanded: true,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
              items: widget.players
                  .where((player) => player != widget.excludedPlayer)
                  .map((String player) {
                return DropdownMenuItem<String>(
                  value: player,
                  child: Text(
                    player,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ],
    );
  }
}