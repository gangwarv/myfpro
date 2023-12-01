import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:myfpro/data/models/images.dart';
import 'package:myfpro/data/services/images.dart';

part 'shutter_stock_event.dart';
part 'shutter_stock_state.dart';

class ShutterStockBloc extends Bloc<ShutterStockEvent, ShutterStockState> {
  ShutterStockBloc() : super(ShutterStockLoading()) {
    int page = 1;
    List<ShutterStockImagesData> images = [];
    on<GetShutterStockImages>((event, emit) async {
      try {
        emit(ShutterStockLoading());
        final responseImage = await ShutterStockService.getImages(page: page);
        page += 1;
        images = [...images, ...(responseImage.data ?? [])];
        emit(ShutterStockLoaded(images));
      } catch (e) {
        emit(ShutterStockError(e.toString()));
      }
    });
  }
}
