import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyIosPicker extends StatelessWidget {
  final Function onSelect;
  final List<String> items;
  MyIosPicker({this.onSelect, this.items});
  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: onSelect,
      children: items
          .map(
            (coin) => Text(
              coin,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
          .toList(),
    );
  }
}
