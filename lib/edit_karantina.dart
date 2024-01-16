import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'halaman_karantina.dart';

class EditKarantina extends StatefulWidget {
  final Map ListData;

  const EditKarantina({Key? key, required this.ListData}) : super(key: key);

  @override
  _EditKarantinaState createState() => _EditKarantinaState();
}

class _EditKarantinaState extends State<EditKarantina> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_karantina = TextEditingController();
  TextEditingController nama_perusahaan = TextEditingController();
  TextEditingController alamat_perusahaan = TextEditingController();
  TextEditingController nomor_permohonan = TextEditingController();
  TextEditingController alamat_domisili = TextEditingController();

  Future _edit() async {
    final response = await http.post(
      Uri.parse('http://10.1.104.177/api_karantina/edit.php'),
      body: {
        'id_karantina': id_karantina.text,
        'nama_perusahaan': nama_perusahaan.text,
        'alamat_perusahaan': alamat_perusahaan.text,
        'nomor_permohonan': nomor_permohonan.text,
        'alamat_domisili': alamat_domisili.text,
      },
    );

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id_karantina.text = widget.ListData['id_karantina'];
    nama_perusahaan.text = widget.ListData['nama_perusahaan'];
    alamat_perusahaan.text = widget.ListData['alamat_perusahaan'];
    nomor_permohonan.text = widget.ListData['nomor_permohonan'];
    alamat_domisili.text = widget.ListData['alamat_domisili'];
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: const Text(
            'Ubah Data Karantina',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                    controller: id_karantina,
                    decoration: InputDecoration(
                        hintText: 'ID Karantina',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "ID karantina tidak boleh kosong!";
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nama_perusahaan,
                  decoration: InputDecoration(
                      hintText: 'Nama Perusahaan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "nama perusahaan tidak boleh kosong!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: alamat_perusahaan,
                  decoration: InputDecoration(
                      hintText: 'Lama Karantina',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "lama karantina tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nomor_permohonan,
                  decoration: InputDecoration(
                      hintText: 'Nomor Permohonan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nomor permohonan tidak boleh kosong!";
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: alamat_domisili,
                  decoration: InputDecoration(
                      hintText: 'Alamat Domisili',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Alamat domisili tidak boleh kosong!";
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      _edit().then((value) {
                        if (value) {
                          final snackbar = const SnackBar(
                            content: Text('Data berhasil diubah'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        } else {
                          final snackbar = SnackBar(
                            content: const Text('Data gagal diubah'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HalamanKarantina())),
                          (route) => false);
                    }
                  },
                  child: Text(
                    'Ubah data',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
