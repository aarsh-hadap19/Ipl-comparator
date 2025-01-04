import 'package:flutter/material.dart';

class HorizontalStackedBarChart extends StatelessWidget {
  final double player1Percentage;
  final double player2Percentage;

  const HorizontalStackedBarChart({
    Key? key,
    required this.player1Percentage,
    required this.player2Percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalPercentage = player1Percentage + player2Percentage;

    // Normalize the percentages so that they add up to 100%
    double player1Flex = totalPercentage > 0 ? (player1Percentage / totalPercentage) * 100 : 0;
    double player2Flex = totalPercentage > 0 ? (player2Percentage / totalPercentage) * 100 : 0;

    return Column(
      children: [
        // A Row containing the bars for both players
        Row(
          children: [
            // Player 1's bar
            Expanded(
              flex: player1Flex.toInt(),
              child: Container(
                height: 20,
                color: Colors.blue, // Player 1's bar color
              ),
            ),
            // Player 2's bar
            Expanded(
              flex: player2Flex.toInt(),
              child: Container(
                height: 20,
                color: Colors.red, // Player 2's bar color
              ),
            ),
          ],
        ),
        // Optionally, you can add text labels below the bar
        SizedBox(height: 8),
        Text(
          'Player 1: ${player1Percentage.toStringAsFixed(2)}%   Player 2: ${player2Percentage.toStringAsFixed(2)}%',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
