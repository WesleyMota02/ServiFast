import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          onChanged: (_) => setState(() {}),
          style: const TextStyle(fontSize: 15, color: Color(0xFF1A1A1A)),
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
              color: hasError
                  ? const Color(0xFFE74C3C)
                  : isValid
                      ? const Color(0xFF27AE60)
                      : _isFocused
                          ? const Color(0xFFFF6B00)
                          : const Color(0xFF6B6B6B),
              fontWeight: _isFocused || hasText ? FontWeight.w500 : FontWeight.w400,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            prefixIcon: widget.icon != null
                ? Icon(widget.icon, color: iconColor, size: 20)
                : null,
            suffixIcon: widget.rightElement ??
                (hasError
                    ? const Icon(Icons.close, color: Color(0xFFE74C3C), size: 18)
                    : isValid
                        ? const Icon(Icons.check, color: Color(0xFF27AE60), size: 18)
                        : null),
            filled: true,
            fillColor: AppTheme.surfaceColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppTheme.primaryColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppTheme.errorColor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppTheme.errorColor, width: 2),
            ),
            // Não usamos o errorText nativo do InputDecoration para evitar quebrar o layout,
            // vamos exibir abaixo se quisermos, mas o Flutter já tem um bom errorText.
            // Para manter igual ao seu design, ocultamos o errorText do InputDecoration
            // e mostramos no texto customizado abaixo.
            errorStyle: const TextStyle(height: 0, fontSize: 0),
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
