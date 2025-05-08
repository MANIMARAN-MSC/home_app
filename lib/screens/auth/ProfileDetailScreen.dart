import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        final response = await supabase.from('users').select().eq('id', user.id).maybeSingle();
        if (response != null) {
          setState(() {
            _nameController.text = response['name'] ?? '';
            _emailController.text = user.email ?? '';
            _bioController.text = response['bio'] ?? '';
            _phoneController.text = response['phone'] ?? '';
            _locationController.text = response['location'] ?? '';
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user data: \$e')),
      );
    }
  }

  void _updateProfile(String field, String value) async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        await supabase.from('users').update({
          field: value,
        }).eq('id', user.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('\$field updated successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: \$e')),
      );
    }
  }

  void _showEditDialog(String title, TextEditingController controller, String field) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit \$title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Enter \$title'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateProfile(field, controller.text);
                setState(() {});
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller, String field) {
    return GestureDetector(
      onTap: () => _showEditDialog(label, controller, field),
      child: ListTile(
        title: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(controller.text),
        trailing: Icon(Icons.edit, size: 16, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildEditableField('Name', _nameController, 'name'),
            _buildEditableField('Phone', _phoneController, 'phone'),
            _buildEditableField('Location', _locationController, 'location'),
            ListTile(
              title: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(_emailController.text),
            ),
          ],
        ),
      ),
    );
  }
}