import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final EdgeInsets margin;
  final String title;
  final String? subtitle;
  final List<Widget>? label;
  final void Function()? onTap;

  const ItemCard({
    Key? key,
    this.onTap,
    required this.title,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0),
    this.subtitle = "",
    this.label = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: this.margin,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: onTap,
            child: Ink(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: label!,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(subtitle!, style: Theme.of(context).textTheme.subtitle2),
                ],
              ),
            ),
          ),
        ),
      );
}
