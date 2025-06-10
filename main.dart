import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _currentInput = "";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";
  bool _clearOnNextInput = false;

  void _buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      _currentInput = "";
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = "";
      _clearOnNextInput = false;
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "x" ||
        buttonText == "/") {
      if (_currentInput.isNotEmpty) {
        _num1 = double.parse(_currentInput);
      }
      _operand = buttonText;
      _clearOnNextInput = true; 
      _currentInput = ""; 
    } else if (buttonText == ".") {
      if (!_currentInput.contains(".")) {
        _currentInput += buttonText;
      }
    } else if (buttonText == "=") {
      if (_currentInput.isNotEmpty) {
        _num2 = double.parse(_currentInput);
      }

      if (_operand == "+") {
        _output = (_num1 + _num2).toString();
      }
      if (_operand == "-") {
        _output = (_num1 - _num2).toString();
      }
      if (_operand == "x") {
        _output = (_num1 * _num2).toString();
      }
      if (_operand == "/") {
        if (_num2 != 0) {
          _output = (_num1 / _num2).toString();
        } else {
          _output = "Error"; 
        }
      }
      _num1 = double.parse(_output); 
      _operand = "";
      _clearOnNextInput = true; 
      _currentInput = _output; 
    } else {
      if (_clearOnNextInput) {
        _currentInput = buttonText;
        _clearOnNextInput = false;
      } else {
        _currentInput += buttonText;
      }
    }

    setState(() {
     
      if (buttonText != "=" && buttonText != "CLEAR" && !(buttonText == "+" || buttonText == "-" || buttonText == "x" || buttonText == "/")) {
         _output = _currentInput.isEmpty ? "0" : _currentInput;
      }
       if (_output.endsWith(".0")) {
        _output = _output.substring(0, _output.length - 2);
      }
    });
  }

  Widget _buildButton(String buttonText,
      {Color buttonColor = Colors.grey, Color textColor = Colors.white}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: EdgeInsets.all(20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  _output,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey[800]), 

           
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildButton("CLEAR", buttonColor: Colors.grey[700]!),
                    _buildButton("/", buttonColor: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("7"),
                    _buildButton("8"),
                    _buildButton("9"),
                    _buildButton("x", buttonColor: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("4"),
                    _buildButton("5"),
                    _buildButton("6"),
                    _buildButton("-", buttonColor: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("1"),
                    _buildButton("2"),
                    _buildButton("3"),
                    _buildButton("+", buttonColor: Colors.orange),
                  ],
                ),
                Row(
                  children: <Widget>[
                    _buildButton("0"),
                    _buildButton("."),
                    _buildButton("=", buttonColor: Colors.orange),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}