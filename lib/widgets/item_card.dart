import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final EdgeInsets margin;
  final String title;
  final String? subtitle;
  final List<Widget>? label;
  final void Function()? onTap;
  final void Function(DismissDirection)? onDismissed;
  final bool dismissible;

  const ItemCard({
    Key? key,
    this.onTap,
    required this.title,
    this.margin = const EdgeInsets.symmetric(horizontal: 24.0),
    this.subtitle = "",
    this.label = const [],
    this.dismissible = false,
    this.onDismissed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dismissible
        ? Dismissible(
            key: this.key!,
            onDismissed: onDismissed,
            child: _itemCard(context),
          )
        : _itemCard(context);
  }

  Widget _itemCard(BuildContext context) {
    return Container(
      margin: this.margin,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: onTap,
          child: Ink(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
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
}
