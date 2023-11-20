import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:teman_dapur/home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  bool isAgree = false;
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
                  child: TextFormField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Full Name'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xfff5f6f8),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Email'),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xfff5f6f8),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Password'),
                  ),
                ),
                CheckboxListTile(
                    activeColor: const Color(0xff1FCC79),
                    checkColor: Colors.white,
                    title: const Text(
                        'I agree to the Terms of Service and Privacy Policy'),
                    value: isAgree,
                    onChanged: (value) {
                      setState(() {});
                      isAgree = value!;
                    }),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                    width: 300,
                    height: 55,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(const StadiumBorder()),
                        backgroundColor: MaterialStateProperty.all(
                            (isAgree) ? const Color(0xff1FCC79) : Colors.grey),
                      ),
                      onPressed: (isAgree)
                          ? () async {
                              User? user;
                              try {
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                user = credential.user;
                                await user!
                                    .updateDisplayName(fullNameController.text);
                                await user.reload();
                                user = FirebaseAuth.instance.currentUser;
                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const NavBar()));
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      invalidCreateUser(
                                          'The password provided is too weak.'));
                                } else if (e.code == 'email-already-in-use') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      invalidCreateUser(
                                          'The account already exists for that email.'));
                                } else if (e.code == 'invalid-email') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      invalidCreateUser(
                                          "Please provide a valid email"));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      invalidCreateUser(e.code.toString()));
                                }
                              }
                            }
                          : null,
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
    );
  }
}

SnackBar invalidCreateUser(String e) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.red,
    showCloseIcon: true,
    closeIconColor: Colors.white,
    padding: const EdgeInsets.all(10),
    content: Text(
      e,
      style: const TextStyle(fontSize: 16),
    ),
  );
}
