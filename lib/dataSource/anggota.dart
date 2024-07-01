import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tugas_login/component/dialogBox.dart';
import 'package:tugas_login/dataSource/tabungan.dart';
import 'package:tugas_login/screen/anggota/detailAnggota.dart';

final _dio = Dio();
final _storage = GetStorage();
final _apiUrl = 'https://mobileapis.manpits.xyz/api';

Future<List<Map<String, dynamic>>> getAllAnggota(BuildContext context) async {
  List<Map<String, dynamic>> anggotas = [];
  // print("masuk getAllAnggota");
  try {
    final _response = await _dio.get(
      '${_apiUrl}/anggota',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    for (var anggota in _response.data['data']['anggotas']) {
      anggotas.add({
        'id': anggota['id'],
        'nomor_induk': anggota['nomor_induk'],
        'telepon': anggota['telepon'],
        'status_aktif': anggota['status_aktif'],
        'nama': anggota['nama'],
        'alamat': anggota['alamat'],
        'tgl_lahir': anggota['tgl_lahir'],
        'image_url': anggota['image_url'],
        'saldo': await getSaldo(anggota['id']),
      });
      print('id: ${anggota['id']}');
    }
    return anggotas;
  } on DioException catch (e) {
    if (e.response!.statusCode! == 406) {
      showAlertDialogExpiredToken(context);
    } else if (e.response!.statusCode! < 500) {
      showAlertDialog(context, "Error",
          "Terjadi kesalahan saat mendapatkan data members, coba ulang");
    } else {
      showAlertDialog(context, "Error", "Internal Server Error");
    }
    print('${e.response} - ${e.response?.statusCode}');
    return anggotas;
  }
}

Future<void> createAnggota(
    TextEditingController formNomerInduk,
    TextEditingController formTelepon,
    int statusAktif,
    TextEditingController formNama,
    TextEditingController formAlamat,
    TextEditingController formTglLahir,
    TextEditingController formSaldo,
    BuildContext context) async {
  if (formNomerInduk.text.isEmpty ||
      formTelepon.text.isEmpty ||
      formNama.text.isEmpty ||
      formAlamat.text.isEmpty ||
      formTglLahir.text.isEmpty) {
    showAlertDialog(context, "Error", "Harap mengisi setiap kolom data anda");
    return;
  }

  try {
    final _anggotas = ValueNotifier<List<Map<String, dynamic>>>([]);
    final anggotas = await getAllAnggota(context);
    _anggotas.value = anggotas;

    for (var anggota in anggotas) {
      if (anggota['nomor_induk'] == int.parse(formNomerInduk.text)) {
        showAlertDialog(context, "Error",
            "Anggota dengan nomor induk ${formNomerInduk.text} sudah ada");
        return;
      }
    }

    final _response = await _dio.post(
      '${_apiUrl}/anggota',
      data: {
        'nomor_induk': int.parse(formNomerInduk.text),
        'nama': formNama.text,
        'alamat': formAlamat.text,
        'tgl_lahir': formTglLahir.text,
        'telepon': formTelepon.text,
        'status_aktif': statusAktif,
      },
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    if (!_response.data['success']) {
      showAlertDialog(context, "Error", "${_response.data['message']}");
      return;
    }

    final _newAnggotas = ValueNotifier<List<Map<String, dynamic>>>([]);
    final newAnggotas = await getAllAnggota(context);
    _newAnggotas.value = newAnggotas;

    for (var newAnggota in newAnggotas) {
      if (newAnggota['nomor_induk'] == int.parse(formNomerInduk.text)) {
        addSaldoAwal(newAnggota['id'].toString(), "1", formSaldo.text, context);
        return;
      }
    }
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/home');
    return;
  } on DioException catch (e) {
    if (e.response!.statusCode! == 406) {
      showAlertDialogExpiredToken(context);
    } else {
      showAlertDialog(context, "Error", "something went wrong");
    }
    return;
  }
}

Future<void> editAnggota(
    String id,
    TextEditingController formNomerInduk,
    TextEditingController formTelepon,
    int statusAktif,
    TextEditingController formNama,
    TextEditingController formAlamat,
    TextEditingController formTglLahir,
    BuildContext context) async {
  if (formNomerInduk.text.isEmpty ||
      formTelepon.text.isEmpty ||
      formNama.text.isEmpty ||
      formAlamat.text.isEmpty ||
      formTglLahir.text.isEmpty) {
    showAlertDialog(context, "Error", "Harap mengisi setiap kolom data anda");
    return;
  }

  try {
    // print('code 1');
    // print(int.parse(formNomerInduk.text));
    // print(formNama.text);
    // print(formAlamat.text);
    // print(formTglLahir.text);
    // print(formTelepon.text);
    // print(statusAktif);
    final _response = await _dio.put(
      '${_apiUrl}/anggota/${id}',
      data: {
        'nomor_induk': int.parse(formNomerInduk.text),
        'nama': formNama.text,
        'alamat': formAlamat.text,
        'tgl_lahir': formTglLahir.text,
        'telepon': formTelepon.text,
        'status_aktif': statusAktif,
      },
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    // print('code 2');
    if (!_response.data['success']) {
      showAlertDialog(context, "Error", "${_response.data['message']}");
      return;
    }

    final anggota = Map<String, dynamic>();
    final _responseAnggota = await _dio.get(
      '${_apiUrl}/anggota/${id}',
      options: Options(
        headers: {'Authorization': 'Bearer ${_storage.read('token')}'},
      ),
    );
    // print('code 3');

    // print(_responseAnggota);

    anggota['id'] = _responseAnggota.data['data']['anggota']['id'];
    anggota['nomor_induk'] =
        _responseAnggota.data['data']['anggota']['nomor_induk'];
    anggota['telepon'] = _responseAnggota.data['data']['anggota']['telepon'];
    anggota['status_aktif'] =
        _responseAnggota.data['data']['anggota']['status_aktif'];
    anggota['nama'] = _responseAnggota.data['data']['anggota']['nama'];
    anggota['alamat'] = _responseAnggota.data['data']['anggota']['alamat'];
    anggota['tgl_lahir'] =
        _responseAnggota.data['data']['anggota']['tgl_lahir'];
    anggota['saldo'] = await getSaldo(anggota['id']);

    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return detailAnggotaPage(
          anggotaDetail: anggota,
        );
      },
    ));
    return;
  } on DioException catch (e) {
    if (e.response!.statusCode! == 406) {
      showAlertDialogExpiredToken(context);
    } else {
      showAlertDialog(context, "Error", "something went wrong");
    }

    return;
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
    Navigator.pushReplacementNamed(context, '/home');
  } on DioException catch (e) {
    showAlertDialog(context, "Error", "something went wrong");
  }
}
