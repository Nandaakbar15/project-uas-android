import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:project_uas/views/home.dart';
import '../models/games.dart';
import '../viewmodels/games_vm.dart';
import 'create_game.dart';
import 'edit_game.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  List dataGames = [];

  // get game => null;
  void getDataGames() async {
    GamesViewModel().getGames().then((value) {
      setState(() {
        dataGames = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataGames();
  }

  Widget gamesDetail(GamesModel data) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        width: 200,
        height: 155,
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
                      "Nama Game : ",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      data.namaGame,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Tanggal Rilis : ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      data.tanggalRilis,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Publisher : ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      data.publisher,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "Harga : ",
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
                Row(
                  children: [
                    const Text(
                      "platform : ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      data.platform,
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
                            deleteGames(data.idGame);
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
  deleteGames(String idKonsol) {
    GamesViewModel().deleteGames(idKonsol).then((value) => getDataGames());
  }

  // update data
  updateConsole(GamesModel game) async {
    await Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => EditGamesPage(game: game)));
    getDataGames();
  }

  showDetailDialog(BuildContext context, GamesModel data) {
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
                    Text("ID Game : ${data.idGame}"),
                    Text("Nama : ${data.namaGame}"),
                    Text("Tanggal rilis : ${data.tanggalRilis}"),
                    Text("Publisher : ${data.publisher}"),
                    Text("Harga : ${data.harga}"),
                    Text("Deskripsi : ${data.deskripsi}"),
                    Text("Platform : ${data.platform}"),
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
          "Games",
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
                            "Persona 3 Reload akan\ndi rilis awal tahun 2024",
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
                            "assets/images/persona3reload.png",
                            width: 150,
                            height: 100,
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
                          showDetailDialog(context, dataGames[i]);
                        },
                        child: gamesDetail(dataGames[i]),
                      );
                    },
                  );
                },
                itemCount: dataGames == null ? 0 : dataGames.length,
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreateGamesPage()))
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
