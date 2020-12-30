import 'package:bloc_and_api_unsplash/models/photo_list.dart';
import 'package:flutter/material.dart';

abstract class PhotoState {
  const PhotoState();
}

class PhotoInitState extends PhotoState {
  const PhotoInitState();
}

class PhotoLoadingState extends PhotoState {
  final String message;
  const PhotoLoadingState({
    @required this.message,
  });
}

class PhotoSuccessState extends PhotoState {
  List<Photo> photos;
  PhotoSuccessState({@required this.photos});
}

class PhotoErrorState extends PhotoState {
  final String error;
  const PhotoErrorState({@required this.error});
}
