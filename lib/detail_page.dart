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
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.topLeft,
          height: 300,
          width: double.infinity,
          color: const Color(0xff1FCC79),
          child: IconButton(
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
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Food Name',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2E3E5C)),
              ),
              IconButton(
                  padding: const EdgeInsets.only(bottom: 10),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark_outline,
                    size: 40,
                    color: Color(0xff2E3E5C),
                  ))
            ],
          ),
        ),
        TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              text: 'Ingradient',
            ),
            Tab(
              text: 'Direction',
            ),
          ],
          indicatorColor: const Color(0xff1FCC79),
          labelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          labelColor: const Color(0xff1FCC79),
          unselectedLabelColor: Colors.grey,
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 7,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const ShapeDecoration(
                        shape: CircleBorder(), color: Color(0xff1FCC79)),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  title: Text(
                    'Nama Bahan ${index + 1}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: const Text(
                    'Serving',
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }),
        )
      ]),
    );
  }
}
