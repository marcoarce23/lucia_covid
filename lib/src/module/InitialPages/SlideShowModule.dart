import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SliderShowModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => new SliderMark(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Slides(),
              ),
              Puntos(),
            ],
          ),
        ),
      ),
    );
  }
}

class Puntos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: double.infinity,
        height: 70,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MarcaPunto(0),
            MarcaPunto(1),
            MarcaPunto(2),
          ],
        ),
      ),
    );
  }
}

class MarcaPunto extends StatelessWidget {
  final int posicion;

  MarcaPunto(this.posicion);

  @override
  Widget build(BuildContext context) {
    final pageIndex = Provider.of<SliderMark>(context).markPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200) ,
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 12,
      height: 12,
      decoration: BoxDecoration(
          color: (pageIndex >= posicion-0.5 && posicion  >= pageIndex-0.5) ? Colors.lightBlue : Colors.black,
          shape: BoxShape.circle),
    );
  }
}

class Slides extends StatefulWidget {
  @override
  _SlidesState createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {
  final pageViewController = new PageController();

  @override
  void initState() {
  
    super.initState();
    pageViewController.addListener(() {
      print('Pagina actual es:  ${pageViewController.page}');
      //Actualizamos el provider
      Provider.of<SliderMark>(context, listen: false).markPage =
          pageViewController.page;
    });
  }

  @override
  void dispose() {
   
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: <Widget>[
          imagenSlide(context, 'assets/image/svg_covid1.png'),
          imagenSlide(context, 'assets/image/svg_covid2.png'),
          imagenSlide(context, 'assets/image/svg_covid3.png')
        ],
      ),
    );
  }
}

Widget imagenSlide(BuildContext context, String direction) {
  return Container(
      padding: EdgeInsets.all(20),
      child: Image(
        image: AssetImage(direction),
        //width: MediaQuery.of(context).size.width / 2,
        //fit: BoxFit.contain,
      ));


}


class SliderMark with ChangeNotifier {
  double _markPage = 0;

  double get markPage => this._markPage;

  set markPage(double pMark) {
    this._markPage = pMark;
    notifyListeners();
  }
}