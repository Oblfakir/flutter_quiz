import 'package:flutter/material.dart';
import './landing_page.dart';

class ScorePage extends StatelessWidget {
  
  final int _total;
  final int _score;
  
  ScorePage(this._total, this._score);
  
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Your score is:', style: new TextStyle(color: Colors.white, fontSize: 40.0, fontWeight: FontWeight.bold),),
            new Text('$_score / $_total', style: new TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
            new IconButton(
              icon: new Icon(Icons.arrow_back, size: 50.0, color: Colors.blueGrey,),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                new MaterialPageRoute(builder: (BuildContext context) => new LandingPage()), 
                (Route route) => route == null
              ),
            )
          ],
        )
    );
  }
}
