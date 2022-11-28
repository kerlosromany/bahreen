part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}
class FavouriteSuccess extends FavouriteState {}
class FavouriteEmpty extends FavouriteState {}
class FavouriteFail extends FavouriteState {}
