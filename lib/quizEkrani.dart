import 'dart:collection';

import 'package:bayrak_quiz_app/bayraklarDao.dart';
import 'package:bayrak_quiz_app/sonucEkrani.dart';
import 'package:flutter/material.dart';

import 'bayraklar.dart';

class QuizEkrani extends StatefulWidget {
  const QuizEkrani({super.key});

  @override
  State<QuizEkrani> createState() => _QuizEkraniState();
}

class _QuizEkraniState extends State<QuizEkrani> {
  var sorular = <Bayraklar>[];
  var yanlisSecenekler = <Bayraklar>[];
  late Bayraklar dogruSoru;
  var tumSecenekler = HashSet<Bayraklar>();

  int soruSayac = 0;
  int dogruSayac = 0;
  int yanlisSayac = 0;

  String bayrakResimAdi = "placeholder.png";
  String butonAYazi = "";
  String butonBYazi = "";
  String butonCYazi = "";
  String butonDYazi = "";

  @override
  void initState() {
    super.initState();
    sorulariAl();
  }

  Future<void> sorulariAl() async {
    sorular = await BayraklarDao().rastgeleBesBayrakGetir();
    sorulariYukle();
  }

  Future<void> sorulariYukle() async {
    dogruSoru = sorular[soruSayac];
    bayrakResimAdi = dogruSoru.bayrak_resim;
    yanlisSecenekler =
        await BayraklarDao().rastgeleUcYanlisBayrakGetir(dogruSoru.bayrak_id);
    tumSecenekler.clear();
    tumSecenekler.add(dogruSoru);
    tumSecenekler.add(yanlisSecenekler[0]);
    tumSecenekler.add(yanlisSecenekler[1]);
    tumSecenekler.add(yanlisSecenekler[2]);

    butonAYazi = tumSecenekler.elementAt(0).bayrak_ad;
    butonBYazi = tumSecenekler.elementAt(1).bayrak_ad;
    butonCYazi = tumSecenekler.elementAt(2).bayrak_ad;
    butonDYazi = tumSecenekler.elementAt(3).bayrak_ad;

    setState(() {});
  }

  void soruSayacKontrol() {
    soruSayac = soruSayac + 1;
    if (soruSayac != 5) {
      sorulariYukle();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SonucEkrani(dogruSayisi: dogruSayac),
        ),
      );
    }
  }

  void dogruKontrol(String butonYazi) {
    if (dogruSoru.bayrak_ad == butonYazi) {
      dogruSayac = dogruSayac + 1;
    } else {
      yanlisSayac = yanlisSayac + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Quiz Ekranı'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Doğru: $dogruSayac',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Yanlış: $yanlisSayac',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            soruSayac != 5
                ? Text(
                    '${soruSayac + 1}. Soru',
                    style: const TextStyle(fontSize: 18),
                  )
                : const Text(
                    '5. Soru',
                    style: TextStyle(fontSize: 18),
                  ),
            Image.asset('assets/images/$bayrakResimAdi'),
            SizedBox(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  dogruKontrol(butonAYazi);
                  soruSayacKontrol();
                },
                child: Text(butonAYazi),
              ),
            ),
            SizedBox(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  dogruKontrol(butonBYazi);
                  soruSayacKontrol();
                },
                child: Text(butonBYazi),
              ),
            ),
            SizedBox(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  dogruKontrol(butonCYazi);
                  soruSayacKontrol();
                },
                child: Text(butonCYazi),
              ),
            ),
            SizedBox(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                onPressed: () {
                  dogruKontrol(butonDYazi);
                  soruSayacKontrol();
                },
                child: Text(butonDYazi),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
