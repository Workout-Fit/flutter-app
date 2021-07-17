import 'package:flutter/material.dart';

enum IconPosition { prefix, suffix }

class BlockButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final IconPosition iconPosition;
  final void Function()? onTap;

  const BlockButton({
    Key? key,
    required this.label,
    required this.onTap,
    this.icon,
    this.iconPosition = IconPosition.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: onTap,
          child: Ink(
            height: 68.0,
            width: double.infinity,
            child: Row(
              textDirection: iconPosition == IconPosition.prefix
                  ? TextDirection.ltr
                  : TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text(label, style: Theme.of(context).textTheme.button),
                ),
              ],
            ),
          ),
        ),
      );
}
