import 'dart:convert';
import 'package:http/http.dart' as http;
import 'agent_model.dart';  // Import your model

class AgentService {
  static const String apiUrl = 'https://crmapi.conscor.com/api/general/v1/mfind';

  Future<List<Agent>> fetchAgents() async {
    // Sending a POST request instead of GET
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'x-api-key': 'PLLW0s5A6Rk1aZeAmWr1',
      },
      body: jsonEncode(
        {
          "dbName": "customize-5",
          "collectionName": "company_details",
          "query": {},
          "projection": {},
          "limit": 5,
          "skip": 0
        }), // If no body is needed, you can pass an empty map or add required body data
    );

    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the JSON data if the request was successful
      Map<String, dynamic> jsonData = json.decode(response.body);
      
      // Extract the list of agents from the 'data' key
      List<dynamic> agentsList = jsonData['data'];

      // Convert the list of JSON objects to a list of Agent objects
      return agentsList.map((agent) => Agent.fromJson(agent)).toList();
    } else {
      throw Exception('Failed to load agents');
    }
  }
}
