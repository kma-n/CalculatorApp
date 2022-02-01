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
    return Container(
        height: height / 11,
        width: (widget.num == "0") ? width / 2.3 : width / 6,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(36),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: const Offset(0, 1),
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            widget.onTap();
          },
          child: Container(
            padding:
                (widget.num == "0") ? const EdgeInsets.only(left: 20) : null,
            alignment:
                (widget.num == "0") ? Alignment.centerLeft : Alignment.center,
            child: Text(
              widget.num,
              style: TextStyle(
                  color: (widget.color == null) ? Colors.grey : widget.color,
                  fontSize: 32),
            ),
          ),
        ));
  }
}
