import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HELLO ..,',
      theme: ThemeData(
        primaryColor: Colors.yellow,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordState();
  }
}

class RandomWordState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amjad First Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.list,
            ),
            onPressed: _favorites,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return Divider();
        }
        if (i >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }

        final index = i ~/ 2;

        return _buildRow(_suggestions[index]);
      }, //Anonymous Class
    );
  } //Widget

  Widget _buildRow(WordPair suggestion) {
    final alreadySaved = _saved.contains(suggestion);
    return ListTile(
      title: Text(
        suggestion.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved
            ? Icons.star
            : Icons.star_border,

        color: alreadySaved
            ? Colors.yellow
            : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(suggestion);
          } else {
            _saved.add(suggestion);
          }
        }); //setState
      },
    );
  }

  void _favorites() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((suggestion) {
        return ListTile(
          title: Text(
            suggestion.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

      final divided =
      ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text('The Selected Item'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }
}