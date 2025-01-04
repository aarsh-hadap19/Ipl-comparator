import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import '../widgets/horizontal_stacked_bar_chart.dart';
import '../widgets/stat_row_widget.dart';
import '../widgets/stats_comparision.dart';
import '../widgets/stats_widget.dart'; // Import the file where you created the StatRowWidget


class BatsmanScreen extends StatefulWidget {
  const BatsmanScreen({super.key});

  @override
  State<BatsmanScreen> createState() => _BatsmanScreenState();
}

class _BatsmanScreenState extends State<BatsmanScreen> {
  String? _selectedPlayer1;
  String? _selectedPlayer2;

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

  Map<String, dynamic>? _statsPlayer1;
  Map<String, dynamic>? _statsPlayer2;

  Future<void> fetchPlayerStats(String playerName, bool isPlayer1) async {
    try {
      final String serverUrl = Platform.isAndroid
          ? 'http://10.0.2.2:5000/stats'  // For Android emulator
          : 'http://localhost:5000/stats';  // For iOS simulator or real device

      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': playerName}),
      );

      if (response.statusCode == 200) {
        setState(() {
          if (isPlayer1) {
            _statsPlayer1 = jsonDecode(response.body);
          } else {
            _statsPlayer2 = jsonDecode(response.body);
          }
        });
      } else {
        setState(() {
          if (isPlayer1) {
            _statsPlayer1 = {'error': 'Player not found or an error occurred'};
          } else {
            _statsPlayer2 = {'error': 'Player not found or an error occurred'};
          }
        });
      }
    } catch (e) {
      setState(() {
        if (isPlayer1) {
          _statsPlayer1 = {'error': 'Failed to connect to server'};
        } else {
          _statsPlayer2 = {'error': 'Failed to connect to server'};
        }
      });
    }
  }

  // Function to calculate percentages for bar charts
  // Map<String, double> calculateStatPercentages() {
  //   if (_statsPlayer1 == null || _statsPlayer2 == null) return {};
  //
  //   double totalRuns = (_statsPlayer1!['runs'] ?? 0.0) + (_statsPlayer2!['runs'] ?? 0.0);
  //   double totalAverage = (_statsPlayer1!['average'] ?? 0.0) + (_statsPlayer2!['average'] ?? 0.0);
  //
  //   return {
  //     'runsPlayer1': (_statsPlayer1!['runs'] ?? 0.0) / totalRuns * 100,
  //     'runsPlayer2': (_statsPlayer2!['runs'] ?? 0.0) / totalRuns * 100,
  //     'averagePlayer1': (_statsPlayer1!['average'] ?? 0.0) / totalAverage * 100,
  //     'averagePlayer2': (_statsPlayer2!['average'] ?? 0.0) / totalAverage * 100,
  //   };
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Player selection UI (Dropdowns)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
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
                          child: const Icon(
                              Icons.person, size: 30, color: Colors.white),
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
                              value: _selectedPlayer1,
                              hint: const Text("Select Player 1"),
                              isExpanded: true,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              icon: const Icon(
                                  Icons.arrow_drop_down, color: Colors.blue),
                              items: _players
                                  .where((player) => player != _selectedPlayer2)
                                  .map((String player) {
                                return DropdownMenuItem<String>(
                                  value: player,
                                  child: Text(
                                    player,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPlayer1 = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
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
                          child: const Icon(
                              Icons.person, size: 30, color: Colors.white),
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
                              value: _selectedPlayer2,
                              hint: const Text("Select Player 2"),
                              isExpanded: true,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              icon: const Icon(
                                  Icons.arrow_drop_down, color: Colors.blue),
                              items: _players
                                  .where((player) => player != _selectedPlayer1)
                                  .map((String player) {
                                return DropdownMenuItem<String>(
                                  value: player,
                                  child: Text(
                                    player,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedPlayer2 = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
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
                    fetchPlayerStats(_selectedPlayer1!, true);
                  }
                  if (_selectedPlayer2 != null) {
                    fetchPlayerStats(_selectedPlayer2!, false);
                  }
                },
                child: const Text(
                  "Simulate",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Stats',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Replace the Row containing PlayerStatsWidget instances with this:
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
              const SizedBox(height: 20),
              // This part should be a part of the widget tree
              // Remove the existing stats widgets and replace with:
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