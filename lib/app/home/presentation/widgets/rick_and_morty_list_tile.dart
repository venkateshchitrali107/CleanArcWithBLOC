import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_arc_bloc/app/home/data/model/rick_and_morty_model.dart';
import 'package:flutter/material.dart';

class RickAndMortyListTile extends StatelessWidget {
  final RickAndMortyModel data;
  const RickAndMortyListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 10,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: 60.0,
                        height: 60.0,
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
                          placeholder: _loader,
                          errorWidget: _error,
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
                ],
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      data.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      if ((data.gender ?? '').isNotEmpty)
                        FittedBox(
                          child: Text(
                            '${data.gender!}, ',
                          ),
                        ),
                      FittedBox(
                        child: Text(
                          data.species,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if ((data.location?.type?.trim() ?? "").isNotEmpty)
                        Text(
                          '${data.location!.type!}, ',
                        ),
                      Flexible(
                        child: SizedBox(
                          child: Text(
                            data.location?.name ?? "",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loader(BuildContext context, String url) {
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(),
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
