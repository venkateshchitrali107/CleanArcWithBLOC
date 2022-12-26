import 'package:clean_arc_bloc/app/home/domain/entity/rick_and_morty.dart';
import 'package:flutter/material.dart';

class RickAndMortyListTile extends StatelessWidget {
  final RickAndMorty data;
  const RickAndMortyListTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      child: ListTile(
        leading: Text(
          data.id,
          style: textTheme.caption,
        ),
        title: Text(
          data.name,
        ),
        isThreeLine: true,
        subtitle: Text(
          data.species,
        ),
        dense: true,
      ),
    );
  }
}
