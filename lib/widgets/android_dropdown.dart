import 'package:flutter/material.dart';

class MyAndroidDropDown extends StatelessWidget {
  final String actualValue;
  final Function onChange;
  final List<String> items;
  MyAndroidDropDown({this.actualValue, this.onChange, this.items});
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: actualValue,
      onChanged: onChange,
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
    );
  }
}
