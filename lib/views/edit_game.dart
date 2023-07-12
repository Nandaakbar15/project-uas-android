import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project_uas/models/games.dart';

import '../models/games.dart';
import '../viewmodels/games_vm.dart';
import '../views/views_games.dart';

class EditGamesPage extends StatefulWidget {
  const EditGamesPage({Key? key, required this.game}) : super(key: key);
  final GamesModel game;
  @override
// ignore: no_logic_in_create_state
  State<EditGamesPage> createState() => _EditGamesPageState(game);
}

class _EditGamesPageState extends State<EditGamesPage> {
  GamesModel? game;
  _EditGamesPageState(this.game);

  late final TextEditingController _textIDGameController =
      TextEditingController();
  late final TextEditingController _textNamaGameController =
      TextEditingController();
  late final TextEditingController _textTglRilisController =
      TextEditingController();
  late final TextEditingController _textPublisherController =
      TextEditingController();
  late final TextEditingController _textHargaController =
      TextEditingController();
  late final TextEditingController _textDeskripsiController =
      TextEditingController();
  late final TextEditingController _textPlatformController =
      TextEditingController();

  late String nama_game = "",
      tgl_rilis = "",
      publisher = "",
      harga = "",
      deskrpisi = "",
      platform = "";

  @override
  void initState() {
    super.initState();
    _textIDGameController.text = game!.idGame;
    _textNamaGameController.text = game!.namaGame;
    _textPublisherController.text = game!.publisher;
    _textHargaController.text = game!.harga;
    _textDeskripsiController.text = game!.deskripsi;
    _textPlatformController.text = game!.platform;
    nama_game = game!.namaGame;
    tgl_rilis = game!.tanggalRilis;
    publisher = game!.publisher;
    harga = game!.harga;
    deskrpisi = game!.deskripsi;
    platform = game!.platform;
  }

  updateGame() async {
    if ((nama_game == "") ||
        (tgl_rilis == "") ||
        (publisher == "") ||
        (harga == "") ||
        (deskrpisi == "") ||
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
          .editGames(game!.idGame, nama_game, tgl_rilis, publisher, harga,
              deskrpisi, platform)
          .then((value) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Status Edit data"),
              content: Text("Data berhasil di edit!"),
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
              title: Text("Edit Data error"),
              content: Text("Data gagal diedit!"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Data",
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
                    "ID Game",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _textIDGameController,
                enabled: false,
                onChanged: (e) => nama_game = e,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.blue,
                    filled: true),
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
                controller: _textNamaGameController,
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
                    "Pengembang",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              TextField(
                controller: _textPublisherController,
                onChanged: (e) => publisher = e,
                decoration: InputDecoration(
                    fillColor: Colors.blue,
                    filled: true,
                    hintText: "Publisher",
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
                controller: _textHargaController,
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
                controller: _textDeskripsiController,
                onChanged: (e) => deskrpisi = e,
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
                controller: _textPlatformController,
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
                    updateGame();
                  },
                  child: const Text("Edit")),
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
