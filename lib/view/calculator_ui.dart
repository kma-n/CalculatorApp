import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  int? result;

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
            body: Padding(
      padding: EdgeInsets.all(8.0),
      child: Buttons(),
    )));
  }
}

class Buttons extends StatefulWidget {
  const Buttons({
    Key? key,
  }) : super(key: key);

  @override
  State<Buttons> createState() => _ButtonsState();
}

enum Operator { plus, minus, multiply, divide, mod }

class _ButtonsState extends State<Buttons> {
  final _buttonAction = <String, VoidCallback>{};
  final _operatorStrings = <Operator, String>{
    Operator.divide: "÷",
    Operator.minus: "-",
    Operator.multiply: "*",
    Operator.plus: "+",
  };

  Operator? op;
  dynamic result = "";
  num? _leftNum;
  num? _rightNum;

  @override
  void initState() {
    // TODO: implement initState
    _buttonAction.addAll({
      "1": () => _numIn(1),
      "2": () => _numIn(2),
      "3": () => _numIn(3),
      "4": () => _numIn(4),
      "5": () => _numIn(5),
      "6": () => _numIn(6),
      "7": () => _numIn(7),
      "8": () => _numIn(8),
      "9": () => _numIn(9),
      "0": () => _numIn(0),
      "AC": () => _reset(),
      "+/-": () => _frac(),
      ".": () => _frac(),
      "÷": () => _opIn(Operator.divide),
      "x": () => _opIn(Operator.multiply),
      "+": () => _opIn(Operator.plus),
      "%": () => _opIn(Operator.mod),
      "-": () => _opIn(Operator.minus),
      "=": () => _answer(),
    });
    super.initState();
  }

  String get _calc {
    return [
      _leftNum?.toString() ?? "",
      _operatorStrings[op] ?? "",
      _rightNum?.toString() ?? ""
    ].where((element) => element != "").join(' ');
  }

  void _frac() {}
  void _reset() {
    setState(() {
      _leftNum = null;
      _rightNum = null;
      op = null;
      result = "";
    });
  }

  void _numIn(int num) {
    setState(() {
      if (op == null) {
        _leftNum = (_leftNum ?? 0) * 10 + num;
      } else {
        _rightNum = (_rightNum ?? 0) * 10 + num;
      }
    });
  }

  void _opIn(Operator opr) {
    setState(() {
      op = opr;
    });
  }

  void _answer() {
    if (op == null || _leftNum == null || _rightNum == null) {
      return;
    }
    setState(() {
      if (op != null) {
        if (op == Operator.divide) {
          result = (_leftNum! / _rightNum!);
        } else if (op == Operator.plus) {
          result = (_leftNum! + _rightNum!);
        } else if (op == Operator.multiply) {
          result = (_leftNum! * _rightNum!);
        } else if (op == Operator.mod) {
          result = (_leftNum! % _rightNum!);
        } else if (op == Operator.minus) {
          result = (_leftNum! - _rightNum!);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ResultDisplay(
          num: _calc,
          res: result,
        )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Calbutton(
                num: "AC",
                onTap: _buttonAction["AC"]!,
              ),
              Calbutton(
                num: "+/-",
                onTap: _buttonAction["+/-"]!,
              ),
              Calbutton(num: "%", onTap: _buttonAction["%"]!),
              Calbutton(
                  num: "÷", color: Colors.amber, onTap: _buttonAction["÷"]!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Calbutton(num: "7", onTap: _buttonAction["7"]!),
              Calbutton(num: "8", onTap: _buttonAction["8"]!),
              Calbutton(num: "9", onTap: _buttonAction["9"]!),
              Calbutton(
                  num: "x", color: Colors.amber, onTap: _buttonAction["x"]!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Calbutton(num: "4", onTap: _buttonAction["4"]!),
              Calbutton(num: "5", onTap: _buttonAction["5"]!),
              Calbutton(num: "6", onTap: _buttonAction["6"]!),
              Calbutton(
                  num: "-", color: Colors.amber, onTap: _buttonAction["-"]!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Calbutton(num: "1", onTap: _buttonAction["1"]!),
              Calbutton(num: "2", onTap: _buttonAction["2"]!),
              Calbutton(num: "3", onTap: _buttonAction["3"]!),
              Calbutton(
                  num: "+", color: Colors.amber, onTap: _buttonAction["+"]!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Calbutton(num: "0", onTap: _buttonAction["0"]!),
              Calbutton(num: ".", onTap: _buttonAction["."]!),
              Calbutton(
                  num: "=", color: Colors.amber, onTap: _buttonAction["="]!),
            ],
          ),
        ),
      ],
    );
  }
}

class Calbutton extends StatefulWidget {
  const Calbutton({
    Key? key,
    required this.num,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final color;
  final num;
  final VoidCallback onTap;

  @override
  State<Calbutton> createState() => _CalbuttonState();
}

class _CalbuttonState extends State<Calbutton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Container(
          height: height / 11,
          width: (widget.num == "0") ? width / 2.3 : width / 6,
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                offset: Offset(0, 1),
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Container(
            padding: (widget.num == "0") ? EdgeInsets.only(left: 20) : null,
            alignment:
                (widget.num == "0") ? Alignment.centerLeft : Alignment.center,
            child: Text(
              widget.num,
              style: TextStyle(
                  color: (widget.color == null) ? Colors.grey : widget.color,
                  fontSize: 32),
            ),
          )),
    );
  }
}

class ResultDisplay extends StatelessWidget {
  const ResultDisplay({Key? key, this.num, this.res}) : super(key: key);

  final num;
  final res;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.all(6),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: Text(
              num.toString(),
              style: TextStyle(
                  color: (theme == Brightness.light)
                      ? Colors.grey.shade700
                      : Colors.white,
                  fontSize: 24),
            )),
        Container(
            padding: EdgeInsets.all(6),
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: Text(
              res.toString(),
              style: TextStyle(
                  color: (theme == Brightness.light)
                      ? Colors.grey.shade700
                      : Colors.white,
                  fontSize: 42),
            )),
      ],
    );
  }
}
