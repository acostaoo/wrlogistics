import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:WrLogistics/app/app.dart';
import 'package:WrLogistics/assets/palette.dart';
import 'package:WrLogistics/home/widgets/widgets.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration:const BoxDecoration(
              color: AppColors.lightPrimary,
              image: DecorationImage(
                image: AssetImage('assets/wrlogo.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.nombre??'',
                  style:const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child:const Row(
                    children: [
                    ],
                  ),
                ),
              ],
            ),
          ),
          Avatar(photo: user.photo),Center(child:
          ListTile(title: Text(user.email ?? '', style:const TextTheme().titleLarge))),
            ElevatedButton.icon(
  onPressed: () => Navigator.of(context).push<void>(PhoneInputPage.route()),
  icon: Icon(
    Icons.edit,
    color: Colors.black,
  ),
  label: Text(
    'Editar teléfono',
    style: TextStyle(color: Colors.black),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white, // Set the button background color
  ),
)


          
        ],
      ),
    );
  }
}

