import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bloc_and_api_unsplash/bloc/photo_event.dart';
import 'package:bloc_and_api_unsplash/bloc/photo_state.dart';
import 'package:bloc_and_api_unsplash/models/photo_list.dart';
import 'package:bloc_and_api_unsplash/services/photo_repository.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository photoRepository;
  int page = 1;
  bool isFetching = false;

  PhotoBloc({@required this.photoRepository}) : super(PhotoInitState());

  @override
  Stream<PhotoState> mapEventToState(PhotoEvent event) async* {
    if (event is PhotoFetchEvent) {
      yield PhotoLoadingState(message: 'Loading Photos...');
      var response = await photoRepository.getPhoto(page: page);
      if (response is http.Response) {
        if (response.statusCode == 200) {
          var photo = PhotoList.fromJson(json.decode(response.body));
          yield PhotoSuccessState(photos: photo.photos);
          page++;
        } else {
          yield PhotoErrorState(error: response.body);
        }
      } else if (response is String) {
        yield PhotoErrorState(error: response);
      }
    }
  }
}
