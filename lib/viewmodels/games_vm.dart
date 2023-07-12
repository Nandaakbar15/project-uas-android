import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_uas/models/games.dart';

class GamesViewModel {
  Future getGames() async {
    try {
      http.Response hasil = await http.get(
          Uri.parse("https://gamerstoreapi.000webhostapp.com/tampil_game.php"),
          headers: {"Accept": "application/json"});
      if (hasil.statusCode == 200) {
// print(hasil.body);
        final data = gamesModelFromJson(hasil.body);
        return data;
      } else {
// print("error status " + hasil.statusCode.toString());
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // menambah data
  Future createGames(
    String namaGame,
    String tanggalRilis,
    String publisher,
    String harga,
    String deskripsi,
    String platform,
  ) async {
    Map data = {
      "nama_game": namaGame,
      "tanggal_rilis": tanggalRilis,
      "publisher": publisher,
      "harga": harga,
      "deskripsi": deskripsi,
      "platform": platform
    };
    try {
      http.Response hasil = await http.post(
          Uri.parse("https://gamerstoreapi.000webhostapp.com/tambah_game.php"),
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      if (hasil.statusCode == 200) {
        return true;
      } else {
// print("error status " + hasil.statusCode.toString());
        return false;
      }
    } catch (e) {
// print("error catch $e");
      return false;
    }
  }

  // edit data
  Future editGames(
    String idGame,
    String namaGame,
    String tanggalRilis,
    String publisher,
    String harga,
    String deskripsi,
    String platform,
  ) async {
    Map data = {
      "id_game": idGame,
      "nama_game": namaGame,
      "tanggal_rilis": tanggalRilis,
      "harga": harga,
      "deskripsi": deskripsi,
      "platform": platform
    };
    try {
      http.Response hasil = await http.post(
          Uri.parse("https://gamerstoreapi.000webhostapp.com/edit_game.php"),
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      if (hasil.statusCode == 200) {
        return true;
      } else {
// print("error status " + hasil.statusCode.toString());
        return false;
      }
    } catch (e) {
// print("error catch $e");
      return false;
    }
  }

  Future deleteGames(String idGame) async {
    Map data = {"id_game": idGame};
    try {
      http.Response hasil = await http.post(
          Uri.parse("https://gamerstoreapi.000webhostapp.com/hapus_game.php"),
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      if (hasil.statusCode == 200) {
        return true;
      } else {
// print("error status " + hasil.statusCode.toString());
        return false;
      }
    } catch (e) {
// print("error catch $e");
      return false;
    }
  }
}
