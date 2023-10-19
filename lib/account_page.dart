import 'package:flutter/material.dart';
import 'package:teman_dapur/detail_page.dart';
import 'package:teman_dapur/saved_page.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Fahrul Nazar',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 40,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SavePage(),
                  ),
                );
              },
              title: const Text('Liked Recipes'),
              leading: const Icon(Icons.favorite_outline),
              trailing: const Icon(Icons.navigate_next),
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
              child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const DetailPage(),
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
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'images/nasigoreng.jpg'),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    const Text(
                                      'Nasi Goreng',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  padding: const EdgeInsets.only(right: 10),
                                  icon: const Icon(
                                    Icons.more_horiz,
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
