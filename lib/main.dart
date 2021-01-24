import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Iskele(),
    );
  }
}

class Iskele extends StatefulWidget {
  @override
  _IskeleState createState() => _IskeleState();
}

class _IskeleState extends State<Iskele> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  var gelenYaziBasligi = "";
  var gelenYaziIcerigi = "";

  yaziEkle() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .set({"baslik": t1.text, "icerik": t2.text}).whenComplete(
            () => print("Yazı Eklendi"));
  }

  yaziGuncelle() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .update({"baslik": t1.text, "icerik": t2.text}).whenComplete(
            () => print("Yazı Güncellendi"));
  }

  yaziSil() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .delete()
        .whenComplete(() => print("Yazı Silindi"));
  }

  yaziGetir() {
    FirebaseFirestore.instance
        .collection("Yazilar")
        .doc(t1.text)
        .get()
        .then((gelenVeri) {
      setState(() {
        gelenYaziBasligi = gelenVeri.data()['baslik'];
        gelenYaziIcerigi = gelenVeri.data()['icerik'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: t1,
              ),
              TextField(
                controller: t2,
              ),
              
              Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RaisedButton(child: Text("Ekle"), onPressed: yaziEkle),
                  RaisedButton(child: Text("Gncl"), onPressed: yaziGuncelle),
                  RaisedButton(child: Text("Sil"), onPressed: yaziSil),
                  RaisedButton(child: Text("Gtir"), onPressed: yaziGetir),
                ],
              ),

              ListTile(
                title: Text(gelenYaziBasligi),
                subtitle: Text(gelenYaziIcerigi),
              )
            ],
          ),
        ),
      ),
    );
  }
}
