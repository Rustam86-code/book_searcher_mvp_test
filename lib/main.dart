import 'package:flutter/material.dart';
import 'dart:async';
import 'books_model.dart';
import 'books_description.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LibriScreen(),
    );
  }
}

class LibriScreen extends StatefulWidget {
  @override
  _LibriScreenState createState() => _LibriScreenState();
}

class _LibriScreenState extends State<LibriScreen> {
  Icon icon = const Icon(Icons.search);
  Widget widgetSearch = const Text('Books Search');
  String result = '';
  List<Books> books = <Books>[];

  // @override
  // void initState() {
  //   getBooks('Books');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widgetSearch,
          actions: [
            IconButton(
              icon: icon,
              onPressed: () {
                setState(() {
                  if (this.icon.icon == Icons.search) {
                    this.icon = const Icon(Icons.cancel);
                    this.widgetSearch = TextField(
                      textInputAction: TextInputAction.search,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                      onSubmitted: (t) => getBooks(t),
                    );
                  } else {
                    setState(() {
                      this.icon = const Icon(Icons.search);
                      this.widgetSearch = const Text('Book Search');
                    });
                  }
                });
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: books.length,
          itemBuilder: ((BuildContext ctx, int pos) {
            return Card(
              elevation: 2,
              child: ListTile(
                  onTap: () {
                    MaterialPageRoute route = MaterialPageRoute(
                        builder: (_) => BookDetail(books[pos]));
                    Navigator.push(context, route);
                  },
                  leading: Image.network(books[pos].image!),
                  title: Text(books[pos].title!),
                  subtitle: Text(books[pos].subtitle!)),
            );
          }),
        ));
  }

  Future getBooks(String text) async {
    final String urlList = 'https://api.itbook.store/1.0/search/' + text;
    var url = Uri.parse(urlList);
    try {
      http.get(url).then((res) {
        final restJson = json.decode(res.body);
        final bookMap = restJson['books'];
        books = bookMap.map<Books>((e) => Books.fromJson(e)).toList();
        setState(() {
          result = res.body;
        });
      });
    } catch (err) {
      setState(() {
        result = 'not found book';
      });
    }

    setState(() {
      result = 'Download data';
    });
  }
}
