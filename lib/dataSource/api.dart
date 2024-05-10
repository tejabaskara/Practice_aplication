import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

final _dio = Dio();
final _storage = GetStorage();
final _apiUrl = 'https://mobileapis.manpits.xyz/api';

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

void getAnggota() async {
  try {
    int count = 0;
    final _response = await _dio.get(
      '${_apiUrl}/anggota',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    _storage.write('anggotas', _response.data['data']['anggotas']);
    for (var anggota in _response.data['data']['anggotas']) {
      count += 1;

      _storage.write('id_${count}', anggota['id']);
      _storage.write('nomor_induk_${count}', anggota['nomor_induk']);
      _storage.write('telepon_${count}', anggota['telepon']);
      _storage.write('status_aktif_${count}', anggota['status_aktif']);
      _storage.write('nama_${count}', anggota['nama']);
      _storage.write('alamat_${count}', anggota['alamat']);
      _storage.write('tgl_lahir_${count}', anggota['tgl_lahir']);
      _storage.write('image_url_${count}', anggota['image_url']);

      print(_storage.read('id_${count}'));
      print(_storage.read('nomor_induk_${count}'));
      print(_storage.read('nama_${count}'));
      print(_storage.read('alamat_${count}'));
    }
    _storage.write('index', count);
    print(_storage.read('index'));
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

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
