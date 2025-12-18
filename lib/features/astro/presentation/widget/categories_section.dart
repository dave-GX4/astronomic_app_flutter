import 'package:app_rest/core/utils/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();
    final currentCategory = provider.selectedCategory;

    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: AppResources.categories.length,
          separatorBuilder: (_, __) => SizedBox(width: 12),
          itemBuilder: (context, index) {
            final categoryName = AppResources.categories[index];
            final isSelected = categoryName == currentCategory;

            return GestureDetector(
              onTap: () {
                context.read<HomeProvider>().setCategory(categoryName);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF135bec) : Color(0xFF232f48),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Color(0xFF135bec).withOpacity(0.4),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ]
                      : null,
                  border: isSelected ? null : Border.all(color: Colors.white10),
                ),
                child: Center(
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}