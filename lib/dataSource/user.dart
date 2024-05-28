import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_login/component/showAlertDialog.dart';

final _dio = Dio();
final _storage = GetStorage();
final _apiUrl = 'https://mobileapis.manpits.xyz/api';

Future<void> registerUser(
    TextEditingController formName,
    TextEditingController formEmail,
    TextEditingController formPassword,
    TextEditingController formConfirmPassword,
    BuildContext context) async {
  if (formName.text.isEmpty ||
      formEmail.text.isEmpty ||
      formPassword.text.isEmpty ||
      formConfirmPassword.text.isEmpty) {
    showAlertDialog(context, "Error", "Harap mengisi setiap kolom data anda");
    return;
  }

  if (!EmailValidator.validate(formEmail.text)) {
    showAlertDialog(context, "Error", "Email tidak benar");
    return;
  }

  if (formPassword.text != formConfirmPassword.text) {
    showAlertDialog(context, "Error", "Password tidak sama");
    return;
  }

  if (formPassword.text.length < 8) {
    showAlertDialog(context, "Error", "Password minimal 8 karakter");
    return;
  }

  try {
    final _response = await _dio.post(
      '${_apiUrl}/register',
      data: {
        'name': formName.text,
        'email': formEmail.text,
        'password': formPassword.text
      },
    );

    if (!_response.data['success']) {
      showAlertDialog(context, "Error", "${_response.data['message']}");
      return;
    }

    loginUser(formEmail, formPassword, context);
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode! < 500) {
      String errorMessage = "";
      if (e.response!.data != null && e.response!.data['message'] != null) {
        var message = e.response!.data['message'];
        if (message is Map && message.isNotEmpty) {
          var firstMessage = message.values.first;
          if (firstMessage is List && firstMessage.isNotEmpty) {
            errorMessage = firstMessage[0];
          }
        }
      }
      showAlertDialog(context, "Error", errorMessage);
    } else {
      showAlertDialog(context, "Error", "Internal Server Error");
    }
    return;
  }
}

Future<void> loginUser(TextEditingController formEmail,
    TextEditingController formPassword, BuildContext context) async {
  if (formEmail.text.isEmpty || formPassword.text.isEmpty) {
    showAlertDialog(context, "Error", "Harap mengisi setiap kolom data anda");
    return;
  }

  if (!EmailValidator.validate(formEmail.text)) {
    showAlertDialog(context, "Error", "Format email yang Anda masukkan salah");
    return;
  }

  try {
    final _response = await _dio.post('$_apiUrl/login',
        data: {'email': formEmail.text, 'password': formPassword.text});

    if (!_response.data['success']) {
      showAlertDialog(context, "Error", "${_response.data['message']}");
      return;
    }

    _storage.write('token', _response.data['data']['token']);

    final _userInfo = await _dio.get(
      '${_apiUrl}/user',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    print(_response.data);
    _storage.write('id', _userInfo.data['data']['user']['id']);
    _storage.write('email', _userInfo.data['data']['user']['email']);
    _storage.write('name', _userInfo.data['data']['user']['name']);
    print(_storage.read('id'));
    print(_storage.read('email'));
    print(_storage.read('name'));

    formEmail.clear();
    formPassword.clear();
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
    return;
  } on DioException catch (e) {
    if (e.response != null && e.response!.statusCode! < 500) {
      showAlertDialog(
          context, "Error", "Email atau Password yang Anda masukkan salah");
    } else {
      showAlertDialog(context, "Error", "Internal Server Error");
    }
    return;
  }
}

// untuk register user
// void registerUser1(name, email, password, context) async {
//   try {
//     final _register = await _dio.post(
//       '${_apiUrl}/register',
//       data: {'name': name, 'email': email, 'password': password},
//     );
//     final _login = await _dio.post(
//       '${_apiUrl}/login',
//       data: {'email': email, 'password': password},
//     );
//     _storage.write('token', _login.data['data']['token']);
//     print(_register.data);
//     print(_login.data);
//     final _userInfo = await _dio.get(
//       '${_apiUrl}/user',
//       options: Options(
//         headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
//       ),
//     );
//     _storage.write('id', _userInfo.data['data']['user']['id']);
//     _storage.write('email', _userInfo.data['data']['user']['email']);
//     _storage.write('name', _userInfo.data['data']['user']['name']);
//     print(_storage.read('id'));
//     print(_storage.read('email'));
//     print(_storage.read('name'));
//     Navigator.pop(context);
//     Navigator.pushReplacementNamed(context, '/home');
//   } on DioException catch (e) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('close'),
//                 ),
//               ],
//               title: const Text('Error'),
//               content: Text('${e.response?.data['message']}'),
//             ));
//     print('${e.response} - ${e.response?.statusCode}');
//   }
// }

// //untuk login user
// void loginUser1(email, password, context) async {
//   try {
//     final _response = await _dio.post(
//       '${_apiUrl}/login',
//       data: {'email': email, 'password': password},
//     );
//     print(_response.data);
//     _storage.write('token', _response.data['data']['token']);
//     final _userInfo = await _dio.get(
//       '${_apiUrl}/user',
//       options: Options(
//         headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
//       ),
//     );
//     print(_response.data);
//     _storage.write('id', _userInfo.data['data']['user']['id']);
//     _storage.write('email', _userInfo.data['data']['user']['email']);
//     _storage.write('name', _userInfo.data['data']['user']['name']);
//     print(_storage.read('id'));
//     print(_storage.read('email'));
//     print(_storage.read('name'));
//     Navigator.pop(context);
//     Navigator.pushReplacementNamed(context, '/home');
//   } on DioException catch (e) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('close'),
//                 ),
//               ],
//               title: const Text('Error'),
//               content: Text('${e.response?.data['message']}'),
//             ));
//     print('${e.response} - ${e.response?.statusCode}');
//   }
// }

//untuk logout
void logoutUser(context) async {
  try {
    final _response = await _dio.get(
      '${_apiUrl}/logout',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    print(_response.data);
    _storage.erase();
    Navigator.pushReplacementNamed(context, '/');
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}
