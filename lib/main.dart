// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  final TextEditingController hController = TextEditingController();
  final TextEditingController pController = TextEditingController();
  String valor = "0.0";

  @override
  void dispose() {
    hController.dispose();
    pController.dispose();
    super.dispose();
  }

  void calcular() {
    final altura = double.tryParse(hController.text);
    final peso = double.tryParse(pController.text);
    if (altura != null && peso != null && altura > 0) {
      final imc = peso / (altura * altura);
      setState(() {
        valor = imc.toStringAsFixed(1);
      });
    } else {
      setState(() {
        valor = "Entrada inválida";
      });
    }
  }

  void resetFields() {
    hController.clear();
    pController.clear();
    setState(() {
      valor = "Seu IMC 0.0";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              onPressed: resetFields,
              icon: Icon(Icons.restart_alt_outlined, color: Colors.white, size: 30),
            );
          }),
          backgroundColor: Color.fromARGB(255, 68, 74, 255), //bg
          title: Text("IMC", style: TextStyle(color: Colors.white, fontFamily: 'REM')), //titulo + fonte
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ), //adiciona bordas embaixo do appBar
          centerTitle: true, //alinha o texto no centro
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 200, 20, 0),
          child: Column(
            children: [
              const Text("Digite seus dados", style: TextStyle(color: Color.fromARGB(255, 0, 37, 184), fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(height: 30),
              TextField(
                keyboardType: TextInputType.number,
                controller: hController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: "Altura",
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: "Peso"
                ),
                controller: pController,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 37, 184),
                  minimumSize: Size(300, 50),
                ),
                onPressed: calcular,
                child: Text("Calcular IMC", style: TextStyle(color: Colors.white)),
              ),
              SizedBox(height: 10),
              Text("Seu IMC é: $valor", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
