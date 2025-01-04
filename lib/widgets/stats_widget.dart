import 'package:flutter/material.dart';

class PlayerStatsWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Player Icon with 3D effect
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: playerColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: playerColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.person,
            color: Colors.white,
            size: 40,
          ),
        ),
        const SizedBox(height: 12),
        // Player Name
        Text(
          playerName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class ComparisonStatsTable extends StatelessWidget {
  final Map<String, dynamic>? statsPlayer1;
  final Map<String, dynamic>? statsPlayer2;
  final String player1Name;
  final String player2Name;

  const ComparisonStatsTable({
    Key? key,
    required this.statsPlayer1,
    required this.statsPlayer2,
    required this.player1Name,
    required this.player2Name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // Player Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PlayerStatsWidget(
                stats: statsPlayer1,
                playerName: player1Name,
                playerColor: Colors.blue,
              ),
              PlayerStatsWidget(
                stats: statsPlayer2,
                playerName: player2Name,
                playerColor: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Stats Comparison Table
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildStatRow('Innings', statsPlayer1?['Innings'], statsPlayer2?['Innings']),
                _buildStatRow('Runs', statsPlayer1?['Runs'], statsPlayer2?['Runs']),
                _buildStatRow('Average', statsPlayer1?['Average'], statsPlayer2?['Average']),
                _buildStatRow('Centuries', statsPlayer1?['Centuries'], statsPlayer2?['Centuries']),
                _buildStatRow('Ducks', statsPlayer1?['Ducks'], statsPlayer2?['Ducks']),
                _buildStatRow('Fours', statsPlayer1?['Fours'], statsPlayer2?['Fours']),
                _buildStatRow('Sixes', statsPlayer1?['Sixes'], statsPlayer2?['Sixes']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, dynamic value1, dynamic value2) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Stat Label
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          // Player 1 Value
          Expanded(
            flex: 1,
            child: Text(
              value1?.toString() ?? '-',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Player 2 Value
          Expanded(
            flex: 1,
            child: Text(
              value2?.toString() ?? '-',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}