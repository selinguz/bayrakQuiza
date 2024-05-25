import 'package:flutter/material.dart';

class SonucEkrani extends StatefulWidget {
  final int dogruSayisi;
  SonucEkrani({super.key, required this.dogruSayisi});

  @override
  State<SonucEkrani> createState() => _SonucEkraniState();
}

class _SonucEkraniState extends State<SonucEkrani> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Sonuç Ekranı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              '${widget.dogruSayisi} Doğru ${5 - widget.dogruSayisi} Yanlış',
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              '% ${(widget.dogruSayisi * 100) ~/ 5} Başarı',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.amber[700],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tekrar Dene'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
