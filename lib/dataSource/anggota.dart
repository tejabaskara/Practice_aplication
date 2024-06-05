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
    if (e.response!.statusCode! < 500) {
      showAlertDialog(context, "Error",
          "Terjadi kesalahan saat mendapatkan data members, coba ulang");
    } else {
      showAlertDialog(context, "Error", "Internal Server Error");
    }
    print('${e.response} - ${e.response?.statusCode}');
    return anggotas;
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
      _storage.write('saldo_${count}', _storage.read('saldo'));

      // print(_storage.read('id_${count}'));
      // print(_storage.read('nomor_induk_${count}'));
      // print(_storage.read('nama_${count}'));
      // print(_storage.read('alamat_${count}'));
      // print(_storage.read('saldo_${anggota['id']}'));
      // print(count);
    }
    _storage.write('banyak_anggota', count);
    print(_storage.read('banyak_anggota'));
    // iterationSaldo();
  } on DioException catch (e) {
    print('${e.response} - ${e.response?.statusCode}');
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
    showAlertDialog(context, "Error", "something went wrong");
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
    print('code 1');
    print(int.parse(formNomerInduk.text));
    print(formNama.text);
    print(formAlamat.text);
    print(formTglLahir.text);
    print(formTelepon.text);
    print(statusAktif);
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
    print('code 2');
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
    print('code 3');

    print(_responseAnggota);

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
    showAlertDialog(context, "Error", "something went wrong");
    return;
  }
}

//untuk mengirim data yang telah diedit ke API
void editAnggota1(context, id, nomer_induk, telepon, status_aktif, nama, alamat,
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
    Navigator.pushReplacementNamed(context, '/home');
  } on DioException catch (e) {
    showAlertDialog(context, "Error", "something went wrong");
  }
}

void getAnggotaDetail(id) async {
  print('masuk getAnggotaDetail');
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
    print(_storage.read('anggotaId'));
  } on DioException catch (e) {
    print('error : ${e.response} - ${e.response?.statusCode}');
  }
}
