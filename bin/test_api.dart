import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  final envLines = File('.env').readAsLinesSync();
  String apiKey = '';
  for (var line in envLines) {
    if (line.startsWith('API_KEY=')) {
      apiKey = line.split('=')[1].trim();
    }
  }
  
  if (apiKey.isEmpty) {
    print('No API Key');
    return;
  }
  
  print('Testing API Key...');
  
  final lat = 33.44;
  final lon = -94.04;
  
  final wRes = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey'));
  print('Weather: ${wRes.statusCode} - ${wRes.body.length > 50 ? wRes.body.substring(0, 50) + "..." : wRes.body}');
  
  final ocRes = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey'));
  print('OneCall 2.5: ${ocRes.statusCode} - ${ocRes.body}');
  
  final oc3Res = await http.get(Uri.parse('https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey'));
  print('OneCall 3.0: ${oc3Res.statusCode} - ${oc3Res.body}');

  final apRes = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$lon&appid=$apiKey'));
  print('Air Pollution: ${apRes.statusCode} - ${apRes.body.length > 50 ? apRes.body.substring(0, 50) + "..." : apRes.body}');

  final uvRes = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/uvi?lat=$lat&lon=$lon&appid=$apiKey'));
  print('UV Index: ${uvRes.statusCode} - ${uvRes.body}');
}
