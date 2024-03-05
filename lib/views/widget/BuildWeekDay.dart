import 'package:flutter/material.dart';

Widget BuildWeekDay(String day) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.black,
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Center(
        child: Text(
          day,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}
