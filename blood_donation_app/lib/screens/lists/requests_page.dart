import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  Future<List<Map<String, dynamic>>> _fetchRequests() async {
    final supabase = Supabase.instance.client;
    final response = await supabase
        .from('requests')
        .select('blood_group, hospital, urgency, created_at, users(name, phone, location)')
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Blood Requests")),
      body: FutureBuilder(
        future: _fetchRequests(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final requests = snapshot.data!;
          if (requests.isEmpty) {
            return Center(child: Text("No blood requests found"));
          }
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, i) {
              final req = requests[i];
              final user = req['users'];
              final createdAt = DateTime.parse(req['created_at']);
              final formattedDate = "${createdAt.day}/${createdAt.month}/${createdAt.year}";
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Icon(
                    req['urgency'] == 'Urgent' ? Icons.warning : Icons.bloodtype,
                    color: req['urgency'] == 'Urgent' ? Colors.red : Colors.blue,
                  ),
                  title: Text("Blood Group: ${req['blood_group']}"),
                  subtitle: Text(
                    "Hospital: ${req['hospital']}\n"
                        "Urgency: ${req['urgency']}\n"
                        "Date: $formattedDate\n"
                        "Contact: ${user['name']} - ${user['phone']}\n"
                        "Location: ${user['location']}",
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
