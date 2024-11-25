import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/app/bloc/app_bloc.dart';
import 'package:testing/app/home/home.dart';
import 'package:testing/assets/palete.dart';

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
                      Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Editar teléfono",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Avatar(photo: user.photo),
          ListTile(title: Text(user.email ?? '', style:const TextTheme().titleLarge)),
        ],
      ),
    );
  }
}

class EditPhoneDrawer extends StatelessWidget {
  const EditPhoneDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // You can replace this TextField with your existing phone input form
    TextEditingController phoneController = TextEditingController();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBar(
            title: const Text("Editar teléfono"),
            automaticallyImplyLeading: false, // Remove back button
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  // Close the drawer when the close button is pressed
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: phoneController,
              decoration:const InputDecoration(labelText: "Editar"),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
