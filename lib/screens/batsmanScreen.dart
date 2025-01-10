import 'package:flutter/material.dart';
import '../services/player_service.dart';
import '../widgets/player_dropdown.dart';
import '../widgets/stats_comparision.dart';
import '../widgets/stats_widget.dart';

class BatsmanScreen extends StatefulWidget {
  const BatsmanScreen({super.key});

  @override
  State<BatsmanScreen> createState() => _BatsmanScreenState();
}

class _BatsmanScreenState extends State<BatsmanScreen> {
  String? _selectedPlayer1;
  String? _selectedPlayer2;

  Map<String, dynamic>? _statsPlayer1;
  Map<String, dynamic>? _statsPlayer2;

  final List<String> _players = [
    "V Kohli", "S Dhawan", "R Sharma", "D Warner", "S Raina", "MS Dhoni",
    "AB de Villiers", "Chris Gayle", "R Uthappa", "Dinesh Karthik",
    "KL Rahul", "Ajinkya Rahane", "Faf du Plessis", "S Samson",
    "A Rayudu", "Shane Watson", "Manish Pandey", "Surya Kumar Yadav",
    "Jos Buttler", "K Pollard", "R Pant", "Shubman Gill",
    "Q de Kock", "S Iyer", "R Jadeja", "W Saha", "David Miller",//till here updated in firebase
    "Glenn Maxwell", "M Agarwal", "Ishan Kishan", "N Rana",
    "M Vijay", "H Pandya", "S Smith", "Andre Russell",
    "R Gaikwad", "R Tripathi", "Kane Williamson", "Aaron Finch",
    "P Shaw", "M Stoinis", "N Pooran", "Mandeep Singh",
    "Axar Patel", "Krunal Pandya", "Y Jaiswal", "J Bairstow",
    "DJ Bravo", "D Padikkal", "Sunil Narine", "S Dube",
    "K Nair", "S Tiwary", "D Hooda", "Eoin Morgan",
    "Abhishek Sharma", "Chris Lynn", "V Iyer", "S Hetmyer",
    "Kedar Jadhav", "R Parag", "Moen Ali", "Tilak Varma",
    "V Shankar", "M Vohra", "B Sai Sudharsan", "R Tewatia",
    "M Henriques", "A Markram", "H Klaasen", "L Livingstone",
    "B Stokes", "D Conway", "Rinku Singh", "Sam Curran",
    "Harbhajan Singh", "R Ashwin", "R Patidar", "Shakib Al Hasan",
    "Travis Head", "Prabhsimran Singh", "J Sharma", "C Green",
    "M Marsh", "Tim David", "E Lewis", "P Salt",
    "A Badoni", "Piyush Chawla", "Chris Morris", "J Roy",
    "SN Khan", "Abdul Samad", "Shahrukh Khan"
  ];


  Future<void> fetchPlayerStatsWrapper(String playerName, bool isPlayer1) async {
    final stats = await fetchPlayerStats(playerName); // Call service function
    setState(() {
      if (isPlayer1) {
        _statsPlayer1 = stats;
      } else {
        _statsPlayer2 = stats;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: PlayerDropdown(
                      selectedPlayer: _selectedPlayer1,
                      players: _players,
                      hintText: "Select Player 1",
                      excludedPlayer: _selectedPlayer2,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPlayer1 = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: PlayerDropdown(
                      selectedPlayer: _selectedPlayer2,
                      players: _players,
                      hintText: "Select Player 2",
                      excludedPlayer: _selectedPlayer1,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPlayer2 = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (_selectedPlayer1 != null) {
                    fetchPlayerStatsWrapper(_selectedPlayer1!, true);
                  }
                  if (_selectedPlayer2 != null) {
                    fetchPlayerStatsWrapper(_selectedPlayer2!, false);
                  }
                },
                child: const Text("Simulate"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (_selectedPlayer1 != null)
                    Expanded(
                      child: PlayerStatsWidget(
                        stats: _statsPlayer1,
                        playerName: _selectedPlayer1!,
                        playerColor: Colors.blue,  // Added playerColor for Player 1
                      ),
                    ),
                  if (_selectedPlayer1 != null && _selectedPlayer2 != null)
                    const SizedBox(width: 20),
                  if (_selectedPlayer2 != null)
                    Expanded(
                      child: PlayerStatsWidget(
                        stats: _statsPlayer2,
                        playerName: _selectedPlayer2!,
                        playerColor: Colors.purple,  // Added playerColor for Player 2
                      ),
                    ),
                ],
              ),
              if (_statsPlayer1 != null && _statsPlayer2 != null)
                StatsComparisonTable(
                  statsPlayer1: _statsPlayer1,
                  statsPlayer2: _statsPlayer2,
                  player1Name: _selectedPlayer1!,
                  player2Name: _selectedPlayer2!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}