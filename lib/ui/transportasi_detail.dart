import 'package:flutter/material.dart';
import '/bloc/transportasi_bloc.dart';
import '/widget/warning_dialog.dart';
import '/model/transportasi.dart';
import '/ui/transportasi_form.dart';
import 'transportasi_page.dart';

// ignore: must_be_immutable
class TransportasiDetail extends StatefulWidget {
  Transportasi? transportasi;

  TransportasiDetail({Key? key, this.transportasi}) : super(key: key);

  @override
  _TransportasiDetailState createState() => _TransportasiDetailState();
}

class _TransportasiDetailState extends State<TransportasiDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Transportasi'),
      ),
      body: Container(
        color: Colors.pink[50], // Background color pink
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text(
                widget.transportasi!.vehicle!,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Text(
                widget.transportasi!.company!,
                style: const TextStyle(fontSize: 20, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              Text(
                widget.transportasi!.capacity.toString(),
                style: const TextStyle(fontSize: 20, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              _tombolHapusEdit()
            ],
          ),
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue),
          ),
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransportasiForm(
                  transportasi: widget.transportasi!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 10),
        // Tombol Hapus
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            TransportasiBloc.deleteTransportasi(id: widget.transportasi!.id!).then(
                (value) => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TransportasiPage()))
                    }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                        description: "Hapus gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(builder: (context) => alertDialog, context: context);
  }
}
