import 'package:flutter/material.dart';

errorSnackBar(message) {
  return SnackBar(
    backgroundColor: Colors.red,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 250.0,
          child: Text(
            message,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
        ),
        Icon(Icons.error)
      ],
    ),
  );
}
