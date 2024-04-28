import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:portfolio_app/components/Confirm_Button.dart';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatefulWidget {
  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _descriptionController = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadImageToFirestore() async {
    if (_image == null) return;

    // Upload image to Firebase Storage
    final FirebaseStorage storage = FirebaseStorage.instance;
    final storageRef = storage.ref().child('images').child(DateTime.now().toString());
    final uploadTask = storageRef.putFile(File("D:/GSU Schoolwork/Mobile App Development/portfolio_app/lib/assets/dwayne-joe-oZVxodYxMVU-unsplash.jpg"));
    await uploadTask;

    // Get the download URL
    String imageURL = await storageRef.getDownloadURL();

    // Upload image URL to Firestore
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('images').add({
      'url': imageURL
    });

    // Show a success message or perform any other actions
    print('Image uploaded successfully!');
  }

  void _post() async {
    await uploadImageToFirestore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 5.0, bottom: 8),
              child: Text('Create a new post', textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Titillium web', fontSize: 20, height: 1)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: InkWell(
                onTap: () {
                  getImage();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: const Color.fromARGB(255, 212, 212, 212),
                    child: Icon(
                      Icons.image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: 'What do you want to say?'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
              child: ConfirmButton(text: 'Post your work', callback: _post),
            )
          ],
        ),
      ),
    );
  }
}
