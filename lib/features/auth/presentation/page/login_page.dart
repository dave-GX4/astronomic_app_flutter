import 'package:app_rest/features/auth/presentation/widget/login_form_section.dart';
import 'package:app_rest/features/auth/presentation/widget/login_header_section.dart';
import 'package:app_rest/features/auth/presentation/widget/register_link_section.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuA4DUG-1bbqcS_JNJfp-bQtlRQaVdLq3295W8YRUo5tVRce47YquNwyxBlh7AqqLqUb1zzDAbIIeaDKXrGZ66_0YvhKH2DvkfO7o8UyxXxF0qzCkosLf0oQN0QfbEZ9Ak_oi1Dy7TY1TYbrgeWyZBd4IdlTwJKWZzs57vNbqOL5gR39ywc7eSOHsDB_CFLis_DFn5zGDuUrnYKa4vDAUq3wWerQcFT9t_pp6sqCRkrWydKz2gH_nwZrvKscYda-2SOPjWjR_oyddIc",
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF101622).withOpacity(0.7),
                    const Color(0xFF101622).withOpacity(0.85),
                    const Color(0xFF101622),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    LoginHeaderSection(),
                    SizedBox(height: 40),
                    
                    LoginFormSection(),
                    SizedBox(height: 40),
                    
                    RegisterLinkSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}