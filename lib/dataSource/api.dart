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

//untuk mendapatkan data anggota dari API
Future<void> getAnggota() async {
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
    _storage.write('banyak_anggota', count);
    print(_storage.read('banyak_anggota'));
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

//untuk mendapatkan data anggota dari API dan digunakan pada saat edit anggota
void getEditAnggotaDetail(context, id) async {
  try {
    final _response = await _dio.get(
      '${_apiUrl}/anggota/${id}',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    _storage.write('anggotaId', _response.data['data']['anggota']['id']);
    _storage.write('anggota_nomor_induk',
        _response.data['data']['anggota']['nomor_induk']);
    _storage.write(
        'anggota_telepon', _response.data['data']['anggota']['telepon']);
    _storage.write('anggota_status_aktif',
        _response.data['data']['anggota']['status_aktif']);
    _storage.write('anggota_nama', _response.data['data']['anggota']['nama']);
    _storage.write(
        'anggota_alamat', _response.data['data']['anggota']['alamat']);
    _storage.write(
        'anggota_tgl_lahir', _response.data['data']['anggota']['tgl_lahir']);
    Navigator.pushNamed(context, '/editAnggota');
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

//untuk membuat anggota baru
void createAnggota(context, nomer_induk, telepon, status_aktif, nama, alamat,
    tgl_lahir) async {
  print('createAnggota');
  print('nomer_induk: ${nomer_induk}');
  print('telepon: ${telepon}');
  print('status_aktif: ${status_aktif}');
  print('nama: ${nama}');
  print('alamat: ${alamat}');
  print('tgl_lahir: ${tgl_lahir}');
  try {
    final _response = await _dio.post(
      '${_apiUrl}/anggota',
      data: {
        'nomor_induk': nomer_induk,
        'nama': nama,
        'alamat': alamat,
        'tgl_lahir': tgl_lahir,
        'telepon': telepon,
        'status_aktif': status_aktif,
      },
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    print(_response.data);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/anggota');
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

//untuk mengirim data yang telah diedit ke API
void editAnggota(context, id, nomer_induk, telepon, status_aktif, nama, alamat,
    tgl_lahir) async {
  print('editAnggota');
  print('id: ${id}');
  print('nomer_induk: ${nomer_induk}');
  print('telepon: ${telepon}');
  print('status_aktif: ${status_aktif}');
  print('nama: ${nama}');
  print('alamat: ${alamat}');
  print('tgl_lahir: ${tgl_lahir}');
  try {
    final _response = await _dio.put(
      '${_apiUrl}/anggota/${id}',
      data: {
        'nomor_induk': nomer_induk,
        'nama': nama,
        'alamat': alamat,
        'tgl_lahir': tgl_lahir,
        'telepon': telepon,
        'status_aktif': status_aktif,
      },
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    print(_response.data);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/anggota');
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

//untuk menghapus anggota
void deleteUser(context, id) async {
  try {
    final _response = await _dio.delete(
      '${_apiUrl}/anggota/${id}',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    print(_response.data);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/anggota');
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
