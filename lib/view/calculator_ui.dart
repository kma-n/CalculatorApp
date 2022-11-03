import 'package:calculator_app/view/widgets/cal_button.dart';
import 'package:calculator_app/view/widgets/results.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/stack/stack_imp.dart' as my_stack;

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({
    Key? key,
  }) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPage();
}

enum Operator { plus, minus, multiply, divide, mod }

class _CalculatorPage extends State<CalculatorPage> {
  var input = '';
  Operator? op;
  my_stack.Stack opStack = my_stack.Stack();
  my_stack.Stack operandStack = my_stack.Stack();
  dynamic result = "";

  final _buttonAction = <String, VoidCallback>{};

  @override
  void initState() {
    // TODO: implement initState

    //key:values pairs for callback

    _buttonAction.addAll({
      "1": () => _numIn("1"),
      "2": () => _numIn("2"),
      "3": () => _numIn("3"),
      "4": () => _numIn("4"),
      "5": () => _numIn("5"),
      "6": () => _numIn("6"),
      "7": () => _numIn("7"),
      "8": () => _numIn("8"),
      "9": () => _numIn("9"),
      "0": () => _numIn("0"),
      "AC": () => _reset(),
      "+/-": () => _numIn("-"),
      ".": () => _numIn("."),
      "÷": () => _numIn("/"),
      "x": () => _numIn("*"),
      "+": () => _numIn("+"),
      "%": () => _numIn("%"),
      "-": () => _numIn("-"),
      "=": () => _numIn("="),
    });

    super.initState();
  }

  int precendence(str) {
    if (str == "+" || str == "-") {
      return 1;
    } else if (str == "*" || str == "/" || str == "%" || str == "(") {
      return 2;
    } else {
      return 0;
    }
  }

  bool isOperator(String x) {
    if (x == '/' ||
        x == '*' ||
        x == '-' ||
        x == '+' ||
        x == '=' ||
        x == "%" ||
        x == "(") {
      return true;
    }
    return false;
  }

  double? operations(double num1, double num2, String op) {
    setState(() {
      if (op == "/") {
        result = (num1 / num2).toString();
      } else if (op == "+") {
        result = (num1 + num2).toString();
      } else if (op == "*") {
        result = (num1 * num2).toString();
      } else if (op == "%") {
        result = (num1 / 100).toString();
      } else if (op == "-") {
        result = (num1 - num2).toString();
      }
    });
    return double.tryParse(result);
  }

  double? perc(double num1) {
    setState(() {
      result = (num1 / 100).toString();
    });
    return double.tryParse(result);
  }

  void evalFunc(String userInput) {
    for (int i = 0; i < userInput.length; i++) {
      if (!isOperator(userInput[i])) {
        var val = "";
        while (i < userInput.length && !isOperator(userInput[i])) {
          val += userInput[i];
          i++;
        }
        operandStack.push(val);
        print(operandStack.toString());
        print(operandStack.top());
        i--;
      } else {
        if (opStack.isEmpty) {
          opStack.push(userInput[i]);
        } else if (precendence(userInput[i]) >= precendence(opStack.top())) {
          opStack.push(userInput[i]);
        } else if (precendence(userInput[i]) <= precendence(opStack.top())) {
          while (opStack.isNotEmpty) {
            if (precendence(userInput[i]) <= precendence(opStack.top()) &&
                opStack.top() != "%") {
              if (opStack.top() == "%") {
                var val1 = operandStack.top();
                operandStack.pop();
                opStack.pop();
                operandStack.push(perc(double.tryParse(val1)!).toString());
              }
              var val2 = operandStack.top();
              operandStack.pop();
              var val1 = operandStack.top();
              operandStack.pop();
              var op = opStack.top();
              opStack.pop();
              operandStack.push(
                  operations(double.tryParse(val1)!, double.tryParse(val2)!, op)
                      .toString());
            }
          }
          opStack.push(userInput[i]);
        }
      }
    }
    if (opStack.top() == "(") {
      var val1 = operandStack.top();
      operandStack.pop();
      opStack.pop();
      operandStack.push(_toggle(double.tryParse(val1)!).toString());
    }
    if (opStack.isNotEmpty) {
      if (opStack.top() == "%") {
        var val1 = operandStack.top();
        operandStack.pop();
        opStack.pop();
        operandStack.push(perc(double.tryParse(val1)!).toString());
      }
    }

    while (opStack.isNotEmpty && opStack.top() != "%" && opStack.top() != "(") {
      var val2 = operandStack.top();
      operandStack.pop();
      var val1 = operandStack.top();
      operandStack.pop();
      var op = opStack.top();
      opStack.pop();
      operandStack.push(
          operations(double.tryParse(val1)!, double.tryParse(val2)!, op)
              .toString());
    }
  }

  double? _toggle(double num1) {
    setState(() {
      result = (num1 * -1).toString();
    });
    return double.tryParse(result);
  }

  //clearing all values
  void _reset() {
    setState(() {
      input = "";
      result = "";
      for (int i = 0; i < operandStack.length; i++) {
        operandStack.pop();
      }
      for (int i = 0; i < opStack.length; i++) {
        opStack.pop();
      }
    });
  }

//func to input nums Onclick through callback
  void _numIn(dynamic num) {
    setState(() {
      if (num.toString() == "=") {
        evalFunc(input);
      } else {
        if (isOperator(num.toString())) {
          if (isOperator(input[input.length - 1])) {
            if (num.toString() != "-") {
              input = input.substring(0, input.length - 1);
            }
          }
        }

        input += num.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Expanded(
                  child: ResultDisplay(
                num: input,
                res: (operandStack.isEmpty) ? "" : operandStack.top(),
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
                        num: "÷",
                        color: Colors.amber,
                        onTap: _buttonAction["÷"]!),
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
                        num: "x",
                        color: Colors.amber,
                        onTap: _buttonAction["x"]!),
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
                        num: "-",
                        color: Colors.amber,
                        onTap: _buttonAction["-"]!),
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
                        num: "+",
                        color: Colors.amber,
                        onTap: _buttonAction["+"]!),
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
                        num: "=",
                        color: Colors.amber,
                        onTap: _buttonAction["="]!),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
