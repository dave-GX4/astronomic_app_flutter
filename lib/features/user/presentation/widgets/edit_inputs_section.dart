import 'package:app_rest/features/user/presentation/provider/edit_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditInputsSection extends StatelessWidget {
  const EditInputsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EditProfileProvider>();

    if (provider.isLoading && provider.nameController.text.isEmpty) {
       return SizedBox.shrink(); 
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Nombre Completo"),
        _buildTextField(
          controller: provider.nameController,
          icon: Icons.person_outline,
          hint: "Ingresa tu nombre",
        ),
        SizedBox(height: 20),
        
        _buildLabel("Correo Electrónico"),
        _buildTextField(
          controller: provider.emailController,
          icon: Icons.mail_outline,
          hint: "Ingresa tu correo",
          inputType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFcbd5e1),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF192233).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF324467)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        style: TextStyle(color: Colors.white),
        cursorColor: Color(0xFF135bec),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
          prefixIcon: Icon(icon, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }
}