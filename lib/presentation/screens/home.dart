import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfpro/bloc/shutter_stock_bloc.dart';
import 'package:myfpro/data/models/images.dart';
import 'package:myfpro/presentation/widgets/images_viewer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  List<ShutterStockImagesData> allDatas = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ShutterStockBloc>().add(GetShutterStockImages());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width / 1.3;
    final cardHeight = size.height / 1.4;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("ShutterStock Example"),
      ),
      body: BlocListener<ShutterStockBloc, ShutterStockState>(
        listener: (context, state) {
          if (state is ShutterStockLoaded) {
            allDatas = state.images;
            setState(() {});
          }
        },
        child: Center(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: allDatas.reversed
                  .toList()
                  .asMap()
                  .map(
                    (index, e) {
                      final i = (allDatas.length - 1) - index;
                      final bottom = (20 * (i > 3 ? 3 : i)).toDouble() +
                          (size.height / 2 - (cardHeight / 2));

                      final left = size.width / 2 -
                          (cardWidth / 2) +
                          (10 * (i > 3 ? 3 : i)).toDouble();
                      return MapEntry(
                        index,
                        ImageViewer(
                          imageUrl: e.assets?.preview1500?.url ?? '',
                          index: index,
                          cardWidth: cardWidth,
                          cardHeight: cardHeight,
                          onImageDismiss: () {
                            try {
                              allDatas.removeAt(allDatas.length - 1 - index);
                            } catch (e) {}
                            setState(() {});
                            if (allDatas.length < 10) {
                              context
                                  .read<ShutterStockBloc>()
                                  .add(GetShutterStockImages());
                            }
                          },
                          color: Colors.white,
                          bottom: bottom,
                          left: left,
                          description: e.description ?? '',
                        ),
                      );
                    },
                  )
                  .values
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
