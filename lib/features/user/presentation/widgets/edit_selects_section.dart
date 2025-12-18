import 'package:app_rest/core/utils/app_resources.dart';
import 'package:app_rest/features/user/presentation/provider/edit_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSelectsSection extends StatelessWidget {
  const EditSelectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<EditProfileProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        _buildLabel("Constelación Favorita"),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFF192233).withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF324467)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: AppResources.constellations.contains(provider.selectedConstellation) 
                  ? provider.selectedConstellation 
                  : AppResources.constellations.first,
              isExpanded: true,
              icon: Icon(Icons.expand_more, color: Colors.grey),
              dropdownColor: Color(0xFF192233),
              style: TextStyle(color: Colors.white, fontSize: 16),
              onChanged: (val) => provider.setConstellation(val!),
              items: AppResources.constellations.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Row(
                    children: [
                      Icon(Icons.star_outline, size: 20, color: Color(0xFF135bec)),
                      SizedBox(width: 12),
                      Text(item),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),

        SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabel("Etiquetas de Perfil"),
            Text(
              "${provider.selectedTags.length}/3",
              style: TextStyle(
                color: provider.selectedTags.length == 3 ? const Color(0xFF135bec) : Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF192233).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF324467).withOpacity(0.5)),
          ),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: AppResources.availableTags.map((tag) {
              final isSelected = provider.selectedTags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: isSelected,
                onSelected: (bool selected) {
                  if (!isSelected && provider.selectedTags.length >= 3) {
                     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                         content: Text("Solo puedes elegir hasta 3 etiquetas"),
                         duration: Duration(seconds: 2),
                       )
                     );
                     return;
                  }
                  provider.toggleTag(tag);
                },
                backgroundColor: Color(0xFF101622),
                selectedColor: Color(0xFF135bec).withOpacity(0.2),
                checkmarkColor: Color(0xFF135bec),
                labelStyle: TextStyle(
                  color: isSelected ? Color(0xFF135bec) : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: isSelected ? Color(0xFF135bec) : Colors.grey.withOpacity(0.3),
                  ),
                ),
              );
            }).toList(),
          ),
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
}