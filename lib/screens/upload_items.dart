import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_plus/Models/grocery_model.dart';
import 'package:grocery_plus/constants/colors.dart';
import 'package:grocery_plus/screens/bottom_Nav_bar.dart';
import 'package:grocery_plus/upload_image.dart';
import 'package:grocery_plus/widgets/custom_text_field.dart';
import 'package:grocery_plus/widgets/primary_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class UploadItems extends StatefulWidget {
  const UploadItems({super.key});

  @override
  State<UploadItems> createState() => _UploadItemsState();
}

class _UploadItemsState extends State<UploadItems> {
  final nameController = TextEditingController();
  final diController = TextEditingController();
  final priceController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  XFile? imageFile;
  bool isLoading = false;

  Future<void> pickImage() async {
    try {
      final selectedImage = await picker.pickImage(source: ImageSource.camera);
      if (selectedImage != null) {
        setState(() => imageFile = selectedImage);
      }
    } catch (e) {
      debugPrint("Error while picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to pick image."),
      ));
    }
  }

  void uploadData() async {
    if (imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select an image")),
      );
      return;
    }

    if (nameController.text.isEmpty ||
        diController.text.isEmpty ||
        priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("All fields are required")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final imageUrl = await uploadImageToFirebaseStorage(imageFile!);
      final productId = const Uuid().v1();

      final item = Items(
        name: nameController.text.trim(),
        imageUrl: imageUrl,
        descritpion: diController.text.trim(),
        price: priceController.text.trim(),
        productId: productId,
      );

      await firestore.collection("products").doc(productId).set(item.toJson());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Item uploaded successfully")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavBar()),
      );
    } catch (e) {
      debugPrint("Upload error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error uploading item: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    diController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.fontColor),
                        ),
                        child: imageFile != null
                            ? Image.file(File(imageFile!.path), fit: BoxFit.cover)
                            : Center(
                                child: InkWell(
                                  onTap: pickImage,
                                  child: const Icon(Icons.add_a_photo),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        hintText: "Enter Product Name",
                        controller: nameController,
                        prefixIcon: const Icon(Icons.shopping_cart),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hintText: "Enter Product description",
                        controller: diController,
                        maxLines: 4,
                        prefixIcon: const Icon(Icons.description),
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        hintText: "Enter Product price",
                        controller: priceController,
                        prefixIcon: const Icon(Icons.attach_money),
                      ),
                      const SizedBox(height: 50),
                      PrimaryButton(
                        title: "Upload",
                        ontap: uploadData,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
