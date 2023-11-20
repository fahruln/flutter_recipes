import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teman_dapur/detail_page.dart';
import 'package:teman_dapur/login_page.dart';
import 'package:teman_dapur/saved_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teman_dapur/update_recipe.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 60,
          ),
          Text(
            '${FirebaseAuth.instance.currentUser!.displayName}',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontSize: 16),
              )),
          const SizedBox(
            height: 30,
          ),
          const Divider(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Your Recipes',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2E3E5C),
                    fontSize: 18),
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('recipes')
                    .where('userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (BuildContext context, int index) {
                        return MyRecipe(
                            image: snapshot.data!.docs[index]['image'],
                            category: snapshot.data!.docs[index]['category'],
                            title: snapshot.data!.docs[index]['title'],
                            ingradient: snapshot.data!.docs[index]
                                ['ingradient'],
                            direction: snapshot.data!.docs[index]['direction'],
                            id: snapshot.data!.docs[index].id);
                      },
                      itemCount: snapshot.data!.docs.length,
                    );
                  } else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    );
  }
}

class MyRecipe extends StatelessWidget {
  const MyRecipe({
    super.key,
    required this.image,
    required this.category,
    required this.title,
    required this.ingradient,
    required this.direction,
    required this.id,
  });

  final int category;
  final String image, title, ingradient, direction, id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => UpdateRecipe(
                  image: image,
                  category: category,
                  title: title,
                  ingradient: ingradient,
                  direction: direction,
                  id: id,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 120,
                      height: 100,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(image), fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 180,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  padding: const EdgeInsets.only(right: 10),
                  icon: const Icon(
                    Icons.chevron_right,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 2,
          color: Color(0xffF4F5F7),
        )
      ],
    );
  }
}
