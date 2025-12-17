import 'package:app_rest/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginLinkSection extends StatelessWidget {
  const LoginLinkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿Ya tienes cuenta?",
          style: TextStyle(
            color: Color(0xFF94a3b8),
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            context.pushNamed(Routes.login);
          },
          child: const Text(
            "Inicia sesion",
            style: TextStyle(
              color: Color(0xFF135bec),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}