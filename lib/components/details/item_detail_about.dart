import 'package:corunha_guide/app_localizations.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ItemAbout extends StatelessWidget {
  ItemAbout(this.about);
  final String about;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ExpandableNotifier(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              clipBehavior: Clip.antiAlias,
              elevation: 4,
              child: Column(
                children: <Widget>[
                  ScrollOnExpand(
                    scrollOnExpand: true,
                    scrollOnCollapse: false,
                    child: ExpandablePanel(
                      theme: ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                        iconColor: Theme.of(context).accentColor,
                      ),
                      header: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            AppLocalizations.of(context)
                                .getTranslatedValue('about'),
                            style: Theme.of(context).textTheme.headline5,
                          )),
                      collapsed: Text(
                        about,
                        softWrap: true,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      expanded: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          about,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      builder: (_, collapsed, expanded) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                            theme: ExpandableThemeData(crossFadePoint: 0),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
