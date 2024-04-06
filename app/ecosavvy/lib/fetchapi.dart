import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models.dart';
final String URL = 'http://172.16.17.4:3000/fetch/getallorgs';

Future<List<Organisation>> fetchOrganisations() async {
  final response = await http.get(Uri.parse(URL));
  print(response);
  if (response.statusCode == 200 || response.statusCode== 201) {
    List jsonResponse = await json.decode(response.body);
    // Print the decoded JSON response for debugging
    print('Decoded JSON Response: $jsonResponse');

    // Map JSON data to Organisation objects
    List<Organisation> organisations = jsonResponse.map((data) => Organisation.fromJson(data)).toList();

    // Print the list of organisations for debugging
    print('List of Organisations: $organisations');

    return organisations;
  } else {
    // Print error message for debugging
    print('Failed to load organisations. Status code: ${response.statusCode}');
    throw Exception('Failed to load organisations');
  }
}
