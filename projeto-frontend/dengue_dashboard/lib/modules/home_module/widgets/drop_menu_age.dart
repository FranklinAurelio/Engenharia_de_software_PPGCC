import 'package:dengue_dashboard/core/data_persist_service.dart';
import 'package:dengue_dashboard/modules/constants/age.dart';
import 'package:dengue_dashboard/modules/constants/region_const.dart';
import 'package:flutter/material.dart';

class DropdownMenuAge extends StatefulWidget {
  const DropdownMenuAge({super.key});

  @override
  State<DropdownMenuAge> createState() => _DropdownMenuAgeState();
}

class _DropdownMenuAgeState extends State<DropdownMenuAge> {
  String dropdownValue = ages.first.toString();
  List<String> list = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < ages.length; i++) {
      list.add(
        ages[i].toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      label: const Text('Idade'),
      initialSelection: list.first,
      onSelected: (String? value) async {
        setState(() {
          dropdownValue = value!;
        });
        await insertData(3, 'idade', dropdownValue);
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
