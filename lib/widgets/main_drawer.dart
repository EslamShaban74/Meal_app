import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/language_provider.dart';
import 'package:flutter_complete_guide/screens/theme_screen.dart';
import 'package:provider/provider.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      String title, IconData icon, Function tapHandler, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(ctx).textTheme.bodyText1.color,
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Drawer(
        elevation: 0,
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment:
                  lan.isEn ? Alignment.centerLeft : Alignment.centerRight ,
              color: Theme.of(context).accentColor,
              child: Text(
                'Cooking Up!',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile('Meals', Icons.restaurant, () {
              Navigator.of(context).pushReplacementNamed('/');
            }, context),
            buildListTile('Filters', Icons.settings, () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName);
            }, context),
            buildListTile('Themes', Icons.color_lens, () {
              Navigator.of(context).pushReplacementNamed(ThemeScreen.routeName);
            }, context),
            Divider(
              height: 10,
              color: Colors.black54,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 20, right: 22),
              child: Text(
                lan.getTexts('drawer_switch_title'),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Switch(
              value: Provider.of<LanguageProvider>(context, listen: true).isEn,
              onChanged: (newValue) {
                Provider.of<LanguageProvider>(context, listen: false)
                    .changeLan(newValue);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
