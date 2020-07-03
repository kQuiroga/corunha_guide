import 'package:corunha_guide/components/popular_spots/popular_spots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:corunha_guide/authentication_bloc/bloc.dart';
import 'package:corunha_guide/components/categories/categories.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      alignment: Alignment.topCenter,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 1.75),
      child: Text(
        title,
        style: TextStyle(fontSize: 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Inicio'),
        actions: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Idioma',
              textAlign: TextAlign.end,
            ),
          ),
          FlatButton(
            textColor: Colors.red,
            child: Text(
              'Cerrar sesión',
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
          _createSectionTitle(context, 'Categorías'),
          Categories(),
          _createSectionTitle(context, 'Sitios Populares'),
          PopularSpots(),
        ],
      ),
    );
  }
}
