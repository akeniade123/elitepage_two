import 'package:flutter/material.dart';

class Attendee extends StatefulWidget {
  final String name, matricNo, gender;
  bool presence;

  Attendee(
      {super.key,
      required this.name,
      required this.matricNo,
      required this.gender,
      required this.presence,
      required String matric_no});

  @override
  State<Attendee> createState() => _AttendeeState();
}

class _AttendeeState extends State<Attendee> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.matricNo, style: const TextStyle(fontSize: 12)),
                Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Text(widget.name,
                        style: const TextStyle(fontSize: 15))),
                Text(widget.gender,
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Checkbox(
              value: widget.presence,
              onChanged: (value) {
                setState(() {
                  widget.presence = value!;
                });
              })
        ],
      ),
    );
  }
}
