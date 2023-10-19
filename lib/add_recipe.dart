import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:teman_dapur/home_page.dart';

enum ImageSourceType { gallery, camera }

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key, this.type});
  final type;

  @override
  State<AddRecipe> createState() => _AddRecipeState(type);
}

class _AddRecipeState extends State<AddRecipe> {
  var _image;
  var imagePicker;
  var type;

  _AddRecipeState(this.type);

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Make Recipe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                var source = type == ImageSourceType.camera
                    ? ImageSource.camera
                    : ImageSource.gallery;
                XFile image = await imagePicker.pickImage(
                    source: source,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);
                setState(() {
                  _image = File(image.path);
                });
              },
              child: SizedBox(
                width: double.infinity - 40,
                height: 200,
                child: _image != null
                    ? Image.file(
                        _image,
                        width: double.infinity,
                        height: 200.0,
                        fit: BoxFit.cover,
                      )
                    : DottedBorder(
                        color: const Color(0xff1FCC79),
                        strokeWidth: 2,
                        dashPattern: const [
                          7,
                          7,
                        ],
                        child: const SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Icon(
                            Icons.photo,
                            color: Color(0xff1FCC79),
                            size: 70,
                          ),
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Title',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E3E5C),
                  fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: const Color(0xfff5f6f8),
                  borderRadius: BorderRadius.circular(10)),
              child: const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Ex: Nasi Goreng'),
              ),
            ),
            const Text(
              'Ingradient',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E3E5C),
                  fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: const Color(0xfff5f6f8),
                  borderRadius: BorderRadius.circular(10)),
              child: const TextField(
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const Text(
              'Direction',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E3E5C),
                  fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: const Color(0xfff5f6f8),
                  borderRadius: BorderRadius.circular(10)),
              child: const TextField(
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xff1FCC79)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NavBar(),
                    ));
                    const snackBar = SnackBar(
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Color(0xff1FCC79),
                      showCloseIcon: true,
                      closeIconColor: Colors.white,
                      padding: EdgeInsets.all(10),
                      content: Text(
                        'Recipe has been successfully added',
                        style: TextStyle(fontSize: 16),
                      ),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text(
                    'Add Recipe',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
