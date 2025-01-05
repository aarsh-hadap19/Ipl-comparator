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
    'V Kohli',
    'S Dhawan',
    'RG Sharma',
    'DA Warner',
    'SK Raina',
    'MS Dhoni',
    'AB de Villiers',
    'CH Gayle',
    'RV Uthappa',
    'KD Karthik',
    'KL Rahul',
    'AM Rahane',
    'F du Plessis',
    'SV Samson',
    'AT Rayudu',
    'SR Watson',
    'MK Pandey',
    'SA Yadav',
    'JC Buttler',
    'KA Pollard',
    'RR Pant',
    'Shubman Gill',
    'Q de Kock',
    'SS Iyer',
    'RA Jadeja',
    'WP Saha',
    'DA Miller',
    'GJ Maxwell',
    'MA Agarwal',
    'Ishan Kishan',
    'N Rana',
    'M Vijay',
    'HH Pandya',
    'SPD Smith',
    'AD Russell',
    'RD Gaikwad',
    'RA Tripathi',
    'KS Williamson',
    'AJ Finch',
    'PP Shaw',
    'MP Stoinis',
    'N Pooran',
    'Mandeep Singh',
    'AR Patel',
    'KH Pandya',
    'YBK Jaiswal',
    'JM Bairstow',
    'DJ Bravo',
    'D Padikkal',
    'SP Narine',
    'S Dube',
    'KK Nair',
    'SS Tiwary',
    'DJ Hooda',
    'EJG Morgan',
    'Abhishek Sharma',
    'CA Lynn',
    'VR Iyer',
    'SO Hetmyer',
    'KM Jadhav',
    'R Parag',
    'MM Ali',
    'NT Tilak Varma',
    'V Shankar',
    'M Vohra',
    'B Sai Sudharsan',
    'R Tewatia',
    'MC Henriques',
    'AK Markram',
    'H Klaasen',
    'LS Livingstone',
    'BA Stokes',
    'DP Conway',
    'RK Singh',
    'SM Curran',
    'Harbhajan Singh',
    'R Ashwin',
    'RM Patidar',
    'Shakib Al Hasan',
    'TM Head',
    'Prabhsimran Singh',
    'JM Sharma',
    'C Green',
    'MR Marsh',
    'TH David',
    'E Lewis',
    'PD Salt',
    'A Badoni',
    'PP Chawla',
    'CH Morris',
    'JJ Roy',
    'SN Khan',
    'Abdul Samad',
    'M Shahrukh Khan',
    'Rashid Khan',
    'Shahbaz Ahmed',
    'MK Lomror',
    'PJ Cummins',
    'Gurkeerat Singh',
    'SW Billings',
    'RR Rossouw'
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