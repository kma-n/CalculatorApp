class Stack<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  int get length => _list.length;
  E pop() => _list.removeLast();

  E top() => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
