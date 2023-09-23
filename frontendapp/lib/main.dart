import 'dart:convert';
import 'dart:developer';
import 'package:frontendapp/create.dart';
import 'package:frontendapp/store.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Django Store app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Store> stores = [];
  String url = 'http://127.0.0.1:8000/playground/stores/';

  @override
  void initState() {
    _retrieveStores();
    log("this will log");
    super.initState();
  }

  void _retrieveStores() async {
    stores = [];
    List response = json.decode((await client.get(Uri.parse(url))).body);

    response.forEach((element) {
      stores.add(Store.fromMap(element));
    });
    setState(() {});
    log(stores[0].store);
  }

  void _deleteStore(int id) {
    String newUrl = url + id.toString() + "/delete/";
    client.delete(Uri.parse(newUrl));
    _retrieveStores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveStores();
        },
        child: ListView.builder(
          itemCount: stores.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                title: Text(stores[index].store),
                onTap: () {
                  _retrieveStores();
                },
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _deleteStore(stores[index].id);
                  },
                ));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => CreatePage(
                    client: client,
                  )),
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
