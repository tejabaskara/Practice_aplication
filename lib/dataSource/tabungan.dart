import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_login/component/dialogBox.dart';
import 'package:tugas_login/screen/anggota/detailAnggota.dart';

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

void addTabungan(
  Map<String, dynamic> anggotaDetail,
  int formTrxJenis_id,
  TextEditingController formTrx_nominal,
  BuildContext context,
) async {
  try {
    final _response = await _dio.post(
      '${_apiUrl}/tabungan',
      data: {
        'anggota_id': anggotaDetail['id'].toString(),
        'trx_id': formTrxJenis_id.toString(),
        'trx_nominal': formTrx_nominal.text
      },
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    anggotaDetail['saldo'] = await getSaldo(anggotaDetail['id']);
    print(_response);
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return detailAnggotaPage(
          anggotaDetail: anggotaDetail,
        );
      },
    ));
  } on DioException catch (e) {
    showAlertDialog(context, "Error", "something went wrong");
    return;
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

Future<List<Map<String, dynamic>>> getAllTrxMember(
    BuildContext context, String memberId) async {
  List<Map<String, dynamic>> trxHistories = [];

  try {
    final response = await _dio.get(
      '$_apiUrl/tabungan/$memberId',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );

    trxHistories =
        List<Map<String, dynamic>>.from(response.data['data']['tabungan']);
    return trxHistories;
  } on DioException catch (e) {
    if (e.response!.statusCode! < 500) {
      showAlertDialog(context, "Error",
          "Terjadi kesalahan saat mendapatkan histori transaksi member, coba ulang");
    } else {
      showAlertDialog(context, "Error", "Internal Server Error");
    }
  }

  return trxHistories;
}

Future<List<Map<String, dynamic>>> getTrxType(BuildContext context) async {
  List<Map<String, dynamic>> trxType = [];

  try {
    final response = await _dio.get(
      '$_apiUrl/jenistransaksi',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );

    trxType = List<Map<String, dynamic>>.from(
        response.data['data']['jenistransaksi']);
    return trxType;
  } on DioException catch (e) {
    if (e.response!.statusCode! < 500) {
      showAlertDialog(context, "Error",
          "Terjadi kesalahan saat mendapatkan data jenis transaksi, coba ulang");
    } else {
      showAlertDialog(context, "Error", "Internal Server Error");
    }
  }
  return trxType;
}
