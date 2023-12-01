part of 'shutter_stock_bloc.dart';

@immutable
abstract class ShutterStockState {}

class ShutterStockLoading extends ShutterStockState {}

class ShutterStockError extends ShutterStockState {
  final String error;

  ShutterStockError(this.error);
}

class ShutterStockLoaded extends ShutterStockState {
  final List<ShutterStockImagesData> images;

  ShutterStockLoaded(this.images);
}
