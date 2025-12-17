import 'package:app_rest/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterLinkSection extends StatelessWidget {
  const RegisterLinkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "¿No tienes una cuenta?",
          style: TextStyle(
            color: Color(0xFF94a3b8),
            fontSize: 14,
          ),
        ),
        TextButton(
          onPressed: () {
            context.pushNamed(Routes.registre);
          },
          child: const Text(
            "Regístrate",
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