import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BloodConnect"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (value) async {
              final supabase = Supabase.instance.client;

              switch(value) {
                case 'profile' :
                  Navigator.pushNamed(context, '/profile');
                  break;
                case 'logout':
                  await supabase.auth.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Signed out successfully')),
                  );
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/login',
                      (route) => false,
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              buildMenuItem(
                  Icons.account_circle,
                  "Edit Profile",
                  'profile',
              ),
              buildMenuItem(
                  Icons.logout,
                "Sign Out",
                'logout'
              ),
            ],
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Icon(Icons.bloodtype, size: 80, color: Colors.redAccent),
                SizedBox(height: 12),
                Text(
                  "Your dashboard for saving lives",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
              ],
            ),

            _buildFeatureCard(
              context,
              icon: Icons.add,
              label: "Make Blood Request",
              route: '/request',
            ),
            _buildFeatureCard(
              context,
              icon: Icons.list,
              label: "View Blood Requests",
              route: '/requests',
            ),
            _buildFeatureCard(
              context,
              icon: Icons.people,
              label: "Donor List",
              route: '/donors',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, route),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              Icon(icon, size: 28, color: Colors.redAccent),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
  PopupMenuItem<String> buildMenuItem(IconData icon , String text , String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.redAccent,
          ),
          const SizedBox(width: 12,),
          Text(
            text,
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
