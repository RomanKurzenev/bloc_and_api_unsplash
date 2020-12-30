import 'package:bloc_and_api_unsplash/bloc/photo_bloc.dart';
import 'package:bloc_and_api_unsplash/bloc/photo_event.dart';
import 'package:bloc_and_api_unsplash/services/photo_repository.dart';
import 'package:bloc_and_api_unsplash/widgets/photo_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayPhotoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoBloc(photoRepository: PhotoRepository())
        ..add(
          PhotoFetchEvent(),
        ),
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Unsplash'),
        ),
        body: PhotoBody(),
      ),
    );
  }
}
