import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(VousSortirAvecMoiApp());
}

class VousSortirAvecMoiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yo toi',
      debugShowCheckedModeBanner: false,
      home: RencontrePage(),
    );
  }
}

class RencontrePage extends StatefulWidget {
  @override
  _RencontrePageState createState() => _RencontrePageState();
}

class _RencontrePageState extends State<RencontrePage> {
  // Position initiale du bouton "Non"
  double _nonButtonTop = 0;
  double _nonButtonLeft = 0;

  // Dimensions de l'écran
  double _screenWidth = 0;
  double _screenHeight = 0;

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Initialiser les positions au centre
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _screenWidth = MediaQuery.of(context).size.width;
        _screenHeight = MediaQuery.of(context).size.height;

        _nonButtonTop = (_screenHeight - 50) / 2 + 60; // Décalé vers le bas
        _nonButtonLeft = (_screenWidth - 100) / 2;
      });
    });
  }

  void _moveNonButton() {
    // Calculer de nouvelles positions aléatoires en fonction des dimensions de l'écran
    setState(() {
      _nonButtonLeft = _random.nextDouble() * (_screenWidth - 100); // 100 est la largeur approximative du bouton
      _nonButtonTop = _random.nextDouble() * (_screenHeight - 100); // 100 est la hauteur approximative du bouton
    });
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer les dimensions de l'écran
    if (_screenWidth == 0 || _screenHeight == 0) {
      _screenWidth = MediaQuery.of(context).size.width;
      _screenHeight = MediaQuery.of(context).size.height;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Yo toi'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          // Texte en haut
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Text(
              'Veux tu sortir avec moi ?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Bouton "Oui" au centre, légèrement vers le haut
          Positioned(
            top: (_screenHeight - 50) / 2 - 60, // Décalé vers le haut
            left: (_screenWidth - 100) / 2,
            child: ElevatedButton(
              onPressed: () {
                // Action lorsque "Oui" est pressé
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Merci !"),
                    content: Text("Je suis ravi que tu acceptes !"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Oui'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 50),
              ),
            ),
          ),
          // Bouton "Non" initialement centré, mais légèrement vers le bas
          Positioned(
            top: _nonButtonTop,
            left: _nonButtonLeft,
            child: ElevatedButton(
              onPressed: () {
                // Déplacer le bouton à une position aléatoire
                _moveNonButton();
              },
              child: Text('Non'),
              style: ElevatedButton.styleFrom(
                iconColor: Colors.red,
                minimumSize: Size(100, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
