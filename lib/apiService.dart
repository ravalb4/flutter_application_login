import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  onLogin1(name, password) async {
    try {
      var url = Uri.parse('https://reqres.in/api/login');
      Response response = await http.post(url,
          body: {'email': 'eve.holt@reqres.in', 'password': 'cityslicka'});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print('Login Successfull');
        print(data);
      } else {
        print('Login failed');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  onRegister1(name, password) async {
    try {
      var url = Uri.parse('https://reqres.in/api/register');
      Response response =
          await http.post(url, body: {'email': name, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print('Register Successfull');
        print(data);
      } else {
        print('Register failed');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  static Future getData() async {
    Uri request = Uri.parse('https://reqres.in/api/users?page=2');
    var response = await http.get(request);
    var data = json.decode(response.body);
    return data['data'];
  }
}

class User {
  final String avatar;
  final String email;
  final String firstname;
  final String lastname;
  final int id;

  User(this.avatar, this.email, this.firstname, this.lastname, this.id);
}
