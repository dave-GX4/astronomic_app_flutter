import 'package:flutter/material.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 12.0),
          child: Text(
            "Cuenta",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF18202f),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(
            children: [
              _buildSettingItem(
                title: "Cambiar Contraseña",
                icon: Icons.lock_outline,
                onTap: () {},
              ),
              
              Divider(height: 1, color: Colors.white.withOpacity(0.05)),
              
              _buildSettingItem(
                title: "Notificaciones",
                icon: Icons.notifications_none,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Icono con fondo azul claro
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF135bec).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF135bec), size: 20),
              ),
              const SizedBox(width: 14),
              // Texto
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              // Icono flecha derecha
              const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}