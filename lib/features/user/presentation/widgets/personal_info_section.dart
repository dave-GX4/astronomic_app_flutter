import 'package:app_rest/features/user/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInfoSection extends StatelessWidget {

  const PersonalInfoSection({super.key,});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final user = provider.user;

    String _getValidText(String? value, String defaultText) {
      if (value == null || value.trim().isEmpty) {
        return defaultText;
      }
      return value;
    }

    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 40),
            Text(
              "Error: ${provider.errorMessage}",
              style: TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              onPressed: () => provider.loadUserProfile(),
              child: Text("Reintentar"),
            )
          ],
        ),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.0, bottom: 16.0),
          child: Text(
            "Información Personal",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        
        _buildFieldLabel("Nombre Completo"),
        _buildInfoContainer(
          value: _getValidText(user?.name, "Nombre no disponible"),
          icon: Icons.person_outline
        ),
        SizedBox(height: 16),

        _buildFieldLabel("Email"),
        _buildInfoContainer(
          value: _getValidText(user?.email, "Email no disponible"),
          icon: Icons.email_outlined
        ),
        SizedBox(height: 16),

        _buildFieldLabel("Constelación Favorita"),
        _buildInfoContainer(
          value: _getValidText(user?.constellation, "Sin Favoritos"),
          icon: Icons.star_outline,
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0, bottom: 6.0),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoContainer({required String value, required IconData icon}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1f293b),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}