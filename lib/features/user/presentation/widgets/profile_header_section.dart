import 'package:flutter/material.dart';

class ProfileHeaderSection extends StatelessWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                    image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuBb9zi3WXhX5__SAKmRx9hYczJzH_mG0srPwuFAXwFEZFqVFq9gaAh4tiBXBiqCNEZv2FxmLAaOYfttlkki1PUmgL5RA8IqiKw8xU11ltgY2crZ5BLNE_ar5L4d__uuLNVVhaZCHkXPL_KmbUpdp-fyfnsoH3YBcRmdJ2Kl_-0lCjwUR09eDc9dhk8AdzG_Cq0e0EZdov71DoxKO_lKiJ7vaPNbQdPf9tOKzMBC5bD5esEw-P_u023DrtdcCnJXZLslqJIUdYT0KIU"),
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
            "Juan Pérez",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: Color(0xFF135bec), size: 18),
              SizedBox(width: 6),
              Text(
                "EXPLORADOR DE NEBULOSAS",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}