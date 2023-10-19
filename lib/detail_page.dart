import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  final list = [
    'Bahan 1',
    'Bahan 2',
    'Bahan 3',
    'Bahan 4',
    'Bahan 5',
    'Bahan 6',
    'Bahan 7'
  ];
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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/nasigoreng.jpg'),
                    fit: BoxFit.cover)),
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nasi Goreng',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2E3E5C)),
                ),
                IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_outline,
                      size: 40,
                      color: Color(0xff2E3E5C),
                    ))
              ],
            ),
          ),
          const Divider(
            color: Color(0xffF4F5F7),
            thickness: 3,
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
            height: 250,
            decoration: BoxDecoration(
                color: const Color(0xffF4F5F7),
                borderRadius: BorderRadius.circular(15)),
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
            height: 250,
            decoration: BoxDecoration(
                color: const Color(0xffF4F5F7),
                borderRadius: BorderRadius.circular(15)),
          ),
        ]),
      ),
    );
  }
}
