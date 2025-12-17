import 'package:app_rest/core/router/routes.dart';
import 'package:app_rest/features/auth/presentation/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoginProvider>();


    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (provider.errorMessage != null)
           Container(
             padding: EdgeInsets.all(10),
             color: Colors.red.withOpacity(0.2),
             child: Text(provider.errorMessage!, style: TextStyle(color: Colors.red)),
           ),

        _buildLabel("Correo electrónico"),
        SizedBox(height: 8),
       
        _buildInput(
          hint: "ejemplo@correo.com",
          prefixIcon: Icons.mail_outline,
          inputType: TextInputType.emailAddress,
          controller: provider.emailController,
        ),
        SizedBox(height: 20),

        _buildLabel("Contraseña"),
        SizedBox(height: 8),
        
        _buildInput(
          hint: "••••••••",
          prefixIcon: Icons.lock_outline,
          isPassword: true,
          obscureText: _obscurePassword,
          controller: provider.passwordController,
          onVisibilityToggle: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),

        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                "¿Olvidaste tu contraseña?",
                style: TextStyle(
                  color: Color(0xFF135bec),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: 24),

        ElevatedButton(
          onPressed: provider.isLoading ? null : () async {
                final success = await context.read<LoginProvider>().login();
                
                if (success && context.mounted) {
                   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Bienvenido, explorador."))
                   );
                   context.read<LoginProvider>().resetForm();
                   context.goNamed(Routes.home);
                }
            },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF135bec),
            foregroundColor: Colors.white,
            minimumSize: Size(double.infinity, 56),
            elevation: 10,
            shadowColor: Color(0xFF135bec).withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: provider.isLoading ? CircularProgressIndicator(color: Colors.white) : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "INICIAR SESIÓN",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFcbd5e1),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInput({
    required String hint,
    required IconData prefixIcon,
    bool isPassword = false,
    bool obscureText = false,
    TextInputType inputType = TextInputType.text,
    VoidCallback? onVisibilityToggle,
    TextEditingController? controller,
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
        obscureText: isPassword ? obscureText : false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFF64748b)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16),
          prefixIcon: Icon(
            prefixIcon,
            color: Color(0xFF64748b),
            size: 20,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Color(0xFF64748b),
                    size: 20,
                  ),
                  onPressed: onVisibilityToggle,
                )
              : null,
        ),
      ),
    );
  }
}