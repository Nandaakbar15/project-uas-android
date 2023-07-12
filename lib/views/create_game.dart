import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:project_uas/views/views_games.dart';

import 'dart:async';
import 'dart:convert';

import 'views_console.dart';
import '../viewmodels/games_vm.dart';

class CreateGamesPage extends StatefulWidget {
  const CreateGamesPage({super.key});

  @override
  State<CreateGamesPage> createState() => _CreateGamesPageState();
}

class _CreateGamesPageState extends State<CreateGamesPage> {
  late String nama_game = "",
      tgl_rilis = "",
      publisher = "",
      harga = "",
      deskripsi = "",
      platform = "";

  void tambahGame(BuildContext context) async {
    if ((nama_game == "") ||
        (tgl_rilis == "") ||
        (publisher == "") ||
        (harga == "") ||
        (deskripsi == "") ||
        (platform == "")) {
      Fluttertoast.showToast(
          msg: "Semua Field harus diisi dengan data yang benar!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.yellow[300],
          textColor: Colors.red);
    } else {
      showLoaderDialog(context);
      GamesViewModel()
          .createGames(
              nama_game, tgl_rilis, publisher, harga, deskripsi, platform)
          .then((value) {
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
                          builder: (context) => const GamesPage()),
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
        title: const Text(
          "Tambah Game",
          style: TextStyle(color: Colors.white),
        ),
      ),
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
                    "Nama Game",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (e) => nama_game = e,
                decoration: InputDecoration(
                    hintText: "Nama Game",
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
                    "Tanggal Rilis",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                onChanged: (e) => tgl_rilis = e,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    hintText: "Tanggal Rilis",
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
                    "Publisher",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                onChanged: (e) => publisher = e,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    hintText: "publisher",
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
              SizedBox(
                height: 19,
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Deskripsi",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                onChanged: (e) => deskripsi = e,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    hintText: "Deskripsi",
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
                    "Platform",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                onChanged: (e) => platform = e,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    hintText: "Platform",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    tambahGame(context);
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
                                builder: (context) => GamesPage()));
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
