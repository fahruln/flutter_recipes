import 'package:flutter/material.dart';
import 'package:teman_dapur/home_page.dart';
import 'package:teman_dapur/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? _password;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  'Welcome!',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2E3E5C)),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'I am so happy to see. You can continue to login for looking a recipe',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Color(0xff9FA5C0)),
                ),
                const SizedBox(
                  height: 60,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const ShapeDecoration(
                      color: Color(0xfff5f6f8), shape: StadiumBorder()),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Email'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const ShapeDecoration(
                      color: Color(0xfff5f6f8), shape: StadiumBorder()),
                  child: TextFormField(
                    controller: passwordController,
                    onSaved: (val) => _password = val,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintStyle: const TextStyle(color: Colors.grey),
                        hintText: 'Password',
                        suffixIcon: IconButton(
                            onPressed: _toggle,
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xff9FA5C0),
                            ))),
                  ),
                ),
                const SizedBox(
                  height: 50,
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
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          if (context.mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const NavBar(),
                              ),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                invalidCreateUser(
                                    'No user found for that email.'));
                          } else if (e.code == 'wrong-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                invalidCreateUser(
                                    'Wrong password provided for that user.'));
                          } else if (e.code == 'invalid-email') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                invalidCreateUser(
                                    "Please provide a valid email"));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                invalidCreateUser(e.code.toString()));
                          }
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Dont have an account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1FCC79),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

SnackBar invalidUserLogin(String e) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    backgroundColor: Colors.red,
    closeIconColor: Colors.white,
    padding: const EdgeInsets.all(10),
    content: Text(
      e,
      style: const TextStyle(fontSize: 16),
    ),
  );
}
