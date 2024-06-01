import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

final _dio = Dio();
final _storage = GetStorage();
final _apiUrl = 'https://mobileapis.manpits.xyz/api';

void getBanyakAnggota() async {
  int count = 0;
  try {
    final _response = await _dio.get(
      '${_apiUrl}/anggota',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    _storage.write('banyak_anggota', _response.data['data']['anggotas'].length);
    for (var anggota in _response.data['data']['anggotas']) {
      count += 1;

      _storage.write('id_${count}', anggota['id']);
      print(_storage.read('id_${count}'));
    }
    print("panjang anggota: ${_storage.read('banyak_anggota')}");
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

Future<int> getSaldo(id) async {
  int saldo = 0;

  try {
    final _response = await _dio.get(
      '${_apiUrl}/saldo/${id}',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    _storage.write('saldo_${id}', _response.data['data']['saldo']);
    print(_storage.read('saldo_${id}'));
    saldo = _response.data['data']['saldo'];
    return saldo;
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
    return saldo;
  }
}

void iterationSaldo() {
  for (var i = 0; i <= _storage.read('banyak_anggota'); i++) {
    getSaldo(_storage.read('id_${i}'));
  }
}

Future<void> getRiwayat(id) async {
  int count = 0;
  print("masuk getRiwayat");
  try {
    final _response = await _dio.get(
      '${_apiUrl}/tabungan/${id}',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    // _storage.write('riwayat_${id}', _response.data['data']['tabungan']);
    for (var tabungan in _response.data['data']['tabungan']) {
      count += 1;

      _storage.write('id_${count}', tabungan['id']);
      _storage.write('trx_tanggal_${count}', tabungan['trx_tanggal']);
      _storage.write('trx_id_${count}', tabungan['trx_id']);
      _storage.write('trx_nominal_${count}', tabungan['trx_nominal']);
    }
    _storage.write('banyak_riwayat', count);
    print(_storage.read('banyak_riwayat'));
    // print(_storage.read('riwayat_${id}'));
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
  }
}

void addTabungan(
    String id, String trx_id, String trx_nominal, BuildContext context) async {
  try {
    final _response = await _dio.post(
      '${_apiUrl}/tabungan',
      data: {'anggota_id': id, 'trx_id': trx_id, 'trx_nominal': trx_nominal},
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    print(_response);
    _storage.remove('saldo_${id}');
    getSaldo(id);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "/home");
  } on DioException catch (e) {
    print('error: ${e.response} - ${e.response?.statusCode}');
  }
}

void addSaldoAwal(
    String id, String trx_id, String trx_nominal, BuildContext context) async {
  try {
    final _response = await _dio.post(
      '${_apiUrl}/tabungan',
      data: {'anggota_id': id, 'trx_id': trx_id, 'trx_nominal': trx_nominal},
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    print(_response);
    _storage.remove('saldo_${id}');
    getSaldo(id);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "/home");
  } on DioException catch (e) {
    print('error: ${e.response} - ${e.response?.statusCode}');
  }
}
