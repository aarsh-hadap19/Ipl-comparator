import 'package:flutter/material.dart';

class PlayerDropdown extends StatelessWidget {
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
          child: const Icon(Icons.person, size: 30, color: Colors.white),
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
              value: selectedPlayer,
              hint: Text(hintText),
              isExpanded: true,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.blue),
              items: players
                  .where((player) => player != excludedPlayer)
                  .map((String player) {
                return DropdownMenuItem<String>(
                  value: player,
                  child: Text(
                    player,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
