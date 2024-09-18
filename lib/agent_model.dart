class Agent {
  final String name;
  final String agentrate;
  final String city;

  Agent({
    required this.name,
    required this.agentrate,
    required this.city,
  });

  factory Agent.fromJson(Map<String, dynamic> json) {
    final agentDetails = json['sectionData']['Agent Details'];
    return Agent(
      name: agentDetails['name'],
      agentrate: agentDetails['agentrate'],
      city: agentDetails['city'],
    );
  }
}
