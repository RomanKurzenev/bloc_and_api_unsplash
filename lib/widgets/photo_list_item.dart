import 'package:bloc_and_api_unsplash/models/photo_list.dart';
import 'package:flutter/material.dart';
import 'package:bloc_and_api_unsplash/utils/string_extension.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;
  const PhotoListItem(this.photo);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 8.0,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(17.0),
                    topRight: Radius.circular(17.0)),
                child: Image.network(
                  photo.urls.regular,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${photo.altDescription ?? 'photo'}'.capitalize(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    child: photo.user.profileImage.small == null
                        ? Icon(Icons.accessibility)
                        : Image.network(
                            photo.user.profileImage.small,
                          ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('@' + photo.user.username ?? 'No username',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: 30,
                      )),
                  Expanded(
                    child: Icon(
                      Icons.favorite,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(photo.likes == null
                        ? 0.toString()
                        : photo.likes.toString()),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
