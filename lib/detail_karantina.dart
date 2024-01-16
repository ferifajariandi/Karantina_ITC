import 'package:flutter/material.dart';

class DetailKarantina extends StatefulWidget {

  final Map ListData;
  DetailKarantina({Key? key, required this.ListData}) : super(key: key);

  @override
  State<DetailKarantina> createState() => _DetailKarantinaState();
}

class _DetailKarantinaState extends State<DetailKarantina> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id_karantina = TextEditingController();
  TextEditingController nama_perusahaan = TextEditingController();
  TextEditingController alamat_perusahaan = TextEditingController();
  TextEditingController nomor_permohonan = TextEditingController();
  TextEditingController alamat_domisili = TextEditingController();
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
        backgroundColor: Colors.deepOrange,
        title: Center(
          child: Text(
            'Detail Karantina',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('Id karantina'),
                  subtitle: Text(widget.ListData['id_karantina']),
                ),
                ListTile(
                  title: Text('Nama perusahaan'),
                  subtitle: Text(widget.ListData['nama_perusahaan']),
                ),
                ListTile(
                  title: Text('Alamat perusahaan'),
                  subtitle: Text(widget.ListData['alamat_perusahaan']),
                ),
                ListTile(
                  title: Text('nomor_permohonan'),
                  subtitle: Text(widget.ListData['nomor_permohonan']),
                ),
                ListTile(
                  title: Text('alamat_domisili'),
                  subtitle: Text(widget.ListData['alamat_domisili']),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
