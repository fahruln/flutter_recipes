import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:teman_dapur/account_page.dart';
import 'package:teman_dapur/add_recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teman_dapur/detail_page.dart';
import 'package:teman_dapur/recipe.dart';

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

  String? searchKey;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 40),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const ShapeDecoration(
                        color: Color(0xfff5f6f8), shape: StadiumBorder()),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchKey = value;
                        });
                      },
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(vertical: 25.0),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
                          label: Row(
                            children: [
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
                ],
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              controller: tabController,
              tabs: const [
                Tab(
                  text: 'All',
                ),
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
              indicatorColor: const Color(0xff1FCC79),
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              labelColor: Colors.grey,
              unselectedLabelColor: Colors.grey,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: TabBarView(controller: tabController, children: [
            StreamBuilder(
                stream: searchKey == null
                    ? FirebaseFirestore.instance
                        .collection('recipes')
                        .snapshots()
                    : FirebaseFirestore.instance
                        .collection('recipes')
                        .where('title', isEqualTo: searchKey)
                        .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2 / 2.5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (BuildContext context, int index) {
                        return RecipeGrid(
                          image: snapshot.data!.docs[index]['image'],
                          category: snapshot.data!.docs[index]['category'],
                          title: snapshot.data!.docs[index]['title'],
                          ingradient: snapshot.data!.docs[index]['ingradient'],
                          direction: snapshot.data!.docs[index]['direction'],
                          username: snapshot.data!.docs[index]['username'],
                          id: snapshot.data!.docs[index].id,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return Container();
                  }
                }),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('recipes')
                    .where('category', isEqualTo: 1)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2 / 2.5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (BuildContext context, int index) {
                        return RecipeGrid(
                          image: snapshot.data!.docs[index]['image'],
                          category: snapshot.data!.docs[index]['category'],
                          title: snapshot.data!.docs[index]['title'],
                          ingradient: snapshot.data!.docs[index]['ingradient'],
                          direction: snapshot.data!.docs[index]['direction'],
                          username: snapshot.data!.docs[index]['username'],
                          id: snapshot.data!.docs[index].id,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return Container();
                  }
                }),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('recipes')
                    .where('category', isEqualTo: 2)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2 / 2.5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      padding: const EdgeInsets.all(10.0),
                      itemBuilder: (BuildContext context, int index) {
                        return RecipeGrid(
                          image: snapshot.data!.docs[index]['image'],
                          category: snapshot.data!.docs[index]['category'],
                          title: snapshot.data!.docs[index]['title'],
                          ingradient: snapshot.data!.docs[index]['ingradient'],
                          direction: snapshot.data!.docs[index]['direction'],
                          username: snapshot.data!.docs[index]['username'],
                          id: snapshot.data!.docs[index].id,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return Container();
                  }
                }),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('recipes')
                    .where('category', isEqualTo: 3)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2 / 2.5,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      padding: const EdgeInsets.all(10.0),
                      itemBuilder: (BuildContext context, int index) {
                        return RecipeGrid(
                          image: snapshot.data!.docs[index]['image'],
                          category: snapshot.data!.docs[index]['category'],
                          title: snapshot.data!.docs[index]['title'],
                          ingradient: snapshot.data!.docs[index]['ingradient'],
                          direction: snapshot.data!.docs[index]['direction'],
                          username: snapshot.data!.docs[index]['username'],
                          id: snapshot.data!.docs[index].id,
                        );
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return Container();
                  }
                }),
          ]),
        ),
      ),
    );
  }
}
