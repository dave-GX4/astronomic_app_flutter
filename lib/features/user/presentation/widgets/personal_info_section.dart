import 'package:app_rest/core/utils/app_resources.dart';
import 'package:app_rest/features/user/presentation/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonalInfoSection extends StatelessWidget {

  const PersonalInfoSection({super.key,});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final user = provider.user;

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.errorMessage != null) {
      return Center(
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 40),
            Text(
              "Error: ${provider.errorMessage}",
              style: const TextStyle(color: Colors.red),
            ),
            ElevatedButton(
              onPressed: () => provider.loadUserProfile(),
              child: const Text("Reintentar"),
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
          value: user?.name ?? "No disponible",
          icon: Icons.person_outline
        ),
        SizedBox(height: 16),

        _buildFieldLabel("Email"),
        _buildInfoContainer(
          value: user?.email ?? "No disponible",
          icon: Icons.email_outlined
        ),
        SizedBox(height: 16),

        _buildFieldLabel("Constelación Favorita"),
        _buildDropdownSimulation(
          value: "Orión",
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
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
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

  Widget _buildDropdownSimulation({
    required String value,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1f293b), // input-dark
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                dropdownColor: Color(0xFF1f293b),
                icon: Icon(Icons.expand_more, color: Colors.grey),
                style: TextStyle(color: Colors.white, fontSize: 16),
                onChanged: (newValue) {},
                items: AppResources.slected.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}