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
        children: [ResultDisplay(num: result), Buttons()],
      )),
    );
  }
}

class ResultDisplay extends StatelessWidget {
  final num;
  const ResultDisplay({Key? key, this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(6),
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: Text(
          num.toString(),
          style: TextStyle(color: Colors.white, fontSize: 36),
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
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Calbutton(num: "1"),
            ),
            Calbutton(num: "2"),
          ],
        ),
      ],
    );
  }
}

class Calbutton extends StatelessWidget {
  const Calbutton({
    Key? key,
    this.num,
  }) : super(key: key);

  final num;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 11,
      width: width / 6,
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
      child: Center(
          child: Text(
        num,
        style: Theme.of(context).textTheme.headline3,
      )),
    );
  }
}
