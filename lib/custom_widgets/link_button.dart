import 'package:flutter/material.dart';

import 'markdown_config.dart';

/// A custom button widget that displays a link with customizable colors and styles.
///
/// The [LinkButton] widget is used to create a button that displays a link in the UI.
/// It takes a [text] parameter which is the text of the link,
/// a [config] parameter which is the configuration for the link,
/// a [color] parameter to set the color of the link,

class LinkButton extends StatefulWidget {
  /// The text of the link.
  final String text;

  /// The child of the link.
  final Widget? child;

  /// The callback function to be called when the link is pressed.
  final VoidCallback? onPressed;

  /// The style of the text.
  final TextStyle? textStyle;

  /// The URL of the link.
  final String? url;

  /// The configuration for the link.
  final GptMarkdownConfig config;

  /// The color of the link.
  final Color color;

  /// The color of the link when hovering.
  final Color hoverColor;

  const LinkButton({
    super.key,
    required this.text,
    required this.config,
    required this.color,
    required this.hoverColor,
    this.onPressed,
    this.textStyle,
    this.url,
    this.child,
  });

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    var style = (widget.config.style ?? const TextStyle()).copyWith(
      color: _isHovering ? widget.hoverColor : widget.color,
      decoration: TextDecoration.underline,
      decorationColor: _isHovering ? widget.hoverColor : widget.color,
    );
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTapDown: (_) => _handlePress(true),
        onTapUp: (_) => _handlePress(false),
        onTapCancel: () => _handlePress(false),
        onTap: widget.onPressed,
        child:
            widget.child ??
            widget.config.getRich(TextSpan(text: widget.text, style: style)),
      ),
    );
  }

  void _handleHover(bool hover) {
    setState(() {
      _isHovering = hover;
    });
  }

  void _handlePress(bool pressed) {
    setState(() {});
  }
}
