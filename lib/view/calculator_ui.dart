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
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(child: ResultDisplay(num: result)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Buttons(),
          )
        ],
      )),
    );
  }
}

class ResultDisplay extends StatelessWidget {
  final num;
  const ResultDisplay({Key? key, this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness;

    return Container(
        padding: EdgeInsets.all(6),
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: Text(
          num.toString(),
          style: TextStyle(
              color: (theme == Brightness.light)
                  ? Colors.grey.shade700
                  : Colors.white,
              fontSize: 42),
        ));
  }
}

class Buttons extends StatelessWidget {
  final value;
  const Buttons({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Calbutton(num: "AC"),
              Calbutton(num: "+/-"),
              Calbutton(num: "%"),
              Calbutton(num: "÷", color: Colors.amber),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Calbutton(num: "7"),
              Calbutton(num: "8"),
              Calbutton(num: "9"),
              Calbutton(num: "x", color: Colors.amber),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Calbutton(num: "4"),
              Calbutton(num: "5"),
              Calbutton(num: "6"),
              Calbutton(num: "-", color: Colors.amber),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Calbutton(num: "1"),
              Calbutton(num: "2"),
              Calbutton(num: "3"),
              Calbutton(num: "+", color: Colors.amber),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Calbutton(num: "0"),
              Calbutton(num: "."),
              Calbutton(num: "=", color: Colors.amber),
            ],
          ),
        ),
      ],
    );
  }
}

class Calbutton extends StatelessWidget {
  const Calbutton({
    Key? key,
    this.num,
    this.color,
  }) : super(key: key);

  final num;
  final color;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: height / 11,
        width: (num == "0") ? width / 2.3 : width / 6,
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
          padding: (num == "0") ? EdgeInsets.only(left: 20) : null,
          alignment: (num == "0") ? Alignment.centerLeft : Alignment.center,
          child: Text(
            num,
            style: TextStyle(
                color: (color == null) ? Colors.grey : color, fontSize: 32),
          ),
        ));
  }
}
