import 'package:app_rest/features/auth/presentation/widget/header_image_section.dart';
import 'package:app_rest/features/auth/presentation/widget/login_link_section.dart';
import 'package:app_rest/features/auth/presentation/widget/registration_form_section.dart';
import 'package:app_rest/features/auth/presentation/widget/welcome_title_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF101622).withOpacity(0.9),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          "Crear Cuenta",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 10),
            HeaderImageSection(),
            WelcomeTitleSection(),
            RegistrationFormSection(),
            LoginLinkSection(),
            
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}