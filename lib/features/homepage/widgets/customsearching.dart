import 'package:flutter/material.dart';

class CustomSearchingWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String hintText;
  final Color hintcolor;

  final IconData? perfixicon;
  final void Function()? onTap;

  const CustomSearchingWidget({
    Key? key,
    required EdgeInsets contentPadding,
    this.validator,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.hintText = '',
    this.hintcolor = Colors.grey,
    this.perfixicon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        onTap: onTap,
        style: const TextStyle(
          backgroundColor: Color(0xffFFFFFF),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hintcolor),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusColor: Colors.white,
          prefixIcon: perfixicon != null
              ? Icon(
                  perfixicon,
                  color: Colors.amber,
                )
              : null,
        ),
        validator: validator!,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
      ),
    );
  }
}
