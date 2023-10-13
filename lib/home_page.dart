import 'package:flutter/material.dart';
import 'package:teman_dapur/detail_page.dart';
import 'package:teman_dapur/saved_page.dart';
import 'package:teman_dapur/search_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    SavePage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmarks), label: 'Favorite')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xff1FCC79),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  Set selection = {};

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Make your own food,\nstay at home',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          TabBar(
            controller: tabController,
            tabs: const [
              Tab(
                text: 'Breakfast',
              ),
              Tab(
                text: 'Lunch',
              ),
              Tab(
                text: 'Dinner',
              ),
            ],
            indicator: const ShapeDecoration(
                shape: StadiumBorder(), color: Color(0xff1FCC79)),
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 3,
            color: Color(0xffF4F5F7),
          ),
          const SizedBox(height: 20),
          const Text(
            'Recommended for you',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff2E3E5C),
                fontSize: 18),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const DetailPage(),
                        ),
                      );
                    },
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        margin: const EdgeInsets.only(right: 20),
                        padding: const EdgeInsets.all(20),
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff1FCC79)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Food Name',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            IconButton(
                                padding: const EdgeInsets.only(bottom: 10),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.bookmark_outline,
                                  size: 40,
                                  color: Colors.white,
                                ))
                          ],
                        )),
                  );
                }),
          ),
          const SizedBox(height: 20),
          const Text(
            'Popular',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff2E3E5C),
                fontSize: 18),
          ),
          const SizedBox(height: 20),
          GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 2.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: 4,
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DetailPage(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color(0xff1FCC79),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              padding: const EdgeInsets.only(bottom: 10),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.bookmark_outline,
                                size: 40,
                                color: Colors.white,
                              )),
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ]),
      ),
    );
  }
}
