import 'package:bloc_and_api_unsplash/bloc/photo_bloc.dart';
import 'package:bloc_and_api_unsplash/bloc/photo_event.dart';
import 'package:bloc_and_api_unsplash/bloc/photo_state.dart';
import 'package:bloc_and_api_unsplash/models/photo_list.dart';
import 'package:bloc_and_api_unsplash/widgets/photo_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoBody extends StatelessWidget {
  final List<Photo> _photos = [];
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<PhotoBloc, PhotoState>(
        builder: (context, photoState) {
          if (photoState is PhotoInitState ||
              photoState is PhotoLoadingState && _photos.isEmpty) {
            return CircularProgressIndicator();
          } else if (photoState is PhotoSuccessState) {
            _photos.addAll(photoState.photos);
            BlocProvider.of<PhotoBloc>(context).isFetching = false;
            Scaffold.of(context).hideCurrentSnackBar();
          } else if (photoState is PhotoErrorState && _photos.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      BlocProvider.of<PhotoBloc>(context)
                        ..isFetching = true
                        ..add(PhotoFetchEvent());
                    }),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  photoState.error,
                  textAlign: TextAlign.center,
                )
              ],
            );
          }
          return ListView.separated(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !BlocProvider.of<PhotoBloc>(context).isFetching) {
                  BlocProvider.of<PhotoBloc>(context)
                    ..isFetching = true
                    ..add(PhotoFetchEvent());
                }
              }),
            itemBuilder: (context, int index) => PhotoListItem(_photos[index]),
            separatorBuilder: (context, index) => const SizedBox(
              height: 8.0,
            ),
            itemCount: _photos.length,
          );
        },
        listener: (context, photoState) {
          if (photoState is PhotoLoadingState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(photoState.message)));
          } else if (photoState is PhotoSuccessState &&
              photoState.photos.isEmpty) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('No more photos')));
          } else if (photoState is PhotoErrorState) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(photoState.error)));
            BlocProvider.of<PhotoBloc>(context).isFetching = false;
          }
          return;
        },
      ),
    );
  }
}
