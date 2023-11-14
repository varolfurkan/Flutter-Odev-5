import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String islem = "";
  String sonuc = "";
  void butonTiklanma(String butonMetin) {
    setState(() {
      if (butonMetin == 'C') {
        islem = '';
        sonuc = '';
      }
      else if (butonMetin == '=') {
        try {
          sonuc = "= ${(toplam(islem)).toInt().toString()}";
        } catch (e) {
          sonuc = 'Hata';
        }
      }
      else {
        islem += butonMetin;
      }

      if (butonMetin == 'x') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Çarpma işlemi yapım aşamasındadır.")
        ));
        islem = '';
      }
      if (butonMetin == '-') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Çıkarma işlemi yapım aşamasındadır.")
            ));
        islem = '';
      }
      if (butonMetin == ',') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Ondalık işlemler şuanda yapılamamaktadır.")
            ));
        islem = '';
      }
    });
  }
  Widget butonOlustur(String butonMetin) {
    Color butonRenk = (butonMetin == "C" || butonMetin == "+" || butonMetin == "="
        || butonMetin == "-"|| butonMetin == "x")
        ? Colors.orange
        : Colors.blueGrey;
    return
      Container(
        margin: const EdgeInsets.only(left:8,right: 8,bottom: 20),
        child: SizedBox(
          width: 65,
          height: 65,
          child: ElevatedButton(
              onPressed: () => butonTiklanma(butonMetin),
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(butonRenk),
                  shape: MaterialStateProperty.all(const CircleBorder()),
              ),
              child: Text(
                butonMetin,
                style: const TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
        ),
      );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Hesap Makinesi",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: Text(
                islem,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.bottomRight,
              child: Text(
                sonuc,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                butonOlustur("7"),
                butonOlustur("8"),
                butonOlustur("9"),
                butonOlustur("x"),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                butonOlustur("4"),
                butonOlustur("5"),
                butonOlustur("6"),
                butonOlustur("-"),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                butonOlustur("1"),
                butonOlustur("2"),
                butonOlustur("3"),
                butonOlustur("+"),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                butonOlustur("0"),
                butonOlustur(","),
                butonOlustur("C"),
                butonOlustur("="),
              ],
            ),
          ],
        ),
    );
  }
}

double toplam(String expression) {
  List<String> terms = expression.split('+');
  double result = 0;
  for (String term in terms) {
    result += double.parse(term);
  }
  return result;
}

