// ignore_for_file: avoid_print, unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_application_login/apiService.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: const UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({super.key});
  @override
  State<StatefulWidget> createState() => _UserList();
}

class _UserList extends State<UserList> {
  static var myList = [];

  void callAPI() async {
    myList = await ApiService.getData();
    print(myList);
  }

  @override
  void initState() {
    super.initState();
    callAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (context, index) {
            return Container(
                child: Text(
              "Id : ${myList[index]['id']}, Name: ${myList[index]['first_name']} ${myList[index]['last_name']}, Email : ${myList[index]['email']}",
            ));
          },
        ));
  }
}
