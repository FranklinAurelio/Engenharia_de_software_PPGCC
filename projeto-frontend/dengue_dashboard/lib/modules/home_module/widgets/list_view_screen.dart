import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<String> items = List<String>.generate(12, (i) => '${i * 10}');

  ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.07,
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
                children: [Text('${index + 1}/2025'), Text('${items[index]}')],
              ),
              Divider(
                endIndent: MediaQuery.of(context).size.width * 0.08,
              )
            ],
          );
        },
      ),
    );
  }
}
