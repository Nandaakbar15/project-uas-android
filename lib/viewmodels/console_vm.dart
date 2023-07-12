import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_uas/models/console.dart';

class ConsoleViewModel {
  // menampilkan semua data
  Future getConsoles() async {
    try {
      http.Response hasil = await http.get(
          Uri.parse("https://gamerstoreapi.000webhostapp.com/tampil_konsol.php"),
          headers: {"Accept": "application/json"});
      if (hasil.statusCode == 200) {
// print(hasil.body);
        final data = consoleModelFromJson(hasil.body);
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
  Future createConsole(String nama, String pengembang, String harga) async {
    Map data = {"nama": nama, "pengembang": pengembang, "harga": harga};
    try {
      http.Response hasil = await http.post(
          Uri.parse("https://gamerstoreapi.000webhostapp.com/tambah_konsol.php"),
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
  Future editConsole(
      String idKonsol, String nama, String pengembang, String harga) async {
    Map data = {
      "id_konsol": idKonsol,
      "nama": nama,
      "pengembang": pengembang,
      "harga": harga
    };
    try {
      http.Response hasil = await http.post(
          Uri.parse("https://gamerstoreapi.000webhostapp.com/edit_konsol.php"),
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

  Future deleteConsole(String idKonsol) async {
    Map data = {"id_konsol": idKonsol};
    try {
      http.Response hasil = await http.post(
          Uri.parse("https://gamerstoreapi.000webhostapp.com/hapus_konsol.php"),
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
