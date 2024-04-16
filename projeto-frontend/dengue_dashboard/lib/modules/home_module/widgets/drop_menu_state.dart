import 'package:dengue_dashboard/modules/constants/region_const.dart';
import 'package:flutter/material.dart';

class DropdownMenuState extends StatefulWidget {
  final List<String> list;
  const DropdownMenuState({super.key, required this.list});

  @override
  State<DropdownMenuState> createState() => _DropdownMenuStateState();
}

class _DropdownMenuStateState extends State<DropdownMenuState> {
  String dropdownValue = '';
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      label: const Text('Estado'),
      initialSelection: widget.list.first,
      onSelected: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries:
          widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
