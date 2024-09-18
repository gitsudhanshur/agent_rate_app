import 'package:flutter/material.dart';
import 'agent_model.dart';
import 'agent_service.dart';

class AgentListScreen extends StatefulWidget {
  @override
  _AgentListScreenState createState() => _AgentListScreenState();
}

class _AgentListScreenState extends State<AgentListScreen> {
  late Future<List<Agent>> futureAgents;

  @override
  void initState() {
    super.initState();
    futureAgents = AgentService().fetchAgents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 76, 160, 175),
        child: FutureBuilder<List<Agent>>(
          future: futureAgents,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
        
                      DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Name',
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Agentrate',
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'City',
                              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
                            ),
                          ),
                        ],
                        rows: snapshot.data!
                            .map(
                              (agent) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(agent.name, style: TextStyle(color: Colors.white))),
                                  DataCell(Text(agent.agentrate, style: TextStyle(color: Colors.white))),
                                  DataCell(Text(agent.city, style: TextStyle(color: Colors.white))),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Center(child: Text('No agents found.'));
            }
          },
        ),
      ),
    );
  }
}
