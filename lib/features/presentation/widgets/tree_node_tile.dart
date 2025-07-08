
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TreeNodeTile extends StatefulWidget {
  final String title;
  final String iconPath;
  final List<Widget> Function()? buildChildren;
  final double indent;
  final bool initiallyExpanded;
  final Widget? statusIcon;

  const TreeNodeTile({
    super.key,
    required this.title,
    required this.iconPath,
    this.buildChildren,
    this.indent = 0,
    this.initiallyExpanded = false,
    this.statusIcon,
  });

  @override
  State<TreeNodeTile> createState() => _TreeNodeTileState();
}
class _TreeNodeTileState extends State<TreeNodeTile> {
  late bool _expanded;
  List<Widget>? _children;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
    if (_expanded && widget.buildChildren != null) {
      _children = widget.buildChildren!();
    }
  }

  @override
  void didUpdateWidget(covariant TreeNodeTile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initiallyExpanded != oldWidget.initiallyExpanded) {
      setState(() {
        _expanded = widget.initiallyExpanded;
        if (_expanded && widget.buildChildren != null) {
          _children = widget.buildChildren!();
        }
      });
    }
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded && _children == null && widget.buildChildren != null) {
        _children = widget.buildChildren!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.buildChildren != null ? _toggle : null,
          child: Padding(
            padding: EdgeInsets.only(left: widget.indent, top: 1, bottom: 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 18,
                  child: widget.buildChildren != null
                      ? Icon(
                          _expanded
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          size: 14,
                          color: Colors.grey[700],
                        )
                      : null,
                ),
                SvgPicture.asset(
                  widget.iconPath,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF1565C0),
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  widget.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (widget.statusIcon != null) ...[
                  const SizedBox(width: 4),
                  widget.statusIcon!,
                ],
              ],
            ),
          ),
        ),
        if (_expanded && _children != null)
          Container(
            margin: EdgeInsets.only(left: widget.indent + 6),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _children!,
            ),
          ),
      ],
    );
  }
}
