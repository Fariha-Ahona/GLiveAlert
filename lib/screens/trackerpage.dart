import 'package:flutter/material.dart';
// Ensure this is imported correctly

class TrackerPage extends StatefulWidget {
  const TrackerPage({super.key});

  @override
  _TrackerPageState createState() => _TrackerPageState();
}

class _TrackerPageState extends State<TrackerPage> {
  late Future<List<dynamic>> stormData;

  @override
  void initState() {
    super.initState();
    // Adjust the dates as necessary
    stormData = ApiManager().fetchGeomagneticStormData('2023-09-01', '2023-09-30');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/storm_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<dynamic>>(
          future: stormData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                var data = snapshot.data![index];
                return ListTile(
                  title: Text('Storm on ${data['startTime']}'),
                  subtitle: Text('Speed: ${data['speed']} km/s\nIntensity: ${data['intensity']}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
