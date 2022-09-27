import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  static const String joueur_X = "X";
  static const String joueur_Y = "O";

  late String joueurActuel;
  late bool fin;
  late List<String> plateau;

  @override
  void initState() {
    gameInitialise();
    super.initState();
  }

  void gameInitialise() {
    joueurActuel = joueur_X; //premier joueur
    fin = false;
    plateau = ["", "", "", "", "", "", "", "", ""]; //emplacement libre
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          title: Text('TicTacToe',
              style: TextStyle(
                  color: Color.fromARGB(255, 192, 192, 192),
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _header(),
              _game(),
              _restart(),
            ],
          ),
        ));
  }

  Widget _header() {
    return Column(
      children: [
        Text(
          "Joueur : $joueurActuel",
          style: TextStyle(
              color: Color.fromARGB(255, 192, 192, 192),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _game() {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.height / 2,
      margin: EdgeInsets.all(8),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3), //creation de la grille en 3x3
          itemCount: 9, //nombre de box
          itemBuilder: ((context, int index) {
            return _box(index); //creation des box
          })),
    );
  }

  Widget _restart() {
    //recommencer une partie
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[900], // background
          onPrimary: Colors.grey[850], // foreground
        ),
        onPressed: (() {
          setState(() {
            gameInitialise();
          });
        }),
        child: Text(
          "nouvelle partie",
          style: TextStyle(
              color: Color.fromARGB(255, 192, 192, 192), fontSize: 24),
        ));
  }

  Widget _box(int index) {
    return InkWell(
      onTap: (() {
        if (fin || plateau[index].isNotEmpty) {
          return; // si partie finie | zone pleine on ne peut pas changer la valeur
        }

        setState(() {
          plateau[index] = joueurActuel;

          tour();
          victoire();
          matchNul();
        });
      }),
      child: Container(
        color: Colors.grey[900],
        margin: const EdgeInsets.all(5),
        child: Center(
          child: Text(
            plateau[index],
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 192, 192, 192)),
          ),
        ),
      ),
    );
  }

  tour() {
    if (joueurActuel == "X") {
      joueurActuel = joueur_Y;
    } else {
      joueurActuel = joueur_X;
    }
  }

  victoire() {
    List<List<int>> solution = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var solutionP in solution) {
      String position0 = plateau[solutionP[0]];
      String position1 = plateau[solutionP[1]];
      String position2 = plateau[solutionP[2]];

      if (position0.isNotEmpty) {
        if (position0 == position1 && position0 == position2) {
          //verification des valeurs dans chaque possion
          //si elle sont egale le joueur x ou o gagne
          messageFin("Le joueur $position0 a gagner !");
          fin = true;
          return;
        }
      }
    }
  }

  messageFin(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Fin de la partie \n $message",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24, color: Color.fromARGB(255, 192, 192, 192)),
        ),
        backgroundColor: Colors.grey[900],
      ),
    );
  }

  matchNul() {
    if (fin) {
      return;
    }
    bool nul = true;
    for (var plateauPos in plateau) {
      if (plateauPos.isEmpty) {
        nul = false;
      }
    }
    if (nul) {
      fin = true;
      messageFin('Match Null | recommencer');
    }
  }
}
