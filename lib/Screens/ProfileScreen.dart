import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // User profile data
    String name = "John Doe";
    String phone = "+1234567890";
    String email = "johndoe@gmail.com";
    String location = "New York, USA";

    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => _navigateToDetailScreen(context, name, phone, email, location),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ProfileDetail(
              icon: Icons.person,
              label: "Name",
              value: name,
              onTap: () => _navigateToDetailScreen(context, name, phone, email, location),
            ),
            ProfileDetail(
              icon: Icons.phone,
              label: "Phone",
              value: phone,
              onTap: () => _navigateToDetailScreen(context, name, phone, email, location),
            ),
            ProfileDetail(
              icon: Icons.email,
              label: "Gmail",
              value: email,
              onTap: () => _navigateToDetailScreen(context, name, phone, email, location),
            ),
            ProfileDetail(
              icon: Icons.location_on,
              label: "Location",
              value: location,
              onTap: () => _navigateToDetailScreen(context, name, phone, email, location),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetailScreen(BuildContext context, String name, String phone, String email, String location) {
    // TODO: Replace with actual ProfileDetailScreen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Profile Detail")),
          body: Center(child: Text("Details for $name")),
        ),
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const ProfileDetail({super.key, required this.icon, required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}
