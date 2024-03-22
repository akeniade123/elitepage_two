import 'dart:developer';

import '../models/global_strings.dart';
import 'package:flutter/material.dart';

class ContentDisplay extends StatelessWidget {
  final mainhead,
      description,
      purp,
      image,
      dest,
      imgsize,
      playicn,
      link,
      essence;
  const ContentDisplay(
      {super.key,
      this.mainhead,
      this.description,
      this.purp,
      this.image,
      this.imgsize,
      this.playicn,
      this.link,
      this.essence,
      this.dest});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(dest);
        switch (essence) {
          case vdd:
            log(link);
            break;
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                    blurStyle: BlurStyle.inner,
                    blurRadius: 2,
                    color: Color.fromARGB(26, 158, 158, 158),
                    offset: Offset(2, 2),
                    spreadRadius: 2)
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(right: 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              image,
                              width: imgsize.toDouble(),
                            ),
                            //    playicn
                          ],
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 140,
                                    child: Container(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        mainhead,
                                        maxLines: 2,
                                        style: const TextStyle(
                                            overflow: TextOverflow.clip,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ]),
                            SizedBox(
                              width: 140,
                              child: Text(
                                description,
                                maxLines: 2,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          width: 70,
                          child: Text(
                            purp,
                            style: const TextStyle(
                                color: Colors.green, fontSize: 12),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
