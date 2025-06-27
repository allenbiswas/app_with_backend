import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_app/services/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data List"),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          }

          final dataList = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final item = dataList[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () => context.go("/edit/${item['_id']}"),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        item['name']?[0]?.toUpperCase() ?? '?',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      item['name'] ?? 'Unnamed',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("Phone: ${item['phone']}"),
                        Text("Email: ${item['email'] ?? ''}"),
                        Text("Address: ${item['address'] ?? ''}"),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go("/add"),
        label: const Text("Add"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

