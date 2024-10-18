import 'package:flutter/material.dart';
import '/bloc/logout_bloc.dart';
import '/bloc/transportasi_bloc.dart';
import '/model/transportasi.dart';
import '/ui/transportasi_detail.dart';
import '/ui/transportasi_form.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[50],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink[100],
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.pink,
        ),
      ),
      home: const TransportasiPage(),
    );
  }
}

class TransportasiPage extends StatefulWidget {
  const TransportasiPage({Key? key}) : super(key: key);

  @override
  _TransportasiPageState createState() => _TransportasiPageState();
}

class _TransportasiPageState extends State<TransportasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Transportasi'),
        backgroundColor: Colors.pink[100],
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: TransportasiBloc.getTransportasis(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListTransportasi(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TransportasiForm()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ListTransportasi extends StatelessWidget {
  final List? list;

  const ListTransportasi({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemTransportasi(
            transportasi: list![i],
          );
        });
  }
}

class ItemTransportasi extends StatelessWidget {
  final Transportasi transportasi;

  const ItemTransportasi({Key? key, required this.transportasi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TransportasiDetail(
                      transportasi: transportasi,
                    )));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text(
            transportasi.vehicle!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(transportasi.company!),
          trailing: Text(
            transportasi.capacity.toString(),
            style: TextStyle(color: Colors.pink),
          ),
        ),
      ),
    );
  }
}
