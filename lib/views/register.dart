import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:project_uas/views/home.dart';
import '../viewmodels/user_vm.dart';
import '../login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String username = "", email = "", password = "";
  // final TextEditingController _usernameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passwordController = TextEditingController();
  // Timer? _timer;

  void register(BuildContext context) async {
    if ((username == "") || (email == "") || (password == "")) {
      Fluttertoast.showToast(
          msg: "Semua Field harus diisi dengan data yang benar!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.yellow[300],
          textColor: Colors.red);
    } else {
      showLoaderDialog(context);
      UserViewModel().createUser(username, email, password).then((value) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Register Status"),
              content: Text("Register User baru telah berhasil didaftarkan"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }).catchError((error) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Register Error"),
              content: Text("Register User baru gagal"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      });
    }
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading..."),
          )
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: const Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      )),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nama",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (e) => username = e,
                decoration: InputDecoration(
                    hintText: "Nama",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.blue,
                    filled: true),
              ),
              SizedBox(
                height: 19,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                onChanged: (e) => email = e,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              SizedBox(
                height: 19,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Password",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                onChanged: (e) => password = e,
                obscureText: true,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    register(context);
                  },
                  child: const Text("Register")),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 70)),
                      const Text("Sudah punya Akun? Langsung Login aja")
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('/lib/login.dart'));
                      },
                      child: const Text("Login"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
