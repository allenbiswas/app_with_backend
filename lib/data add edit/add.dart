import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/services/api_service.dart';
import 'package:mobile_app/model/model.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final _namecontroller = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _addresscontroller = TextEditingController();

Future<void> _submit() async {
  try {
    final user = UserData(
      name: _namecontroller.text,
      phone: _phonecontroller.text,
      email: _emailcontroller.text,
      address: _addresscontroller.text,
    );

    await postDataFromModel(user);
    context.go('/'); // Go back to Home
  } catch (e) {
    print('Error: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/'),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _namecontroller,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _phonecontroller,
              decoration: InputDecoration(
                labelText: 'Phone No',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailcontroller,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _addresscontroller,
              decoration: InputDecoration(
                labelText: 'Address',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _submit, child: Text("Submit")),
          ],
        ),
      ),
    );
  }
}
