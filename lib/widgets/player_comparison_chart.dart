import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PlayerData {
  final String playerName;
  final double totalRuns;
  final double percentage;

  PlayerData({
    required this.playerName,
    required this.totalRuns,
    required this.percentage,
  });
}

class PlayerComparisonChart extends StatelessWidget {
  final List<PlayerData> playerDataList;

  PlayerComparisonChart({required this.playerDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Player Comparison')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 200, // Adjust according to total runs
            interval: 20,
          ),
          series: <CartesianSeries<PlayerData, String>>[
            StackedBarSeries<PlayerData, String>(
              dataSource: playerDataList,
              xValueMapper: (PlayerData data, _) => data.playerName,
              yValueMapper: (PlayerData data, _) => data.totalRuns,
              color: Colors.blue,
              name: 'Player A',
            ),
            StackedBarSeries<PlayerData, String>(
              dataSource: playerDataList,
              xValueMapper: (PlayerData data, _) => data.playerName,
              yValueMapper: (PlayerData data, _) => data.totalRuns,
              color: Colors.red,
              name: 'Player B',
            ),
          ],
        ),
      ),
    );
  }
}
