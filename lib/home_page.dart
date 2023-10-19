import 'package:flutter/material.dart';
import 'package:teman_dapur/account_page.dart';
import 'package:teman_dapur/add_recipe.dart';
import 'package:teman_dapur/detail_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final PageController _myPage = PageController(initialPage: 0);

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
      body: PageView(
        controller: _myPage,
        onPageChanged: (i) {
          _onItemTapped(i);
        },
        children: const [HomePage(), AccountPage()],
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 7,
        shape: const CircularNotchedRectangle(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  alignment: Alignment.topCenter,
                  onPressed: () {
                    _myPage.jumpToPage(0);
                  },
                  icon: Icon(
                    Icons.home_filled,
                    size: 28,
                    color: _selectedIndex == 0
                        ? const Color(0xff1FCC79)
                        : Colors.grey,
                  )),
              IconButton(
                  alignment: Alignment.topCenter,
                  onPressed: () {
                    _myPage.jumpToPage(1);
                  },
                  icon: Icon(
                    Icons.person,
                    size: 28,
                    color: _selectedIndex == 1
                        ? const Color(0xff1FCC79)
                        : Colors.grey,
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FittedBox(
          child: FloatingActionButton(
            elevation: 0,
            backgroundColor: const Color(0xff1FCC79),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddRecipe(),
                ),
              );
            },
            child: const Icon(
              Icons.add,
              size: 28,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          Container(
            margin: const EdgeInsets.only(bottom: 30, top: 40),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const ShapeDecoration(
                color: Color(0xfff5f6f8), shape: StadiumBorder()),
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.symmetric(vertical: 25.0),
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  labelStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                  label: Row(
                    children: const [
                      Icon(
                        Icons.search,
                        size: 35,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Ingradient or dishes')
                    ],
                  )),
            ),
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
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('images/nasigoreng.jpg'),
                            fit: BoxFit.cover),
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
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 10, bottom: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff1FCC79)),
                                  child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.favorite_outline,
                                        size: 28,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Nasi Goreng',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Fahrul Nazar',
                                      style: TextStyle(
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
              }),
        ]),
      ),
    );
  }
}
