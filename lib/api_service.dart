import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app/model.dart';

const String baseUrl = "http://10.0.2.2:5000/api/data";

Future<List<dynamic>> fetchData() async {
  final res = await http.get(Uri.parse(baseUrl));
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  } else {
    throw Exception("Failed to load data");
  }
}

Future<void> postDataFromModel(UserData user) async {
  final res = await http.post(
    Uri.parse(baseUrl),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(user.toJson()),
  );

  if (res.statusCode != 201) {
    throw Exception("Failed to add data");
  }
}


Future<UserData> fetchUserById(String id) async {
  final response = await http.get(Uri.parse('$baseUrl/$id'));
  if (response.statusCode == 200) {
    return UserData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user data');
  }
}

Future<void> updateUser(UserData user) async {
  final res = await http.put(
    Uri.parse('$baseUrl/${user.id}'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(user.toJson()),
  );

  if (res.statusCode != 200) {
    throw Exception("Failed to update data");
  }
}

Future<void> deleteData(String id) async {
  final res = await http.delete(Uri.parse('$baseUrl/$id'));

  if (res.statusCode != 200) {
    throw Exception("Failed to delete data");
  }
}


