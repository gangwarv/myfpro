import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:myfpro/bloc/shutter_stock_bloc.dart';
import 'package:myfpro/data/models/images.dart';
import 'package:myfpro/presentation/widgets/stagered_image_viewer.dart';

class StaggeredImageScreen extends StatefulWidget {
  const StaggeredImageScreen({super.key});

  @override
  State<StaggeredImageScreen> createState() => _StaggeredImageScreenState();
}

class _StaggeredImageScreenState extends State<StaggeredImageScreen> {
  List<ShutterStockImagesData> allDatas = [];
  final scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ShutterStockBloc>().add(GetShutterStockImages());
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        context.read<ShutterStockBloc>().add(GetShutterStockImages());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Icon(
          Icons.search_rounded,
          color: Colors.grey[700],
          size: 28,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.account_circle_outlined,
              color: Colors.grey[700],
              size: 28,
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "Explore",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.4,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<ShutterStockBloc, ShutterStockState>(
          listener: (context, state) {
            if (state is ShutterStockLoaded) {
              allDatas = state.images;
              setState(() {});
            }
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: allDatas
                  .asMap()
                  .map(
                    (index, e) => MapEntry(
                      index,
                      StaggeredGridTile.count(
                        crossAxisCellCount: 2,
                        mainAxisCellCount: index == 1 ? 1 : 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: StaggeredImageViewer(
                              imageUrl: e.assets?.preview?.url ?? '',
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                Icons.home,
                color: Colors.grey[800],
              )),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue[300],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              Expanded(
                  child: Icon(
                Icons.settings,
                color: Colors.grey[800],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
