import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  List _data = await getJSON();

  runApp(
    MaterialApp(
        title: "JSON Parsing",
        home: Scaffold(
            appBar: AppBar(
              title: Text("JSON Parsing"),
              backgroundColor: Colors.orange,
            ),
            body: Padding(
              padding: const EdgeInsets.all(3.0),
              child: ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        Divider(height: 3.4),
                        ListTile(
                          title: Text(
                            _data[index]["title"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.2,
                            ),
                          ),
                          subtitle: Text(_data[index]["body"]),
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange,
                            child: Text(_data[index]["title"][0]),
                          ),
                          onTap: () =>
                              showTapMessage(context, _data[index]["title"]),
                        ),
                      ],
                    );
                  }),
            ))),
  );
}

void showTapMessage(BuildContext context, String message) {
  var alertDialog = AlertDialog(
    title: Text(message),
    actions: <Widget>[
      FlatButton(
        child: Text("OK"),
        onPressed: () => Navigator.of(context).pop(),
      ),
    ],
  );

  showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      });
}

Future<List> getJSON() async {
  String apiURL = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(apiURL);
  return json.decode(response.body);
}
