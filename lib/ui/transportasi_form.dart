import 'package:flutter/material.dart';
import '/bloc/transportasi_bloc.dart';
import '/widget/warning_dialog.dart';
import '/widget/success_dialog.dart';
import '/model/transportasi.dart';
import 'transportasi_page.dart';

// ignore: must_be_immutable
class TransportasiForm extends StatefulWidget {
  Transportasi? transportasi;
  TransportasiForm({Key? key, this.transportasi}) : super(key: key);
  @override
  _TransportasiFormState createState() => _TransportasiFormState();
}

class _TransportasiFormState extends State<TransportasiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TRANSPORTASI";
  String tombolSubmit = "SIMPAN";
  final _vehicleTextboxController = TextEditingController();
  final _companyTextboxController = TextEditingController();
  final _capacityTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.transportasi != null) {
      setState(() {
        judul = "UBAH TRANSPORTASI";
        tombolSubmit = "UBAH";
        _vehicleTextboxController.text = widget.transportasi!.vehicle!;
        _companyTextboxController.text = widget.transportasi!.company!;
        _capacityTextboxController.text = widget.transportasi!.capacity.toString();
      });
    } else {
      judul = "TAMBAH TRANSPORTASI";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul), backgroundColor: Colors.cyan[100], actions: [
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const TransportasiPage()));
          },
        )
      ]),
      body: Container(
        color: Colors.cyan[50],
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _vehicleTextField(),
                  SizedBox(height: 16),
                  _companyTextField(),
                  SizedBox(height: 16),
                  _capacityTextField(),
                  SizedBox(height: 32),
                  _buttonSubmit(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _vehicleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Transportasi",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      controller: _vehicleTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Transportasi harus diisi";
        }
        return null;
      },
    );
  }

  Widget _companyTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Company",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.text,
      controller: _companyTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Company harus diisi";
        }
        return null;
      },
    );
  }

  Widget _capacityTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Kapasitas Transportasi",
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      controller: _capacityTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kapasitas Transportasi harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.transportasi != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Transportasi createTransportasi = Transportasi(id: null);
    createTransportasi.vehicle = _vehicleTextboxController.text;
    createTransportasi.company = _companyTextboxController.text;
    createTransportasi.capacity = int.parse(_capacityTextboxController.text);
    TransportasiBloc.addTransportasi(transportasi: createTransportasi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TransportasiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Transportasi updateTransportasi = Transportasi(id: widget.transportasi!.id!);
    updateTransportasi.vehicle = _vehicleTextboxController.text;
    updateTransportasi.company = _companyTextboxController.text;
    updateTransportasi.capacity = int.parse(_capacityTextboxController.text);
    TransportasiBloc.updateTransportasi(transportasi: updateTransportasi).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const TransportasiPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
