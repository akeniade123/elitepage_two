import 'package:flutter/material.dart';

class Todolist extends StatefulWidget {
  final String txt1, txt2, txt3, dtym;
  const Todolist(
      {super.key,
      required this.txt1,
      required this.txt2,
      required this.txt3,
      required this.dtym});

  @override
  State<Todolist> createState() => _TodoState();
}

class _TodoState extends State<Todolist> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.txt1,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 2, 20, 36),
          ),
        ),
        SizedBox(
          width: 200,
          child: Text(
            widget.txt2,
            style: const TextStyle(
              fontSize: 13,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.txt3,
                style: const TextStyle(fontSize: 15, color: Colors.red),
              ),
              Text(
                widget.dtym,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
