// To parse this JSON data, do
//
//     final consoleModel = consoleModelFromJson(jsonString);

import 'dart:convert';

List<Console> consoleModelFromJson(String str) =>
    List<Console>.from(json.decode(str).map((x) => Console.fromJson(x)));

String consoleModelToJson(List<Console> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Console {
  String idKonsol;
  String nama;
  String pengembang;
  String harga;

  Console({
    required this.idKonsol,
    required this.nama,
    required this.pengembang,
    required this.harga,
  });

  factory Console.fromJson(Map<String, dynamic> json) => Console(
        idKonsol: json["id_konsol"],
        nama: json["nama"],
        pengembang: json["pengembang"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "id_konsol": idKonsol,
        "nama": nama,
        "pengembang": pengembang,
        "harga": harga,
      };
}
