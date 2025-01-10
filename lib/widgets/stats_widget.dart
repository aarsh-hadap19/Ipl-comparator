// player_stats_widget.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/firebase_service.dart';

class PlayerStatsWidget extends StatefulWidget {
  final Map<String, dynamic>? stats;
  final String playerName;
  final Color playerColor;

  const PlayerStatsWidget({
    Key? key,
    required this.stats,
    required this.playerName,
    required this.playerColor,
  }) : super(key: key);

  @override
  State<PlayerStatsWidget> createState() => _PlayerStatsWidgetState();
}

class _PlayerStatsWidgetState extends State<PlayerStatsWidget> {
  final FirebaseService _firebaseService = FirebaseService();
  String? imageUrl;
  String? displayName;

  @override
  void initState() {
    super.initState();
    _loadPlayerData();
  }

  @override
  void didUpdateWidget(PlayerStatsWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.playerName != oldWidget.playerName) {
      _loadPlayerData();
    }
  }

  Future<void> _loadPlayerData() async {
    if (mounted) {
      setState(() {
        imageUrl = null;
        displayName = null;
      });

      final playerData = await _firebaseService.getPlayerData(widget.playerName);

      if (mounted) {
        setState(() {
          imageUrl = playerData['imgUrl'];
          displayName = playerData['name'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Player Image with 3D effect
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: widget.playerColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.playerColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? CachedNetworkImage(
              imageUrl: imageUrl!,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
            )
                : const Icon(
              Icons.person,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Player Name with Animation
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            displayName ?? widget.playerName,
            key: ValueKey(displayName ?? widget.playerName),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}