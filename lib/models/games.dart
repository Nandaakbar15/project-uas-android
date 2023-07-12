// To parse this JSON data, do
//
//     final gamesModel = gamesModelFromJson(jsonString);

import 'dart:convert';

List<GamesModel> gamesModelFromJson(String str) =>
    List<GamesModel>.from(json.decode(str).map((x) => GamesModel.fromJson(x)));

String gamesModelToJson(List<GamesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GamesModel {
  String idGame;
  String namaGame;
  String tanggalRilis;
  String publisher;
  String harga;
  String deskripsi;
  String platform;

  GamesModel({
    required this.idGame,
    required this.namaGame,
    required this.tanggalRilis,
    required this.publisher,
    required this.harga,
    required this.deskripsi,
    required this.platform,
  });

  factory GamesModel.fromJson(Map<String, dynamic> json) => GamesModel(
        idGame: json["id_game"],
        namaGame: json["nama_game"],
        tanggalRilis: json["tanggal_rilis"],
        publisher: json["publisher"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
        platform: json["platform"],
      );

  Map<String, dynamic> toJson() => {
        "id_game": idGame,
        "nama_game": namaGame,
        "tanggal_rilis": tanggalRilis,
        "publisher": publisher,
        "harga": harga,
        "deskripsi": deskripsi,
        "platform": platform,
      };
}
