import 'package:flutter/material.dart';

class FloatingInput extends StatefulWidget {
  final String label;
  final IconData? icon;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? rightElement;
  final String? errorText;

  const FloatingInput({
    super.key,
    required this.label,
    required this.controller,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.rightElement,
    this.errorText,
  });

  @override
  State<FloatingInput> createState() => _FloatingInputState();
}

class _FloatingInputState extends State<FloatingInput> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = widget.controller.text.isNotEmpty;
    final isActive = _isFocused || hasText;
    final hasError = widget.errorText != null;
    final isValid = !hasError && hasText;

    Color iconColor;
    if (hasError) {
      iconColor = const Color(0xFFE74C3C); // Vermelho
    } else if (isValid) {
      iconColor = const Color(0xFF27AE60); // Verde
    } else if (_isFocused) {
      iconColor = const Color(0xFFFF6B00); // Laranja
    } else {
      iconColor = const Color(0xFF9E9E9E); // Cinza
    }

    Color borderColor;
    if (hasError) {
      borderColor = const Color(0xFFE74C3C);
    } else if (isValid) {
      borderColor = const Color(0xFF27AE60);
    } else if (_isFocused) {
      borderColor = const Color(0xFFFF6B00);
    } else {
      borderColor = const Color(0xFFEEEEEE);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: iconColor, size: 20),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 200),
                      top: isActive ? 4 : 16,
                      child: Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: isActive ? 11 : 15,
                          fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                          color: hasError
                              ? const Color(0xFFE74C3C)
                              : isValid
                                  ? const Color(0xFF27AE60)
                                  : isActive
                                      ? const Color(0xFFFF6B00)
                                      : const Color(0xFF6B6B6B),
                        ),
                      ),
                    ),
                    TextField(
                      controller: widget.controller,
                      focusNode: _focusNode,
                      keyboardType: widget.keyboardType,
                      obscureText: widget.obscureText,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14),
                      ),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.rightElement != null) widget.rightElement!,
              if (widget.rightElement == null && hasError)
                const Icon(Icons.close, color: Color(0xFFE74C3C), size: 18),
              if (widget.rightElement == null && isValid)
                const Icon(Icons.check, color: Color(0xFF27AE60), size: 18),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4),
            child: Text(
              widget.errorText!,
              style: const TextStyle(
                color: Color(0xFFE74C3C),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
