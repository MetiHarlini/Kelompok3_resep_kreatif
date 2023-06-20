import 'package:flutter/material.dart';

class InputResep extends StatelessWidget {
  const InputResep({
    super.key,
    required TextEditingController controller,
    required this.hint,
    this.isLarge,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String hint;
  final bool? isLarge;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: _controller,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        maxLines: isLarge == null ? null : 10,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          hintText: hint,
          labelStyle: const TextStyle(color: Colors.black),
          label: Text(hint),
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Isi terlebih dahulu";
          }
          return null;
        },
      ),
    );
  }
}
