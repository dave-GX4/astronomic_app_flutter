import 'package:app_rest/features/user/domain/entities/user.dart' show User;
import 'package:app_rest/features/user/presentation/provider/edit_profile_provider.dart';
import 'package:app_rest/features/user/presentation/widgets/edit_inputs_section.dart';
import 'package:app_rest/features/user/presentation/widgets/edit_selects_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EditProfileProvider>().loadInitialData(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EditProfileProvider>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Editar Perfil",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Color(0xFF101622),
              child: Image.asset(
                "assets/image/nebulosa.jpg",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF101622)),
              ),
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF101622).withOpacity(0.7),
                    Color(0xFF101622).withOpacity(0.8),
                    Color(0xFF101622),
                  ],
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  
                  EditInputsSection(),
                  SizedBox(height: 30),

                  EditSelectsSection(),
                  SizedBox(height: 40),

                  if (provider.errorMessage != null)
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        provider.errorMessage!,
                        style: TextStyle(color: Colors.redAccent, fontSize: 14),
                      ),
                    ),

                  ElevatedButton(
                    onPressed: provider.isLoading 
                      ? null 
                      : () async {
                          final success = await provider.saveChanges();
                          if (success && context.mounted) {
                            context.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Perfil cósmico actualizado"),
                                backgroundColor: Color(0xFF135bec),
                              )
                            );
                          }
                        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF135bec),
                      disabledBackgroundColor: Color(0xFF135bec).withOpacity(0.5),
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8,
                      shadowColor: Color(0xFF135bec).withOpacity(0.4),
                    ),
                    child: provider.isLoading 
                      ? SizedBox(
                          height: 24, width: 24, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : Text(
                          "Guardar Cambios",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                  ),
                  
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}