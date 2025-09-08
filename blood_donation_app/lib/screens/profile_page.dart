import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    try {
      if (userId != null) {
        final response = await supabase
            .from('users')
            .select()
            .eq('id', userId)
            .single();

        _nameController.text = response['name'] ?? '';
        _bloodGroupController.text = response['blood_group'] ?? '';
        _phoneController.text = response['phone'] ?? '';
        _locationController.text = response['location'] ?? '';
      }
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading profile: $e")),
      );
    }

  }


  Future<void> _saveProfile() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if(userId == null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User not logged in")),
      );
      return ;
    }
    try{
      await supabase.from('users').upsert({
        'id' : userId ,
        'name' : _nameController.text,
        'blood_group' : _bloodGroupController.text,
        'phone' : _phoneController.text,
        'location' : _locationController.text,

      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Profile updeted successfully")
          ),
      );
      Navigator.pushReplacementNamed(context, '/home');
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 3,color: Colors.redAccent,),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _bloodGroupController,
              decoration: InputDecoration(
                labelText: "Blood Group",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 3,color: Colors.redAccent,),
                ),
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 3,color: Colors.redAccent,),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10,),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: "Location",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(width: 5,color: Colors.redAccent,),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity,50),
                backgroundColor: Colors.redAccent,
              ),
              child: Text(
                "Save Profile",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
