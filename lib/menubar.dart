import 'package:flutter/material.dart';
import 'dart:ui';

class MenuWidget extends StatelessWidget {
  final Function(String) onItemSelected;
  final List<String> menuItems = ["Home", "About", "Services", "Contact"];

  MenuWidget({required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.25),
                Colors.white.withOpacity(0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 25,
                spreadRadius: 5,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:
                menuItems.map((item) {
                  return _HoverMenuButton(
                    label: item,
                    onPressed: () => onItemSelected(item),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}

class _HoverMenuButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _HoverMenuButton({required this.label, required this.onPressed});

  @override
  State<_HoverMenuButton> createState() => _HoverMenuButtonState();
}

class _HoverMenuButtonState extends State<_HoverMenuButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed, // ✅ Make it clickable (important!)
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:
                _isHovering
                    ? Colors.white.withOpacity(0.15)
                    : Colors.transparent,
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _isHovering ? Colors.white : Colors.white.withOpacity(0.9),
              shadows:
                  _isHovering
                      ? [
                        Shadow(
                          color: Colors.white.withOpacity(0.8),
                          blurRadius: 8,
                        ),
                      ]
                      : [],
            ),
          ),
        ),
      ),
    );
  }
}
