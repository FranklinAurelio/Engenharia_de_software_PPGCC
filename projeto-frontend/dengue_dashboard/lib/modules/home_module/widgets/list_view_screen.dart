import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<String> items = List<String>.generate(24, (i) => '${i * 10}');
  List<double> cases = [];
  ListScreen({super.key, required this.cases});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.4,
      child: ListView.builder(
        itemCount: items.length,
        prototypeItem: ListTile(
          title: Text(items.first),
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  index + 1 > 12
                      ? Text('${index - 11}/2025')
                      : Text('${index + 1}/2024'),
                  Text('${cases[index]}')
                ],
              ),
              Divider(
                endIndent: MediaQuery.of(context).size.width * 0.0,
              )
            ],
          );
        },
      ),
    );
  }
}
