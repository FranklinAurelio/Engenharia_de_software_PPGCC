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
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text(
            'Masculino',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          leading: Radio<Gender>(
            value: Gender.masculino,
            groupValue: _gender,
            onChanged: (Gender? value) {
              setState(() {
                _gender = value;
              });
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Feminino',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          leading: Radio<Gender>(
            value: Gender.feminino,
            groupValue: _gender,
            onChanged: (Gender? value) {
              setState(() {
                _gender = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
