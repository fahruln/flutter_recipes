import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.image,
    required this.category,
    required this.title,
    required this.ingradient,
    required this.direction,
    required this.username,
  });

  final int category;
  final String image, title, ingradient, direction, username;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  Set selection = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.image), fit: BoxFit.cover)),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff1FCC79)),
              child: IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: const Color(0xff1FCC79),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 250,
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Text(
                  "by ${FirebaseAuth.instance.currentUser!.displayName}",
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Ingradient',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E3E5C),
                  fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: const Color(0xffF4F5F7),
                borderRadius: BorderRadius.circular(15)),
            child: Text(widget.ingradient),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Direction',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E3E5C),
                  fontSize: 18),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: const Color(0xffF4F5F7),
                borderRadius: BorderRadius.circular(15)),
            child: Text(widget.direction),
          ),
        ]),
      ),
    );
  }
}
