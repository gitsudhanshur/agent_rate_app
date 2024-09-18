import 'dart:convert';
import 'package:http/http.dart' as http;
import 'agent_model.dart';

class AgentService {
  static const String apiUrl = 'https://crmapi.conscor.com/api/general/v1/mfind';

  Future<List<Agent>> fetchAgents() async {
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
        }),
    );

    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      
      List<dynamic> agentsList = jsonData['data'];

      return agentsList.map((agent) => Agent.fromJson(agent)).toList();
    } else {
      throw Exception('Failed to load agents');
    }
  }
}
