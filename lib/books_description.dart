import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'books_model.dart';

class BookDetail extends StatelessWidget {
  final Books book;
  const BookDetail(this.book, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text(book.title!),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: Image.network(
                      book.image!,
                      alignment: Alignment.center,
                    )), //<= url image
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      book.title!,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          color: Colors.white),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      book.subtitle!,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          color: Colors.white),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      'Price is ${book.price}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      book.url!,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black87),
                    )),
              ],
            ),
          ),
        ));
  }
}
