import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_uas/viewmodels/user_vm.dart';

class UserViewModel {
  // menambah data
  Future createUser(String username, String email, String password) async {
    Map data = {"username": username, "email": email, "password": password};
    try {
      http.Response hasil = await http.post(
          Uri.parse("https://gamerstoreapi.000webhostapp.com/register.php"),
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
