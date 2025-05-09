import 'package:calculator_wiktorowicz/przyciski.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var Pytanie = '';
  var Odpowiedz = '';
  String ostatniWynik = '';

  final myTextStyle = TextStyle(fontSize: 30, color: Colors.deepPurple[900]);

  final List<String>przyciski=
  [
    'C', 'DEL', '%', '÷',
    '9', '8', '7', '*',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', 'ANS', '.', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.deepPurple[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 50),
                  Container(
                    padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Text(Pytanie,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.02,
                      ),
                  ),
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                      child: Text(Odpowiedz,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.02,
                      ),
                      ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
          flex: 2,
            child: Container(
              color: Colors.deepPurple[200],
              height:  500,
              width: 520,
            child: GridView.builder(
              itemCount: przyciski.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index){
                // C
                if(index == 0){
                  return MyButton(
                    buttonTapped: (){
                      setState(() {
                        Pytanie = '';
                        Odpowiedz = '';
                      });
                    },
                      buttonText: przyciski[index],
                      color: Colors.blue,
                  textColor: Colors.white
                  );
                }
                // DEL
                else if(index == 1){
                  return MyButton(
                      buttonTapped: (){
                        setState(() {
                          Pytanie = Pytanie.substring(0,Pytanie.length-1);
                        });
                      },
                      buttonText: przyciski[index],
                      color: Colors.orange,
                      textColor: Colors.white
                  );
                }
                // =
                else if(index == przyciski.length-1){
                  return MyButton(
                      buttonTapped: (){
                        setState(() {
                        Wynik();
                        });
                      },
                      buttonText: przyciski[index],
                      color: Colors.pink,
                      textColor: Colors.white
                  );
                }
                    // ANS
                    else if (przyciski[index] == 'ANS') {
                  return MyButton(
                    buttonText: przyciski[index],
                      color: isOperator(przyciski[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                      textColor: isOperator(przyciski[index]) ? Colors.white : Colors.purpleAccent,
                      buttonTapped: () {
                        setState(() {
                            Pytanie += ostatniWynik;
                        });
                      }
                  );
                    }

                //reszta przycisków
                else{
                  return MyButton(
                      buttonTapped: (){
                        setState(() {
                          Pytanie += przyciski[index];
                        });
                      },
                      buttonText: przyciski[index],
                      color: isOperator(przyciski[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                  textColor: isOperator(przyciski[index]) ? Colors.white : Colors.purpleAccent
                  );
                }
                })
          ),
          ),
        ],
      ),
    );
  }
  bool isOperator(String x){
    if(x == '%' || x == '÷' ||x == '*' ||x == '-' ||x == '+' ||x == '='){
      return true;
    }
    return false;
  }

  void Wynik(){
    String Rezultat = Pytanie;
    Rezultat = Rezultat.replaceAll('÷', '/');
      ExpressionParser p = GrammarParser();
      Expression exp = p.parse(Rezultat);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      Odpowiedz = eval.toString();
      ostatniWynik = Odpowiedz;
      if(Odpowiedz == "Infinity"){
        Odpowiedz = "Błąd";
      }
  }

}
