// ignore_for_file: sort_child_properties_last, use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_login/dashboard.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'Register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  onLogin(name, password) async {
    try {
      var url = Uri.parse('https://reqres.in/api/login');
      Response response =
          // await http.post(url,body: {'email': 'eve.holt@reqres.in', 'password': 'cityslicka'});
          await http.post(url, body: {'email': name, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        const snackBar = SnackBar(
          content: Text('Login Successfull'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
        );
      } else {
        const snackBar = SnackBar(
          content: Text('Please Enter Valid Data'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Sign in',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () {
                    onLogin(nameController.text.toString(),
                        passwordController.text.toString());
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Does not have account?'),
                TextButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Register()),
                    );
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Container(
              child: const Text('email : eve.holt@reqres.in'),
            ),
            Container(
              child: const Text('password : cityslicka'),
            ),
          ],
        ));
  }
}
