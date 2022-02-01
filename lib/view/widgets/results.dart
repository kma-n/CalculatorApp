import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  const ResultDisplay({Key? key, this.num, this.res}) : super(key: key);

  final dynamic num;
  final dynamic res;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).brightness;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [numDisplay(theme, num, 24.0), numDisplay(theme, res, 42.0)],
    );
  }

  Widget numDisplay(theme, text, size) {
    return Container(
        padding: const EdgeInsets.all(6),
        width: double.infinity,
        alignment: Alignment.centerRight,
        child: Text(
          text.toString(),
          style: TextStyle(
              color: (theme == Brightness.light)
                  ? Colors.grey.shade700
                  : Colors.white,
              fontSize: size),
        ));
  }
}
