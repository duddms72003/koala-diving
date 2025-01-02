import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final String? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;

  const CommonButton({
    Key? key,
    required this.text,
    this.icon,
    this.backgroundColor,
    this.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: icon != null
            ? Row(
                children: [
                  const SizedBox(width: 20),
                  Text(
                    icon!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              )
            : Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
      ),
    );
  }
}
