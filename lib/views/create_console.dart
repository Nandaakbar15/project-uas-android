import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'views_console.dart';
import '../viewmodels/console_vm.dart';

class CreateConsolePage extends StatefulWidget {
  const CreateConsolePage({super.key});

  @override
  State<CreateConsolePage> createState() => _CreateConsolePageState();
}

class _CreateConsolePageState extends State<CreateConsolePage> {
  late String nama = "", pengembang = "", harga = "";

  void tambahKonsol(BuildContext context) async {
    if ((nama == "") || (pengembang == "") || (harga == "")) {
      Fluttertoast.showToast(
          msg: "Semua Field harus diisi dengan data yang benar!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.yellow[300],
          textColor: Colors.red);
    } else {
      showLoaderDialog(context);
      ConsoleViewModel().createConsole(nama, pengembang, harga).then((value) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Status Tambah data"),
              content: Text("Data berhasil di tambahkan!"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const ConsolePage()),
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
              title: Text("Tambah Data error"),
              content: Text("Data gagal ditambah!"),
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
          "Tambah Data Konsol",
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
                    "Nama Konsol",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (e) => nama = e,
                decoration: InputDecoration(
                    hintText: "Nama Konsol",
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
                    "Pengembang",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                onChanged: (e) => pengembang = e,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    hintText: "Pengembang",
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
                    "Harga",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                onChanged: (e) => harga = e,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    hintText: "Harga",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    tambahKonsol(context);
                  },
                  child: const Text("Tambah")),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      onPressed: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConsolePage()));
                      },
                      child: const Text("Kembali"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
