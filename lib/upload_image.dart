import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

Future<String> uploadImageToFirebaseStorage(XFile image) async {
  // Get a reference to Firebase Storage
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  firebase_storage.Reference ref = storage.ref().child('images/$fileName');

  try {
    firebase_storage.UploadTask uploadTask = ref.putFile(File(image.path));

    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (e) {
    print("Error uploading image: $e");
    return "";
  }
}