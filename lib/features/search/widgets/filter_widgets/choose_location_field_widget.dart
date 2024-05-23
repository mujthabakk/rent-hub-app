import 'package:flutter/material.dart';
import 'package:rent_hub/core/theme/app_theme.dart';

TextField chooseLocationTextFieldWidget(
    {required BuildContext context,
    required String hintText,
    required TextEditingController controller}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.place_outlined,
        size: context.spaces.space_250,
      ),
      hintText: hintText,
      hintStyle: context.typography.body,
      contentPadding: EdgeInsets.symmetric(vertical: context.spaces.space_200),
      errorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: context.colors.border),
        borderRadius: BorderRadius.circular(context.spaces.space_200),
      ),
    ),
  );
}
