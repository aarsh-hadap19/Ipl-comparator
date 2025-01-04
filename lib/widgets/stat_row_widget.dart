import 'package:flutter/material.dart';

class StatRowWidget extends StatelessWidget {
  final String statName;
  final dynamic statValuePlayer1;
  final dynamic statValuePlayer2;

  const StatRowWidget({
    required this.statName,
    required this.statValuePlayer1,
    required this.statValuePlayer2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the greater and smaller stat values
    final bool isPlayer1Greater = (statValuePlayer1 ?? 0) > (statValuePlayer2 ?? 0);
    final bool isPlayer2Greater = (statValuePlayer2 ?? 0) > (statValuePlayer1 ?? 0);

    // Use black for the greater stat and grey for the smaller stat
    final Color colorForPlayer1 = isPlayer1Greater
        ? Colors.black
        : Colors.grey; // Player 1 stat with a smaller value is grey
    final Color colorForPlayer2 = isPlayer2Greater
        ? Colors.black
        : Colors.grey; // Player 2 stat with a smaller value is grey

    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[100], // Light background for both rows
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Player 1 value with arrows
          Row(
            children: [
              if (isPlayer1Greater)
                Icon(
                  Icons.arrow_upward,
                  color: colorForPlayer1,
                  size: 18,
                ),
              if (!isPlayer1Greater && statValuePlayer1 != statValuePlayer2)
                Icon(
                  Icons.arrow_downward,
                  color: colorForPlayer1,
                  size: 18,
                ),
              Text(
                '$statValuePlayer1',
                style: TextStyle(
                  color: colorForPlayer1, // Apply black or grey color based on stat
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                ),
              ),

            ],
          ),
          // Stat Name
          Text(
            statName,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Player 2 value with arrows
          Row(
            children: [
              Text(
                '$statValuePlayer2',
                style: TextStyle(
                  color: colorForPlayer2, // Apply black or grey color based on stat
                  fontSize: 16,
                  // fontWeight: FontWeight.bold,
                ),
              ),
              if (isPlayer2Greater)
                Icon(
                  Icons.arrow_upward,
                  color: colorForPlayer2,
                  size: 18,
                ),
              if (!isPlayer2Greater && statValuePlayer1 != statValuePlayer2)
                Icon(
                  Icons.arrow_downward,
                  color: colorForPlayer2,
                  size: 18,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
