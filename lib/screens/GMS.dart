import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:glivealert/services/api_service.dart'; // Import the correct path to ApiService
//import 'package:fl_chart/fl_chart.dart'; // Add this import

class GMSDetails extends StatefulWidget {
  const GMSDetails({super.key});

  @override
  _GMSDetailsState createState() => _GMSDetailsState();
}

class _GMSDetailsState extends State<GMSDetails> {
  late Future<List<GeomagneticStormData>> futureStormData;

  @override
  void initState() {
    super.initState();
    // Fetch storm data from the API
    futureStormData = ApiService().fetchGeomagneticStormData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('../assets/img/signin_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Tabs
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tracker',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Geomagnetic Storm',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ToggleButtons(
                            fillColor: Colors.orangeAccent,
                            color: Colors.white,
                            selectedColor: Colors.black,
                            isSelected: const [
                              true,
                              false,
                              false
                            ], // Example: Default to "Day"
                            onPressed: (int index) {
                              setState(() {
                                // Add logic to update tab selection
                              });
                            },
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text("Day"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text("Week"),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text("Total"),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.calendar_today,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Glassmorphism Containers
                Expanded(
                  child: Center(
                    child: FutureBuilder<List<GeomagneticStormData>>(
                      future: futureStormData,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error loading data: ${snapshot.error}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              'No storm data available',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        } else {
                          // Display the storm data
                          final stormData = snapshot.data!;
                          double speed = stormData[0].kpIndex * 50.0;
                          String intensity =
                              getIntensityDescription(stormData[0].kpIndex.toInt());
                          String strength =
                              getStrengthDescription(stormData[0].kpIndex.toInt());

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Intensity Box
                              GlassContainer(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'Intensity: $intensity',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Strength Box
                              GlassContainer(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'Strength: $strength',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Speed Box
                              GlassContainer(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    'Speed: $speed km/s',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Line Chart for kpIndex Values (Add additional logic here if needed)
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get the intensity description based on kpIndex
  String getIntensityDescription(int kpIndex) {
    if (kpIndex < 4) {
      return 'Quiet';
    } else if (kpIndex < 6) {
      return 'Active';
    } else if (kpIndex < 8) {
      return 'Minor Storm';
    } else {
      return 'Major Storm';
    }
  }

  // Helper method to get the strength description based on kpIndex
  String getStrengthDescription(int kpIndex) {
    if (kpIndex < 4) {
      return 'Minor';
    } else if (kpIndex < 8) {
      return 'Moderate';
    } else {
      return 'Major';
    }
  }
}

// Custom Glassmorphism Container Widget
class GlassContainer extends StatelessWidget {
  final Widget child;
  const GlassContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 10.0, sigmaY: 10.0), // Frosted glass blur effect
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1), // Semi-transparent background
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2), // Light border for the glass effect
            ),
          ),
          child: child, // Content inside the glass container
        ),
      ),
    );
  }
}
