import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_app/model/model.dart';
import 'package:mobile_app/model/user_model.dart';

//FOR ANDROID EMULATOR
const String baseUrl = "http://10.0.2.2:5000/api/data";
const String authUrl = "http://10.0.2.2:5000/api/auth";

//FOR WEB
// const String baseUrl = "http://localhost:5000/api/data";
// const String authUrl = "http://localhost:5000/api/auth";

class AuthResponse {
  final String token;
  final UserModel user;

  AuthResponse({required this.token, required this.user});
}

Future<AuthResponse> loginUser(String email, String password) async {
  final res = await http.post(
    Uri.parse('$authUrl/login'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      'email': email,
      'password': password,
    }),
  );

  if (res.statusCode == 200) {
    final data = jsonDecode(res.body);
    final token = data['token'];
    final user = UserModel.fromJson(data['user'] ?? {}); 

    return AuthResponse(token: token, user: user);
  } else {
    throw Exception("Failed to login: ${jsonDecode(res.body)['message']}");
  }
}

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


