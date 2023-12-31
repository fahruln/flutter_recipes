import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:teman_dapur/database.dart';
import 'package:teman_dapur/home_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

enum ImageSourceType { gallery, camera }

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key, this.type});
  final type;

  @override
  State<AddRecipe> createState() => _AddRecipeState(type);
}

class _AddRecipeState extends State<AddRecipe> {
  File? _image;
  Uint8List? _imageByte;
  var imagePicker;
  var type;

  _AddRecipeState(this.type);

  final listChoices = <CategoryChoice>[
    CategoryChoice(1, 'Breakfast'),
    CategoryChoice(2, 'Lunch'),
    CategoryChoice(3, 'Dinner')
  ];
  int idSelected = 0;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController ingradientController = TextEditingController();
  final TextEditingController directionController = TextEditingController();

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
                XFile? image = await imagePicker.pickImage(
                    source: source,
                    imageQuality: 50,
                    preferredCameraDevice: CameraDevice.front);
                if (image != null) {
                  _image = File(image.path);
                  _imageByte = await image.readAsBytes();
                }
                setState(() {});
              },
              child: SizedBox(
                width: double.infinity - 40,
                height: 200,
                child: _imageByte != null
                    ? Image.memory(
                        _imageByte!,
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
              'Category',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2E3E5C),
                  fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: listChoices
                    .map((e) => ChoiceChip(
                          label: Text(e.label),
                          labelStyle: TextStyle(
                            color: idSelected == e.id ? Colors.white : null,
                            fontSize: 16,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          selected: idSelected == e.id,
                          onSelected: (_) => setState(() => idSelected = e.id),
                          selectedColor: const Color(0xff1FCC79),
                          backgroundColor: const Color(0xfff5f6f8),
                          showCheckmark: true,
                          checkmarkColor: Colors.white,
                        ))
                    .toList()),
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
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
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
              child: TextField(
                controller: ingradientController,
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: null,
                decoration: const InputDecoration(
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
              child: TextField(
                controller: directionController,
                keyboardType: TextInputType.multiline,
                minLines: 6,
                maxLines: null,
                decoration: const InputDecoration(
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
                  onPressed: () async {
                    var imageName =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    var storageRef =
                        FirebaseStorage.instance.ref().child('$imageName.jpg');
                    var metadata = SettableMetadata(
                      contentType: "image/jpeg",
                    );
                    var uploadTask = storageRef.putData(_imageByte!, metadata);
                    var downloadUrl =
                        await (await uploadTask).ref.getDownloadURL();
                    _handleDialogSubmission(
                        downloadUrl,
                        idSelected,
                        titleController.text,
                        ingradientController.text,
                        directionController.text);
                    if (context.mounted) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NavBar(),
                      ));
                    }
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
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
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

  void _handleDialogSubmission(String image, int category, String title,
      String ingradient, String direction) {
    var task = <String, dynamic>{
      'image': image,
      'category': category,
      'title': title,
      'ingradient': ingradient,
      'direction': direction,
      'timestamp': DateTime.now(),
      'username': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    };
    Database.addRecipe(task);
  }
}

class CategoryChoice {
  final int id;
  final String label;

  CategoryChoice(this.id, this.label);
}
