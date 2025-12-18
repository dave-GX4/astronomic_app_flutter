import 'package:app_rest/core/router/routes.dart';
import 'package:app_rest/features/user/presentation/provider/profile_provider.dart';
import 'package:app_rest/features/user/presentation/widgets/account_settings_section.dart';
import 'package:app_rest/features/user/presentation/widgets/delete_account_section.dart';
import 'package:app_rest/features/user/presentation/widgets/logout_section.dart';
import 'package:app_rest/features/user/presentation/widgets/personal_info_section.dart';
import 'package:app_rest/features/user/presentation/widgets/profile_header_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  
  @override
  void initState() {
    final providerLoad = context.read<ProfileProvider>();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      providerLoad.loadUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF101622).withOpacity(0.9),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF135bec)),
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          "Mi Perfil",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final provider = context.read<ProfileProvider>();

              if (provider.user != null) {
                final result = await context.pushNamed(
                  Routes.editProfile, 
                  extra: provider.user
                );

                if (result == true && context.mounted) {
                  provider.loadUserProfile();
                }
              }
            }, 
            child: Text(
              'Editar Datos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14
              ),
            )
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            color: Colors.white.withOpacity(0.05),
            height: 1.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeaderSection(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PersonalInfoSection(),
                  SizedBox(height: 32),

                  AccountSettingsSection(),
                  SizedBox(height: 32),

                  DeleteAccountSection(),
                  SizedBox(height: 24),

                  LogoutSection(),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}