import 'package:flutter/material.dart';

void main() {
  runApp(const KalkulatorApp());
}

class KalkulatorApp extends StatelessWidget {
  const KalkulatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const KalkulatorScreen(),
    );
  }
}

class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({super.key});

  @override
  _KalkulatorScreenState createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "×" || buttonText == "÷") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (!_output.contains(".")) {
        _output += buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      switch (operand) {
        case "+":
          _output = (num1 + num2).toString();
          break;
        case "-":
          _output = (num1 - num2).toString();
          break;
        case "×":
          _output = (num1 * num2).toString();
          break;
        case "÷":
          _output = (num1 / num2).toString();
          break;
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output += buttonText;
    }

    setState(() {
      output = double.parse(_output).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        child: Text(buttonText, style: const TextStyle(fontSize: 20.0)),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kalkulator")),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(output, style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold)),
          ),
          const Expanded(child: Divider()),
          Column(
            children: [
              Row(children: [buildButton("7"), buildButton("8"), buildButton("9"), buildButton("÷")]),
              Row(children: [buildButton("4"), buildButton("5"), buildButton("6"), buildButton("×")]),
              Row(children: [buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-")]),
              Row(children: [buildButton("."), buildButton("0"), buildButton("00"), buildButton("+")]),
              Row(children: [buildButton("C"), buildButton("=")]),
            ],
          ),
        ],
      ),
    );
  }
}
