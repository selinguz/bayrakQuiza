import 'package:bayrak_quiz_app/VeritabaniYardimcisi.dart';
import 'package:bayrak_quiz_app/bayraklar.dart';

class BayraklarDao {
  Future<List<Bayraklar>> rastgeleBesBayrakGetir() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM "
        "bayraklar ORDER BY RANDOM() LIMIT 5");
    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return Bayraklar(
          satir["bayrak_id"], satir["bayrak_ad"], satir["bayrak_resim"]);
    });
  }

  Future<List<Bayraklar>> rastgeleUcYanlisBayrakGetir(int bayrakId) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM "
        "bayraklar WHERE bayrak_id != $bayrakId ORDER BY RANDOM() LIMIT 3");
    return List.generate(maps.length, (index) {
      var satir = maps[index];
      return Bayraklar(
          satir["bayrak_id"], satir["bayrak_ad"], satir["bayrak_resim"]);
    });
  }
}
