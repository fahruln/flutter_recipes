import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:teman_dapur/database.dart';
import 'package:teman_dapur/home_page.dart';
import 'package:teman_dapur/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teman_dapur/recipe.dart';
import 'firebase_options.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
            stream: auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const NavBar();
              }
              return const LoginPage();
            }));
  }
}

class StartedPage extends StatelessWidget {
  const StartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('images/Onboarding.png')),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Start Cooking',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Let`s join our community\nto cook better food!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Color(0xff9FA5C0)),
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
                width: 300,
                height: 55,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(const StadiumBorder()),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff1FCC79)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ));
  }

  // Retrieve Tasks
  Widget _getTasks() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('recipes')
            .where('category', isEqualTo: 1)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 2 / 2.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              padding: const EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) => RecipeGrid(
                image: snapshot.data!.docs[index]['image'],
                category: snapshot.data!.docs[index]['category'],
                title: snapshot.data!.docs[index]['title'],
                ingradient: snapshot.data!.docs[index]['ingradient'],
                direction: snapshot.data!.docs[index]['direction'],
                username: snapshot.data!.docs[index]['username'],
                id: snapshot.data!.docs[index].id,
              ),
              itemCount: snapshot.data!.docs.length,
            );
          } else {
            return Container();
          }
        });
  }

  void _updateTask(
      String title, String ingradient, String direction, String id) {
    var task = <String, dynamic>{
      'title': title,
      'ingradient': ingradient,
      'direction': direction,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    Database.updateRecipe(id, task);
  }

  void _deleteTask(String id) {
    Database.deleteRecipe(id);
  }
}
