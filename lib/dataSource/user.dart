import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_login/component/dialogBox.dart';

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
