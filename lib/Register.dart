// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_login/apiService.dart';
import 'package:flutter_application_login/dashboard.dart';
import 'package:flutter_application_login/main.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: MyStatefulWidgedR(),
    );
  }
}

class MyStatefulWidgedR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => __MyStatefulWidgetState();
}

class __MyStatefulWidgetState extends State<MyStatefulWidgedR> {
  TextEditingController nameControllerr = TextEditingController();
  TextEditingController passwordControllerr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var name = nameControllerr.text.toString();
    var pass = passwordControllerr.text.toString();

    onRegister(name, password) async {
      try {
        var url = Uri.parse('https://reqres.in/api/register');
        Response response =
            await http.post(url, body: {'email': name, 'password': password});
        if (response.statusCode == 200) {
          var data = jsonDecode(response.body.toString());

          const snackBar = SnackBar(
            content: Text('Register Successfull'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Dashboard()));
        } else {
          const snackBar = SnackBar(
            content: Text('Register failed'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return Padding(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: nameControllerr,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: passwordControllerr,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'PassWord',
              ),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: ElevatedButton(
                onPressed: () {
                  onRegister(nameControllerr.text.toString(),
                      passwordControllerr.text.toString());
                },
                child: const Text('Register')),
          ),
          Container(
            child: const Text('email : eve.holt@reqres.in'),
          ),
          Container(
            child: const Text('password : pistol'),
          ),
        ],
      ),
    );
  }
}
