import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Tacquin extends StatefulWidget {
  const Tacquin({super.key});

  @override
  State<Tacquin> createState() => _TacquinState();
}

class _TacquinState extends State<Tacquin> {
  var grille = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
  late bool fin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gameInit();
  }

  void gameInit() {
    fin = false;
    //grille.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title: Text('Tacquin',
            style: TextStyle(
                color: Color.fromARGB(255, 192, 192, 192),
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.grey[900],
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _game(size),
            _restart(),
          ],
        ),
      )),
    );
  }

  Widget _game(size) {
    return Container(
        margin: EdgeInsets.all(10),
        height: size.height * 0.6,
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: grille.length,
            itemBuilder: (context, index) {
              final grilles = grille[index];

              return grille[index] != 0
                  ? _box(index, size, grilles)
                  : Container();
            }));
  }

  victoire() {
    var solution1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0];
    var solution2 = [15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0];

    if (listEquals(grille, solution1) == true ||
        listEquals(grille, solution2) == true) {
      messageFin("Victoire");
      fin = true;
      return;
    }
  }

  mouvement(int index) {
    if (fin == false) {
      if (index - 1 >= 0 && grille[index - 1] == 0 && index % 4 != 0 ||
          index + 1 < 16 && grille[index + 1] == 0 && (index + 1) % 4 != 0 ||
          (index - 4 >= 0 && grille[index - 4] == 0) ||
          (index + 4 < 16 && grille[index + 4] == 0)) {
        grille[grille.indexOf(0)] = grille[index];
        grille[index] = 0;
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

  Widget _box(index, size, grilles) {
    return InkWell(
      onTap: (() {
        if (fin) {
          return; // si partie finie | zone pleine on ne peut pas changer la valeur
        }

        setState(() {
          mouvement(index);
          victoire();
        });
      }),
      child: Container(
          margin: EdgeInsets.all(1),
          height: size.height * 0.6,
          color: Colors.grey[900],
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "$grilles",
              style: TextStyle(
                  color: Color.fromARGB(255, 192, 192, 192),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )),
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
            gameInit();
          });
        }),
        child: Text(
          "nouvelle partie",
          style: TextStyle(
              color: Color.fromARGB(255, 192, 192, 192), fontSize: 24),
        ));
  }
}
