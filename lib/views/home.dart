import 'package:flutter/material.dart';
import 'package:project_uas/views/views_console.dart';
import 'package:project_uas/views/views_games.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 10),
                Container(
                  height: 200,
                  width: 500,
                  color: Colors.green,
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(bottom: 45)),
                      const Text(
                        "WELCOME",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        "assets/images/joystick.png",
                        alignment: Alignment.centerLeft,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 17),
                Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "WELCOME TO GAMERSTORE",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset(
                              "assets/images/kaitokid.png",
                              alignment: Alignment.centerLeft,
                              width: 99,
                              height: 70,
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 10),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "GAMESTORE adalah toko yang menjual\nkonsol dan game",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  width: 400,
                  height: 135,
                  color: Colors.blue,
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
                      "Buy Now",
                      style: TextStyle(fontSize: 30),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20)),
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConsolePage()));
                      },
                      icon: ImageIcon(
                        AssetImage("assets/images/console.png"),
                        size: 40,
                      ),
                    ),
                    const Text("Console")
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(padding: EdgeInsets.only(left: 20)),
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GamesPage()));
                  },
                  icon: ImageIcon(
                    AssetImage("assets/images/controller.png"),
                    size: 40,
                  ),
                ),
                const Text("Games")
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 136, 113, 55)),
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
}
