import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:workers_inn/Screens/place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch({this.sessionToken}) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider? apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        //close(context, Suggestion("", ""));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient!.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, AsyncSnapshot<List<Suggestion>> snapshot) =>
          query == ''
              ? Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text('Enter your address'),
                )
              : snapshot.hasData
                  ? ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(snapshot.data![index].description),
                        onTap: () {
                          log("hello: ${snapshot.data![index]}");
                          close(context, snapshot.data![index]);
                          log("after");
                        },
                      ),
                      itemCount: snapshot.data!.length,
                    )
                  : Container(child: const Text('Loading...')),
    );
  }
}
