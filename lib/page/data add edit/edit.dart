import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/model/model.dart';
import '../../services/api_service.dart';

class EditDetails extends StatefulWidget {
  final String id;

  const EditDetails({super.key, required this.id});

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  late Future<UserData> _futureUser;

  final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureUser = fetchUserById(widget.id);
  }

  Future<void> _update(UserData user) async {
    final updated = UserData(
      id: user.id,
      name: _namecontroller.text,
      phone: _phonecontroller.text,
      email: _emailcontroller.text,
      address: _addresscontroller.text,
    );
    await updateUser(updated);
    context.go('/home');
  }

  Future<void> _delete(UserData user) async {
    await deleteData(user.id!);
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Details"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: FutureBuilder<UserData>(
        future: _futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("No user data"));
          }

          final user = snapshot.data!;
          _namecontroller.text = user.name;
          _phonecontroller.text = user.phone;
          _emailcontroller.text = user.email;
          _addresscontroller.text = user.address;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _phonecontroller,
                  decoration: InputDecoration(
                    labelText: 'Phone No',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _addresscontroller,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                ElevatedButton.icon(
                  onPressed: () => _update(user),
                  icon: Icon(Icons.save, color: Colors.green[900]),
                  label: Text("Update", style: TextStyle(color: Colors.green)),
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () => _delete(user), //_delete(UserData.fromJson(item))
                  icon: Icon(Icons.delete, color: Colors.red),
                  label: Text("Delete", style: TextStyle(color: Colors.red)),
                ),
                  ],
                 )
                
              ],
            ),
          );
        },
      ),
    );
  }
}
