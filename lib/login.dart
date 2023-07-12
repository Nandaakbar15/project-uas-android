import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:project_uas/views/home.dart';
import 'package:project_uas/views/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  showLoaderDialog(BuildContext context, int _period) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        _timer = Timer(Duration(seconds: _period), () {
          Navigator.of(context).pop();
        });
        return alert;
      },
    ).then((value) => {_timer?.cancel()});
  }

  void login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if ((username == "") || (password == "")) {
      Fluttertoast.showToast(
          msg: "Username dan password tidak boleh kosong",
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Color.fromARGB(255, 155, 168, 6),
          textColor: Colors.white);
      return;
    }
    showLoaderDialog(context, 30);
    final response = await http.post(
        Uri.parse("https://gamerstoreapi.000webhostapp.com/login.php"),
        body: jsonEncode({"username": username, "password": password}));

    int statCode = response.statusCode;

    showLoaderDialog(context, 30);
    if (statCode == 200) {
      Navigator.pop(context);
      bool _isLogin = true;
      String dataLogin = response.body;
      final data = jsonDecode(dataLogin);
      String resStatus = data["message"];

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Login Berhasil"),
              content: Text("Selamat datang $username"),
// backgroundColor: Colors.red[400],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.green,
                          onSurface: Colors.grey,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HalamanUtama()));
                        },
                        child: const Text("OK")),
                  ),
                )
              ],
            );
          });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Login gagal"),
              content: const Text(
                  "Username atau Password salah.\r\nSilahkan coba lagi!"),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              actions: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HalamanUtama()));
                        },
                        child: const Text("OK")),
                  ),
                )
              ],
            );
          });
    }
  }

  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "GAMESTORE APP",
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
              Image.asset(
                "assets/images/gamelogo.png",
                height: 90,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 14)),
                  const Text(
                    "Username",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
              TextField(
                controller: _usernameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter username",
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.only(left: 14)),
                  const Text(
                    "Password",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Enter Password",
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  onPressed: () {
                    login(context);
                  },
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  )),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun? Register dulu",
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      )
                    ],
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()));
                      },
                      child: const Text(
                        "REGISTER",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
