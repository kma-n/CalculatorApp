import 'package:flutter/material.dart';

class Calbutton extends StatefulWidget {
  const Calbutton({
    Key? key,
    required this.num,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final dynamic color;
  final dynamic num;
  final VoidCallback onTap;

  @override
  State<Calbutton> createState() => _CalbuttonState();
}

class _CalbuttonState extends State<Calbutton> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context).brightness;

    return (widget.num.toString() != "0")
        ? SizedBox(
            height: height / 11.5,
            width: (widget.num == "0") ? width / 2.2 : width / 5.3,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).canvasColor,
                shadowColor: Theme.of(context).canvasColor,
                elevation: 7,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(12),
              ),
              onPressed: () => widget.onTap(),
              child: Text(
                widget.num,
                style: TextStyle(
                    color: (widget.color == null) ? Colors.grey : widget.color,
                    fontSize: 32),
              ),
            ),
          )
        : zeroButton(theme, height, width);
  }

  Widget zeroButton(theme, height, width) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     color: Theme.of(context).canvasColor,
        //     spreadRadius: -12.0,
        //     blurRadius: 12.0,
        //   ),
        //   BoxShadow(
        //     color: Colors.white,
        //       spreadRadius: 12.0,
        //     blurRadius: 12.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(32)),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).canvasColor,
            Theme.of(context).canvasColor,
            const Color(0xffffffff),
            const Color(0xffffffff),
          ],
        ),
      ),
      height: height / 13,
      width: width / 2.2,
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(10),
            backgroundColor:
                MaterialStateProperty.all<Color>(Theme.of(context).canvasColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ))),
        onPressed: () => widget.onTap(),
        child: Text(
          widget.num,
          style: TextStyle(
              color: (widget.color == null) ? Colors.grey : widget.color,
              fontSize: 32),
        ),
      ),
    );
  }
}
