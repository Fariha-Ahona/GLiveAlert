import 'dart:convert';
import 'package:http/http.dart' as http;

class GeomagneticStormData {
  final String gstID;
  final String startTime;
  final double kpIndex;
  final String source; 
  final String link; 

  GeomagneticStormData({
    required this.gstID,
    required this.startTime,
    required this.kpIndex,
    required this.source,
    required this.link,
  });

  factory GeomagneticStormData.fromJson(Map<String, dynamic> json) {
    // Extract data from allKpIndex (assuming the first entry is what we want)
    var kpData = json['allKpIndex'] != null && json['allKpIndex'].isNotEmpty
        ? json['allKpIndex'][0]
        : null;

    return GeomagneticStormData(
      gstID: json['gstID'] ?? 'Unknown',
      startTime: json['startTime'] ?? 'N/A',
      kpIndex: kpData != null ? kpData['kpIndex'].toDouble() : 0.0,
      source: kpData != null ? kpData['source'] ?? 'Unknown' : 'Unknown',
      link: json['link'] ?? 'No link available',
    );
  }
}

class ApiService {
  Future<List<GeomagneticStormData>> fetchGeomagneticStormData() async {
    final response = await http.get(
      Uri.parse(
          'https://api.nasa.gov/DONKI/GST?startDate=2016-01-01&endDate=2016-01-30&api_key=vcd9GdP0fiNdhddU960ChXv0wWBXZxSH3ddNG8el'),
    );

    // Print the raw response body for debugging purposes
    print(response.body);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((storm) => GeomagneticStormData.fromJson(storm))
          .toList();
    } else {
      throw Exception('Failed to load storm data');
    }
  }
}
