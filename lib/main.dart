import 'package:flutter/material.dart';
import 'package:teman_dapur/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: StartedPage());
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
}
