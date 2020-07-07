import 'package:flutter/material.dart';

class ItemAbout extends StatelessWidget {
  ItemAbout(this.about);
  final String about;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Acerca de',
          style: textTheme.subtitle1.copyWith(fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
        Text(
          about,
          style: textTheme.bodyText2.copyWith(
            color: Colors.black45,
            fontSize: 16.0,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'más',
              style: textTheme.bodyText2
                  .copyWith(fontSize: 16.0, color: theme.accentColor),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: 18.0,
              color: theme.accentColor,
            ),
          ],
        )
      ],
    );
  }
}
