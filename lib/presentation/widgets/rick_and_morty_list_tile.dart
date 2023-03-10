import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/model/rick_and_morty_model.dart';
import '../pages/detail/detail_page.dart';
import 'bottom_tile_loader.dart';

class RickAndMortyListTile extends StatelessWidget {
  final RickAndMortyModel data;
  const RickAndMortyListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(
              milliseconds: 500,
            ),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return UserDetail(
                user: data,
              );
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return Align(
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
        );
      }),
      child: Card(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 60.0,
                    height: 60.0,
                    child: Hero(
                      tag: "avatar_${data.id}",
                      child: CachedNetworkImage(
                        imageUrl: data.image ?? '',
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        placeholder: (_, __) {
                          return const BottomLoader();
                        },
                        errorWidget: _error,
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: data.status.toLowerCase() == "alive"
                              ? Colors.green
                              : Colors.red,
                        ),
                      ))
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        data.name,
                        style: Theme.of(context).textTheme.headline1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Row(
                      children: [
                        if ((data.gender ?? '').isNotEmpty)
                          FittedBox(
                            child: Text(
                              '${data.gender!}, ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        Flexible(
                          child: SizedBox(
                            child: Text(
                              data.species,
                              style: Theme.of(context).textTheme.bodyText1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _error(BuildContext context, String url, dynamic error) {
    return const Center(
      child: Icon(
        Icons.error,
      ),
    );
  }
}
