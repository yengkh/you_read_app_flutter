// Define Bloc Events
import 'package:equatable/equatable.dart';
import 'package:you_read_app_flutter/models/add_to_favorite_model.dart';

abstract class FavoritesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToFavorites extends FavoritesEvent {
  final AddToFavoriteModel addToFavoriteModel;
  AddToFavorites(this.addToFavoriteModel);

  @override
  List<Object> get props => [addToFavoriteModel];
}

class RemoveFromFavorites extends FavoritesEvent {
  final AddToFavoriteModel addToFavoriteModel;
  RemoveFromFavorites(this.addToFavoriteModel);

  @override
  List<Object> get props => [addToFavoriteModel];
}
