import 'package:dengue_dashboard/core/data_persist_service.dart';
import 'package:dengue_dashboard/modules/constants/region_const.dart';
import 'package:flutter/material.dart';

class DropdownMenuRegion extends StatefulWidget {
  const DropdownMenuRegion({super.key});

  @override
  State<DropdownMenuRegion> createState() => _DropdownMenuRegionState();
}

class _DropdownMenuRegionState extends State<DropdownMenuRegion> {
  String dropdownValue = listRegion.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      label: const Text('Região'),
      initialSelection: listRegion.first,
      onSelected: (String? value) async {
        setState(() {
          dropdownValue = value!;
        });
        await insertData(3, 'regiao', value);
      },
      dropdownMenuEntries:
          listRegion.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
