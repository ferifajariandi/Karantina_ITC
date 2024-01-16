import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'color.dart';
import 'halaman_karantina.dart';
import 'package:file_picker/file_picker.dart';

class TambahKarantina extends StatefulWidget {
  const TambahKarantina({Key? key}) : super(key: key);

  @override
  _TambahKarantinaState createState() => _TambahKarantinaState();
}

class _TambahKarantinaState extends State<TambahKarantina> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_karantina = TextEditingController();
  TextEditingController nama_perusahaan = TextEditingController();
  TextEditingController alamat_perusahaan = TextEditingController();
  TextEditingController nomor_permohonan = TextEditingController();
  TextEditingController alamat_domisili = TextEditingController();

  File? _pickedFile;

  Future _simpan() async {
    final response = await http.post(
      Uri.parse('http://10.1.104.177/api_karantina/create.php'),
      body: {
        'id_karantina': id_karantina.text,
        'nama_perusahaan': nama_perusahaan.text,
        'alamat_perusahaan': alamat_perusahaan.text,
        'nomor_permohonan': nomor_permohonan.text,
        'alamat_domisili': alamat_domisili.text,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['pesan'] == 'Sukses') {
        return true;
      }
    }
    return false;
  }

  // Fungsi untuk memilih file PDF
  Future _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: const Text(
            'Tambah Karantina',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Colors.deepOrange,
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
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
                        return "nama karantina tidak boleh kosong!";
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: alamat_perusahaan,
                    decoration: InputDecoration(
                        hintText: 'Alamat Perusahaan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Alamat karantina tidak boleh kosong!";
                      }
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
                    height: 10,
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
                    height: 10,
                  ),
        
                  // Tambahkan Button untuk memilih file PDF
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "*Upload surat permohonan",
                        style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                      ),
                      ElevatedButton(
                        onPressed: _pickPDF,
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                        ),
                        child: Text(
                          "Pilih PDF",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
        // Menampilkan nama file yang dipilih
                  _pickedFile != null
                      ? Text(_pickedFile!.path)
                      : SizedBox.shrink(),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "*Upload akte perusahaan",
                        style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                      ),
                      ElevatedButton(
                        onPressed: _pickPDF,
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                        ),
                        child: Text(
                          "Pilih PDF",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Menampilkan nama file yang dipilih
                  _pickedFile != null
                      ? Text(_pickedFile!.path)
                      : SizedBox.shrink(),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "*Upload KTP",
                        style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                      ),
                      ElevatedButton(
                        onPressed: _pickPDF,
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                        ),
                        child: Text(
                          "Pilih PDF",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Menampilkan nama file yang dipilih
                  _pickedFile != null
                      ? Text(_pickedFile!.path)
                      : SizedBox.shrink(),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "*Upload NPWP",
                        style: TextStyle(fontSize: 16, color: Colors.deepOrange),
                      ),
                      ElevatedButton(
                        onPressed: _pickPDF,
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primaryColor,
                        ),
                        child: Text(
                          "Pilih PDF",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Menampilkan nama file yang dipilih
                  _pickedFile != null
                      ? Text(_pickedFile!.path)
                      : SizedBox.shrink(),
                  const SizedBox(height: 10),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _simpan().then((value) {
                          if (value) {
                            final snackbar = const SnackBar(
                              content: Text('Data berhasil disimpan'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          } else {
                            final snackbar = SnackBar(
                              content: const Text('Data gagal disimpan'),
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
                      'Simpan',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
