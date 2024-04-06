import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';

final String URL = 'http://172.16.17.4:3000/fetch/getallorgs';
Future<List<Organisation>> fetchOrganisations() async {
  final response = await http.get(Uri.parse(URL));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => Organisation.fromJson(data)).toList();
  } else {
    throw Exception('Failed to load organisations');
  }
}
