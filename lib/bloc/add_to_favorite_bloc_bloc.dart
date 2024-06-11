// Define Favorites Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:you_read_app_flutter/bloc/add_to_favorite_bloc_event.dart';
import 'package:you_read_app_flutter/bloc/add_to_favorite_bloc_state.dart';
import 'package:you_read_app_flutter/models/add_to_favorite_model.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState([])) {
    on<FavoritesEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      FavoritesEvent event, Emitter<FavoritesState> emit) async {
    if (event is AddToFavorites) {
      final updateFavorite = List<AddToFavoriteModel>.from(state.favoriteBooks)
        ..add(event.addToFavoriteModel);
      emit(FavoritesState(updateFavorite));
    } else if (event is RemoveFromFavorites) {
      final updateFavorite = List<AddToFavoriteModel>.from(state.favoriteBooks)
        ..remove(event.addToFavoriteModel);
      emit(FavoritesState(updateFavorite));
    }
  }
}
