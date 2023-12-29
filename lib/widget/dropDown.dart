import 'package:flutter/material.dart';

class DropdownButtonExample extends StatefulWidget {
  final Function(String) onItemSelected;
  final List<String> dropdownValues;

  const DropdownButtonExample({
    Key? key,
    required this.onItemSelected,
    required this.dropdownValues,
  }) : super(key: key);

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? value) {
        print(value);
        setState(() {
          dropdownValue = value!;
        });
        widget
            .onItemSelected(value!); // Pass the selected value to the callback
      },
      items: widget.dropdownValues.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
