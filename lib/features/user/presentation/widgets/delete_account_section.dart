import 'package:app_rest/core/router/routes.dart';
import 'package:app_rest/features/user/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DeleteAccountSection extends StatelessWidget {
  const DeleteAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xFF18202f),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFF7f1d1d).withOpacity(0.3),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                // 1. Mostrar diálogo
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    backgroundColor: Color(0xFF192233),
                    title: Text("¿Estás seguro?", style: TextStyle(color: Colors.white)),
                    content: Text(
                      "Esta acción eliminará tus datos permanentemente.",
                      style: TextStyle(color: Colors.grey),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: Text("Eliminar", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  final provider = context.read<ProfileProvider>();
                  final success = await provider.deleteAccount();

                  if (!context.mounted) return;

                  if (success) {
                      try {
                        context.goNamed(Routes.login);
                      } catch (e) {
                        Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                      }
                  } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(provider.errorMessage ?? "Error desconocido"),
                          backgroundColor: Colors.red,
                        ),
                      );
                  }
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Eliminar Cuenta",
                      style: TextStyle(
                        color: Color(0xFFef4444),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.delete_forever,
                      color: Color(0xFFf87171),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "Al eliminar tu cuenta, perderás acceso a todos tus avistamientos y configuraciones de telescopio.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}