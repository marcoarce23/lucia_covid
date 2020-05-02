import 'package:flutter/material.dart';
import 'package:lucia_covid/src/Model/Entity.dart';
import 'package:lucia_covid/src/Model/Generic.dart';
import 'package:lucia_covid/src/Model/PreferenceUser.dart';
import 'package:lucia_covid/src/Util/Resource.dart' as resource;

class ListCitizenModule extends StatelessWidget {
  final generic = new Generic();
  final prefs = new PreferensUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resource.titleApp),
      ),
      body: _showData(),
    );
  }

  Widget _showData() {
    return FutureBuilder(
      future: generic.getAll(new Hospital()),
      builder: (BuildContext context, AsyncSnapshot<List<Entity>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) => _createItem(context, snapshot.data[i]));
        } else
          return Center(child: CircularProgressIndicator());
      },
      
    );
  }

  Widget _createItem(BuildContext context,Hospital entityList) {

    prefs.correoElectronico = 'marcoarce23@gmail.com';

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (value) 
      {
         //generic.delete(value);
      
          Scaffold.of(context).showSnackBar(
            new SnackBar(content:new Text('Registro eliminado'))
          );
      },

      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('nombre: ${entityList.nombre} - ubicaicon: ${entityList.ubicacion}'),
              subtitle: Text('${entityList.id} - correo: ${prefs.correoElectronico}'),
              onTap: () =>
                //  Navigator.pushNamed(context, 'citizen', arguments: entityList),
                 Navigator.pushNamed(context, 'citizen'),
            ),
          ],
        ),
      ),
    );
  }
}
