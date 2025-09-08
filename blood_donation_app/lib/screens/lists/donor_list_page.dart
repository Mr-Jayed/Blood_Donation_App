import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DonorListPage extends StatelessWidget {
  const DonorListPage({super.key});

  Future<List<Map<String, dynamic>>> _fetchDonors() async {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('users').select();
    return List<Map<String, dynamic>>.from(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donor List")),
      body: FutureBuilder(
        future: _fetchDonors(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final donors = snapshot.data!;
          if (donors.isEmpty) {
            return Center(child: Text("No donors available"));
          }
          return ListView.builder(
            itemCount: donors.length,
            itemBuilder: (context, i) {
              final donor = donors[i];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(donor['name']),
                  subtitle: Text(
                    "Blood Group: ${donor['blood_group']}\nPhone: ${donor['phone']}\nLocation: ${donor['location']}",
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
