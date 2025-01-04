// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatsComparisonTable extends StatelessWidget {
  final Map<String, dynamic>? statsPlayer1;
  final Map<String, dynamic>? statsPlayer2;
  final String player1Name;
  final String player2Name;

  const StatsComparisonTable({
    Key? key,
    required this.statsPlayer1,
    required this.statsPlayer2,
    required this.player1Name,
    required this.player2Name,
  }) : super(key: key);

  Widget _buildComparisonArrow(dynamic value1, dynamic value2) {
    if (value1 == null || value2 == null) return const SizedBox.shrink();

    final num1 = num.tryParse(value1.toString()) ?? 0;
    final num2 = num.tryParse(value2.toString()) ?? 0;

    if (num1 == num2) return const SizedBox.shrink();

    return Icon(
      num1 > num2 ? Icons.arrow_upward : Icons.arrow_downward,
      color: num1 > num2 ? Colors.green : Colors.red,
      size: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Players Header Section with frames only once
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     Column(
        //       children: [
        //         Container(
        //           width: 80,
        //           height: 80,
        //           decoration: BoxDecoration(
        //             color: Colors.blue,
        //             borderRadius: BorderRadius.circular(20),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.blue.withOpacity(0.3),
        //                 spreadRadius: 2,
        //                 blurRadius: 10,
        //                 offset: const Offset(0, 4),
        //               ),
        //             ],
        //           ),
        //           child: const Icon(Icons.person, color: Colors.white, size: 40),
        //         ),
        //         const SizedBox(height: 10),
        //         Text(
        //           player1Name,
        //           style: const TextStyle(
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ],
        //     ),
        //     Column(
        //       children: [
        //         Container(
        //           width: 80,
        //           height: 80,
        //           decoration: BoxDecoration(
        //             color: Colors.purple,
        //             borderRadius: BorderRadius.circular(20),
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.purple.withOpacity(0.3),
        //                 spreadRadius: 2,
        //                 blurRadius: 10,
        //                 offset: const Offset(0, 4),
        //               ),
        //             ],
        //           ),
        //           child: const Icon(Icons.person, color: Colors.white, size: 40),
        //         ),
        //         const SizedBox(height: 10),
        //         Text(
        //           player2Name,
        //           style: const TextStyle(
        //             fontSize: 16,
        //             fontWeight: FontWeight.bold,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        const SizedBox(height: 30),

        // Stats Table Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              const Expanded(
                flex: 2,
                child: Text(
                  "Statistics",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  player1Name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Text(
                  player2Name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Stats Comparison Table
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 2),
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
    );
  }

  Widget _buildStatRow(String statName, dynamic value1, dynamic value2) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Stat Name (Left)
          Expanded(
            flex: 2,
            child: Text(
              statName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
          // Player 1 Stat with arrow (Middle)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value1?.toString() ?? '-',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(width: 4),
                _buildComparisonArrow(value1, value2),
              ],
            ),
          ),
          SizedBox(width: 20,),
          // Player 2 Stat with arrow (Right)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  value2?.toString() ?? '-',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.purple.shade700,
                  ),
                ),
                const SizedBox(width: 4),
                _buildComparisonArrow(value2, value1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
