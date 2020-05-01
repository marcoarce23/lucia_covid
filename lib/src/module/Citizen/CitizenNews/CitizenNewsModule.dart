import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Util/Util.dart';

import 'CitizenNewsDetailModule.dart';

String selectedCategorie = "Recomendaciones";

class CitizenNewsModule extends StatefulWidget {
  @override
  _CitizenNewsModuleState createState() => _CitizenNewsModuleState();
}

class _CitizenNewsModuleState extends State<CitizenNewsModule> {
  List<String> categories = [
    "Recomendaciones",
    "Medicina tradicional",
    "Medicina",
    "Noticas"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
                      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Card(
              elevation: 4,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search),
                    hintText: "Buscar",
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              child:
                  Padding(padding: EdgeInsets.all(15), child: Text("Categorias")),
            ),
            Container(
              height: 30,
              child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategorieTile(
                      categorie: categories[index],
                      isSelected: selectedCategorie == categories[index],
                      context: this,
                    );
                  }),
            ),
            SizedBox(
              height: 7,
            ),
            news("descripcion", "01/01/2020", "Adress map",
                "image/circled_user_female.png"),
            news("descripcion", "01/01/2020", "Adress map",
                "image/circled_user_female.png"),
            news("descripcion", "01/01/2020", "Adress map",
                "image/circled_user_female.png"),

            //news("descripcion", "01/01/2020", "Adress map", "circled_user_female.png"),
            //news("descripcion", "01/01/2020", "Adress map", "circled_user_female.png"),
        ],
      ),
          ),
    );
  }

  Widget news(String desc, String date, String address, String imgeAssetPath) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CitizenNewsDetailModule()),
        );
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 16, left: 8, right: 8),
        decoration: BoxDecoration(
            color: Colors.cyan, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: <Widget>[
            ImageOpaqueNetworkCustomize(
                'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                Colors.orange,
                Size(MediaQuery.of(context).size.width, 100),
                0.5,
                BoxFit.cover),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    width: MediaQuery.of(context).size.width - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          desc,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              size: 12,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              date,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.place,
                              size: 12,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              address,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategorieTile extends StatefulWidget {
  final String categorie;
  final bool isSelected;
  _CitizenNewsModuleState context;

  CategorieTile({this.categorie, this.isSelected, this.context});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.context.setState(() {
          selectedCategorie = widget.categorie;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xffFFD0AA) : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          widget.categorie,
          style: TextStyle(
              color: widget.isSelected ? Color(0xffFC9535) : Color(0xffA1A1A1)),
        ),
      ),
    );
  }
}
