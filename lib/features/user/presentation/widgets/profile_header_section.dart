import 'package:app_rest/features/user/presentation/provider/profile_provider.dart';
import 'package:app_rest/features/user/presentation/widgets/animated_tags_viewer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    final user = provider.user;

    final List<String> userTags = (user?.tags ?? [])
      .where((tag) => tag.trim().isNotEmpty)
      .toList();

    final displayTags = userTags.isEmpty ? ["EXPLORADOR DE NEBULOSAS"] : userTags;

    if (provider.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: 32, bottom: 40),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topCenter,
          radius: 0.8,
          colors: [
            Color(0xFF135bec).withOpacity(0.15),
            Color(0xFF101622),
          ],
          stops: [0.0, 1.0],
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 112,
                height: 112,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF135bec).withOpacity(0.3), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF135bec).withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 0,
                    )
                  ],
                  image: DecorationImage(
                    image: NetworkImage(user?.image ?? 'https://images.unsplash.com/photo-1636819488537-a9b1ffb315ce?q=80&w=1932&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFF135bec),
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF101622), width: 3),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
                    ],
                  ),
                  child: Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          Text(
            user?.name ?? "No disponible",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 6),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: Color(0xFF135bec), size: 18),
              SizedBox(width: 6),
              Flexible(
                child: AnimatedTagsViewer(
                  tags: displayTags,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}