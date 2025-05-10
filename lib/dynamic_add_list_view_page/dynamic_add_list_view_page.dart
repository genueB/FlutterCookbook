import 'dart:math';

import 'package:flutter/material.dart';

class DynamicAddListViewPage extends StatefulWidget {
  const DynamicAddListViewPage({super.key});

  @override
  State<DynamicAddListViewPage> createState() => _DynamicAddListViewPageState();
}

class _DynamicAddListViewPageState extends State<DynamicAddListViewPage> {
  final ids = List<int>.generate(10, (index) => index);

  final ScrollController _scrollController = ScrollController();
  late double _offset;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      _offset = _scrollController.offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          controller: _scrollController,
          children: ids.map((id) => ListItem(id: id)).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addToRandom,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addToLast() {
    ids.add(ids.length + 1);
    setState(() {});
  }

  void addToFirst() {
    ids.insert(0, ids.length + 1);
    _scrollController.jumpTo(_scrollController.offset + 100);
    setState(() {});
  }

  void addToRandom() {
    final presentIndex = _offset / 100;
    final randomIndex = Random().nextInt(ids.length);

    ids.insert(randomIndex, ids.length + 1);
    if (presentIndex > randomIndex) {
      _scrollController.jumpTo(_scrollController.offset + 100);
    }
    setState(() {});
  }
}

class ListItem extends StatelessWidget {
  final List<MaterialColor> colors = [
    Colors.red,
    Colors.blue,
    Colors.amber,
    Colors.green,
    Colors.pink,
    Colors.purple
  ];
  final int id;

  ListItem({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final color = colors[id % colors.length];

    return ColoredBox(
      color: color,
      child: SizedBox(
        height: 100,
        child: Center(
          child: Text(
            "$id",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
