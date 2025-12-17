import 'package:flutter/material.dart';

class HeaderImageSection extends StatelessWidget {
  const HeaderImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF135bec).withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
          image: DecorationImage(
            image: NetworkImage(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuDgCJ0hXIfYvaKdAF2mYWG2jNgzcb0_qLkN6HE5dXvYTFWBBNr1rjrG9AikKq0jcL1Yc7wrlicrtxSkJpu4Bh4xDFJq2N7cCMx_lY016Pi1Dp-dSGZOnsJJ1t4jDUPcYzKnbVykU6dJBg6MokvEt4u7m8ligNvj0u_AyUXEsNk49YmfRXCDR4-KSHLZnFhvU6bxRReEsPHcMLARZscVZH5KOY68P7a2vk23TX5DGijzyySWCUT9m0-R_rCzJ__hcU8MqkSYe8P6pno",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Gradiente oscuro inferior (simulando el HTML)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xFF101622).withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),
            // Icono del cohete
            Positioned(
              bottom: 16,
              left: 16,
              child: Icon(
                Icons.rocket_launch,
                size: 48,
                color: Color(0xFF135bec), // Color primario
                shadows: [
                  Shadow(
                    blurRadius: 15.0,
                    color: Color(0xFF135bec).withOpacity(0.5),
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}