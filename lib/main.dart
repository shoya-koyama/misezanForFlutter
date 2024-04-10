import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '計算機?',
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  double _result = 0;
  String _input = '';
  String _operator = '';

  bool isRepeatingChar(String number, String char) {
    return number == char * number.length;
  }

  String calculateEye(int x, int y) {
    if (x == y) {
      return '$x見せ$yのとき、眼は1';
    } else if ((isRepeatingChar(x.toString(), '6') && isRepeatingChar(y.toString(), '9')) || (isRepeatingChar(x.toString(), '9') && isRepeatingChar(y.toString(), '6'))) {
      return '$x見せ$yのとき、眼は11';
    } else if (x == 1 && y == 100) {
      return '$x見せ$yのとき、眼は83';
    } else if (x > y) {
      return '$x見せ$yのとき、眼は$x';
    } else if (x < y) {
      return '$x見せ$yのとき、眼は$y';
    } else {
      return '条件に一致する結果がありません';
    }
  }

  void _onButtonPressed(String value) {
    setState(() {
      if ('0123456789'.contains(value)) {
        _input += value;
        _display = _input;
      } else if (value == '?' && _operator.isEmpty) {
        _result = double.parse(_input);
        _input = '';
        _operator = value;
      } else if (value == '?' && _operator == '?') {
        final int x = _result.toInt();
        final int y = int.tryParse(_input) ?? 0;
        _display = calculateEye(x, y);
        _input = '';
        _operator = '';
      } else if ('+-*/'.contains(value)) {
        _result = double.parse(_input);
        _input = '';
        _operator = value;
      } else if (value == '=') {
        final double numInput = double.parse(_input);
        switch (_operator) {
          case '+':
            _result += numInput;
            break;
          case '-':
            _result -= numInput;
            break;
          case '*':
            _result *= numInput;
            break;
          case '/':
            _result = numInput != 0 ? _result / numInput : 0;
            break;
        }
        _display = _result.toString();
        _input = '';
        _operator = '';
      } else if (value == 'C') {
        _input = '';
        _display = '0';
        _result = 0;
        _operator = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('見せ算?'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                _display,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          for (var row in [
            ['7', '8', '9', '/'],
            ['4', '5', '6', '*'],
            ['1', '2', '3', '-'],
            ['C', '0', '=', '+', '?']
          ])
            Row(
              children: row.map((String value) {
                return Expanded(
                  child: TextButton(
                    child: Text(value, style: TextStyle(fontSize: 24)),
                    onPressed: () => _onButtonPressed(value),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
