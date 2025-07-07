import 'package:flutter/material.dart';

class ChipFilterWidget extends StatelessWidget {
  const ChipFilterWidget({
    super.key,
    required this.isSelected,
    required this.textLabel,
    required this.icon,
    this.iconSize,
    this.onChanged,
  });

  final ValueNotifier<bool> isSelected;
  final String textLabel;
  final IconData icon;
  final double? iconSize;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSelected,
      builder: (context, selected, _) {
        return FilterChip(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          label: Text(
            textLabel,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : const Color(0xff77818C),
              fontSize: 14,
            ),
          ),
          avatar: Icon(icon, color: selected ? Colors.white : const Color(0xff77818C), size: iconSize ?? 18),
          side: BorderSide(width: 0.7, color: selected ? const Color(0xff2188FF) : Colors.grey.shade400),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          selected: selected,
          showCheckmark: false,
          selectedColor: const Color(0xff2188FF),
          backgroundColor: Colors.white,
          onSelected: onChanged,
        );
      },
    );
  }
}
