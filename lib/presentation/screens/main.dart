import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfpro/bloc/shutter_stock_bloc.dart';
import 'package:myfpro/presentation/screens/home.dart';
import 'package:myfpro/presentation/screens/staggered.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Viewer Example"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Image Slider'),
            subtitle:
                const Text('Bunch of Image placed on stack with animation'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => BlocProvider(
                        create: (context) => ShutterStockBloc(),
                        child: const HomeScreen(),
                      )),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Image Staggered'),
            subtitle:
                const Text('Bunch of Image placed in staggered grid view'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => BlocProvider(
                        create: (context) => ShutterStockBloc(),
                        child: const StaggeredImageScreen(),
                      )),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
