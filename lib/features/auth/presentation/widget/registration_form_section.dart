import 'package:app_rest/features/auth/presentation/providers/registre_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegistrationFormSection extends StatefulWidget {
  const RegistrationFormSection({super.key});

  @override
  State<RegistrationFormSection> createState() => _RegistrationFormSectionState();
}

class _RegistrationFormSectionState extends State<RegistrationFormSection> {
  bool _obscurePassword = true;
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
       context.read<RegistreProvider>().resetForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    final providerWatch = context.watch<RegistreProvider>();
    final providerRead = context.read<RegistreProvider>();
    
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (providerWatch.errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(providerWatch.errorMessage!, style: TextStyle(color: Colors.red)),
            ),

          _buildLabel("Nombre de explorador"),
          _buildInput(
            hint: "Ej. Carl Sagan",
            icon: Icons.person_outline,
            controller: providerWatch.nameController,
          ),
          SizedBox(height: 20),

          _buildLabel("Correo electrónico"),
          _buildInput(
            hint: "tucorreo@ejemplo.com",
            icon: Icons.mail_outline,
            inputType: TextInputType.emailAddress,
            controller: providerWatch.emailController,
          ),
          SizedBox(height: 20),

          _buildLabel("Contraseña"),
          _buildInput(
            hint: "••••••••",
            isPassword: true,
            obscureText: _obscurePassword,
            controller: providerWatch.passwordController,
            onVisibilityToggle: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          SizedBox(height: 30),

          ElevatedButton(
            onPressed: providerWatch.isLoading ? null : () async {
              final success = await providerWatch.register();
              if (success && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("¡Despegue exitoso! Inicia sesión.")),
                  );
                  providerRead.resetForm();
                  context.pop();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF135bec),
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              shadowColor: Color(0xFF135bec).withOpacity(0.3),
            ),
            child: providerWatch.isLoading ? CircularProgressIndicator(color: Colors.white) : Text(
              "Despegar",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInput({
    required String hint,
    IconData? icon,
    bool isPassword = false,
    bool obscureText = false,
    TextInputType inputType = TextInputType.text,
    VoidCallback? onVisibilityToggle,
    TextEditingController? controller
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF192233),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF324467)),
      ),
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        obscureText: isPassword ? obscureText : false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF92a4c9)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Color(0xFF92a4c9),
                  ),
                  onPressed: onVisibilityToggle,
                )
              : Icon(icon, color: Color(0xFF92a4c9)),
        ),
      ),
    );
  }
}