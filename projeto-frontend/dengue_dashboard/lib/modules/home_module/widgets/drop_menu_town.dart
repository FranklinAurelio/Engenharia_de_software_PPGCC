import 'package:dengue_dashboard/core/data_persist_service.dart';
import 'package:dengue_dashboard/modules/constants/region_const.dart';
import 'package:flutter/material.dart';

class DropdownMenuTown extends StatefulWidget {
  final List<String> list;
  const DropdownMenuTown({super.key, required this.list});

  @override
  State<DropdownMenuTown> createState() => _DropdownMenuTownState();
}

class _DropdownMenuTownState extends State<DropdownMenuTown> {
  String dropdownValue = '';
  @override
  void initState() {
    super.initState();
    dropdownValue = widget.list.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      label: const Text('Cidade'),
      initialSelection: widget.list.first,
      onSelected: (String? value) async {
        setState(() {
          dropdownValue = value!;
        });
        await insertData(3, 'cidade', value);
      },
      dropdownMenuEntries:
          widget.list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
