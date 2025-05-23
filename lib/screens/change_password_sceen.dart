import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_plus/controllers/auth_controller.dart';
import 'package:grocery_plus/widgets/custom_text_field.dart';
import 'package:grocery_plus/widgets/primary_button.dart';

class ChangePasswordSceen extends StatefulWidget {
  const ChangePasswordSceen({super.key});

  @override
  State<ChangePasswordSceen> createState() => _ChangePasswordSceenState();
}

class _ChangePasswordSceenState extends State<ChangePasswordSceen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  var controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(

          padding: const EdgeInsets.all(16.0),

          child: SingleChildScrollView(
            
            child: Column(
              children: [
                CustomTextField( 
                    hintText: "Enter Your Email",
                    controller: emailController,
                    prefixIcon: Icon(Icons.email),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                    hintText: "Enter Your old Password",
                    controller: passwordController,
                    prefixIcon: Icon(Icons.lock),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: "Enter your new password",
                  controller: newPasswordController,
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                const SizedBox(height: 300),
                PrimaryButton(
                    title: "Update",
                    ontap: () {
                      controller.changePassword(emailController.text,
                          passwordController.text, newPasswordController.text);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}