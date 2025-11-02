import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  static const Color primaryGreen = Color(0xFF004D25);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, // ✅ Allow floating elements outside the stack
      alignment: Alignment.bottomCenter,
      children: [
        // The bottom navigation background
        Container(
          height: 65,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, "Home", 0),
              _buildNavItem(Icons.list_alt_outlined, "Problems", 1),
              const SizedBox(width: 60), // space for center button
              _buildNavItem(Icons.business_outlined, "Orgs", 2),
              _buildNavItem(Icons.person_outline, "Profile", 3),
            ],
          ),
        ),

        // Floating "+" button — now fully visible
        Positioned(
          top: -28, // ✅ move it higher
          child: GestureDetector(
            onTap: () {
              // define what happens when pressed
            },
            child: Container(
              width: 62,
              height: 62,
              decoration: const BoxDecoration(
                color: primaryGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = widget.selectedIndex == index;
    return GestureDetector(
      onTap: () => widget.onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? primaryGreen : Colors.grey[700],
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? primaryGreen : Colors.grey[700],
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
