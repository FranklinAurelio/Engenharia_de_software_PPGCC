import 'package:dengue_dashboard/core/data_persist_service.dart';
import 'package:flutter/material.dart';

enum Gender { feminino, masculino }

class RadioGender extends StatefulWidget {
  const RadioGender({super.key});

  @override
  State<RadioGender> createState() => _RadioGenderState();
}

class _RadioGenderState extends State<RadioGender> {
  Gender? _gender = Gender.masculino;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 5,
        ),
        Radio<Gender>(
          value: Gender.masculino,
          groupValue: _gender,
          onChanged: (Gender? value) async {
            setState(() {
              _gender = value;
            });
            await insertData(3, 'genero', value);
          },
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          'Masculino',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          width: 10,
        ),
        Radio<Gender>(
          value: Gender.feminino,
          groupValue: _gender,
          onChanged: (Gender? value) async {
            setState(() {
              _gender = value;
            });
            await insertData(3, 'genero', value);
          },
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          'Feminino',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
