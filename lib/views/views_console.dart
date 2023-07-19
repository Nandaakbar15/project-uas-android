import 'package:flutter/material.dart';
import 'package:project_uas/views/home.dart';
import '../models/console.dart';
import '../viewmodels/console_vm.dart';
import 'create_console.dart';
import 'edit_console.dart';

class ConsolePage extends StatefulWidget {
  const ConsolePage({super.key});

  @override
  State<ConsolePage> createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
  List dataConsole = [];
  void getDataConsole() async {
    ConsoleViewModel().getConsoles().then((value) {
      setState(() {
        dataConsole = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataConsole();
  }

  Widget consoleDetail(Console data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 200,
        height: 129,
        child: Card(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      "Nama : ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      data.nama,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Pengembang : ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      data.pengembang,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "harga : ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      data.harga,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                        ),
                        IconButton(
                          onPressed: () {
                            updateConsole(data);
                            // Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.blue,
                        ),
                        IconButton(
                          onPressed: () {
                            deleteConsole(data.idKonsol);
                            // Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // hapus data
  deleteConsole(String idKonsol) {
    ConsoleViewModel()
        .deleteConsole(idKonsol)
        .then((value) => getDataConsole());
  }

  // update data
  updateConsole(Console console) async {
    await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditConsolePage(console: console)));
    getDataConsole();
  }

  showDetailDialog(BuildContext context, Console data) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text("Detail Konsol"),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ID Konsol : ${data.idKonsol}"),
                    Text("Nama : ${data.nama}"),
                    Text("Pengembang : ${data.pengembang}"),
                    Text("Harga : ${data.harga}"),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Console",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "NEWS",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Nintendo akan mengeluarkan\nkonsol baru. Rumornya\nakan dirilis awal tahun 2024",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset(
                            "assets/images/nintendo.png",
                            width: 150,
                            height: 98,
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              height: 178,
              width: 500,
              color: Colors.orange,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {
                          showDetailDialog(context, dataConsole[i]);
                        },
                        child: consoleDetail(dataConsole[i]),
                      );
                    },
                  );
                },
                itemCount: dataConsole == null ? 0 : dataConsole.length,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HalamanUtama()));
                },
                child: const Text("Kembali"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateConsolePage()))
        },
        heroTag: 'createNew',
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
