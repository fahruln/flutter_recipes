import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:teman_dapur/detail_page.dart';

class RecipeGrid extends StatefulWidget {
  const RecipeGrid({
    super.key,
    required this.image,
    required this.category,
    required this.title,
    required this.ingradient,
    required this.direction,
    required this.username,
    required this.id,
  });

  final int category;
  final String image, title, ingradient, direction, username, id;

  @override
  State<RecipeGrid> createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(
              image: widget.image,
              category: widget.category,
              title: widget.title,
              ingradient: widget.ingradient,
              direction: widget.direction,
              username: widget.username,
            ),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.image), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(15)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.center),
                  borderRadius: BorderRadius.circular(15)),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.username,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
