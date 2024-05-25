import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

final _dio = Dio();
final _storage = GetStorage();
final _apiUrl = 'https://mobileapis.manpits.xyz/api';

// untuk register user
void registerUser(name, email, password, context) async {
  try {
    final _register = await _dio.post(
      '${_apiUrl}/register',
      data: {'name': name, 'email': email, 'password': password},
    );
    final _login = await _dio.post(
      '${_apiUrl}/login',
      data: {'email': email, 'password': password},
    );
    _storage.write('token', _login.data['data']['token']);
    print(_register.data);
    print(_login.data);
    final _userInfo = await _dio.get(
      '${_apiUrl}/user',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    _storage.write('id', _userInfo.data['data']['user']['id']);
    _storage.write('email', _userInfo.data['data']['user']['email']);
    _storage.write('name', _userInfo.data['data']['user']['name']);
    print(_storage.read('id'));
    print(_storage.read('email'));
    print(_storage.read('name'));
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

//untuk login user
void loginUser(email, password, context) async {
  try {
    final _response = await _dio.post(
      '${_apiUrl}/login',
      data: {'email': email, 'password': password},
    );
    print(_response.data);
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
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
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
