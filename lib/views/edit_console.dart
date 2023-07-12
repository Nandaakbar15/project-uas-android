import 'package:flutter/material.dart';
import 'package:project_uas/models/console.dart';
import 'package:flutter/material.dart';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/console.dart';
import '../viewmodels/console_vm.dart';
import '../views/views_console.dart';

class EditConsolePage extends StatefulWidget {
  const EditConsolePage({Key? key, required this.console}) : super(key: key);
  final Console console;
  @override
// ignore: no_logic_in_create_state
  State<EditConsolePage> createState() => _EditConsolePageState(console);
}

class _EditConsolePageState extends State<EditConsolePage> {
  Console? console;
  _EditConsolePageState(this.console);

  late final TextEditingController _textIDKonsolController =
      TextEditingController();
  late final TextEditingController _textNamaController =
      TextEditingController();
  late final TextEditingController _textPengembangController =
      TextEditingController();
  late final TextEditingController _textHargaController =
      TextEditingController();

  late String nama = "", pengembang = "", harga = "";

  @override
  void initState() {
    super.initState();
    _textIDKonsolController.text = console!.idKonsol;
    _textNamaController.text = console!.nama;
    _textHargaController.text = console!.harga;
    _textPengembangController.text = console!.pengembang;
    nama = console!.nama;
    pengembang = console!.pengembang;
    harga = console!.harga;
  }

  updateConsole() async {
    if ((nama == "") || (pengembang == "") || (harga == "")) {
      Fluttertoast.showToast(
          msg: "Semua Field harus diisi dengan data yang benar!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.yellow[300],
          textColor: Colors.red);
    } else {
      showLoaderDialog(context);
      ConsoleViewModel()
          .editConsole(console!.idKonsol, nama, pengembang, harga)
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
                    "ID Konsol",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _textIDKonsolController,
                enabled: false,
                onChanged: (e) => nama = e,
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
                    "Nama Konsol",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _textNamaController,
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
                controller: _textPengembangController,
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
                controller: _textHargaController,
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
                    updateConsole();
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
