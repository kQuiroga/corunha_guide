import 'package:corunha_guide/app_localizations.dart';
import 'package:corunha_guide/components/popular_spots/popular_spots.dart';
import 'package:corunha_guide/main.dart';
import 'package:corunha_guide/models/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corunha_guide/authentication_bloc/bloc.dart';
import 'package:corunha_guide/components/categories/categories.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width / 30,
          MediaQuery.of(context).size.height / 35,
          0,
          MediaQuery.of(context).size.height / 70),
      child: Text(
        AppLocalizations.of(context).getTranslatedValue(title),
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  void _changeLanguage(LanguageModel language) {
    Locale _temp;
    switch (language.languageCode) {
      case 'en':
        _temp = Locale(language.languageCode, 'US');
        break;
      case 'es':
        _temp = Locale(language.languageCode, 'ES');
        break;
      default:
        _temp = Locale(language.languageCode, 'ES');
    }

    App.setLocale(context, _temp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).getTranslatedValue('home_page'),
        ),
        actions: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: DropdownButton(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              items: LanguageModel.languageList()
                  .map<DropdownMenuItem<LanguageModel>>(
                      (lang) => DropdownMenuItem(
                            value: lang,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                lang.flag,
                                Text(lang.name),
                              ],
                            ),
                          ))
                  .toList(),
              onChanged: (LanguageModel language) {
                _changeLanguage(language);
              },
            ),
          ),
          FlatButton(
            textColor: Colors.red,
            child: Text(
              AppLocalizations.of(context).getTranslatedValue('log_out'),
            ),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).dispatch(
                LoggedOut(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _createSectionTitle(context, 'categories'),
          Categories(),
          _createSectionTitle(context, 'popular_spots'),
          PopularSpots(),
        ],
      ),
    );
  }
}
