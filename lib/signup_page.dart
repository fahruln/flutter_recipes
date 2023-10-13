import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Create a New Account',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2E3E5C)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Create an account so you can looking\nfor a recipe',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xfff5f6f8),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const TextField(
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Username'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xfff5f6f8),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const TextField(
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Email'),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xfff5f6f8),
                        borderRadius: BorderRadius.circular(10)),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintStyle: TextStyle(color: Colors.grey),
                          hintText: 'Password'),
                    ),
                  ),
                  CheckboxListTile(
                      title: const Text(
                          'I agree to the Terms of Service and Privacy Policy'),
                      value: false,
                      onChanged: (value) {}),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                      width: 300,
                      height: 55,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all(const StadiumBorder()),
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff1FCC79)),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'I already have an account!',
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              color: Color(0xff1FCC79),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
