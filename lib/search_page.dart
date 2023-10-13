import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const List<String> _categories = <String>[
    'Chicken',
    'Beef',
    'Bread',
    'Rice',
    'Fish',
    'Egg',
    'Vegetable',
    'Cake',
    'Seafood',
    'Fruit',
    'Soup',
    'Peanut'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Search',
              style: TextStyle(
                  color: Color(0xff2E3E5C),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 25),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const ShapeDecoration(
                  color: Color(0xfff5f6f8), shape: StadiumBorder()),
              child: const TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 25.0),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 35,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    hintText: 'Ingadients or dishes'),
              ),
            ),
            const Text(
              'Browse all',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E3E5C),
                  fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 4 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: _categories.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff1FCC79),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      _categories[index],
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
