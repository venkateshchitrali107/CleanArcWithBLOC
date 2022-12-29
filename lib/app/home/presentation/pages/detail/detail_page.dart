import '../../../data/model/rick_and_morty_model.dart';
import "package:flutter/material.dart";

class UserDetail extends StatelessWidget {
  final RickAndMortyModel user;

  // ignore: use_key_in_widget_constructors
  const UserDetail({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            Hero(
              tag: "avatar_${user.id}",
              child: CircleAvatar(
                radius: 105,
                backgroundColor: Theme.of(context).primaryColor,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                    user.image ?? "",
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "${user.id} . ${user.name}",
              style: Theme.of(context).textTheme.headline1,
            ),
            if ((user.status).isNotEmpty)
              getDataWidget(user.status, "Status", context),
            if ((user.species).isNotEmpty)
              getDataWidget(user.species, "Species", context),
            if ((user.gender ?? '').isNotEmpty)
              getDataWidget(user.gender!, "Gender", context),
            if ((user.type ?? '').isNotEmpty)
              getDataWidget(user.type!, "Type", context),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget getDataWidget(
    String data,
    String type,
    BuildContext context,
  ) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Text(
          "$type : $data",
          style: Theme.of(context).textTheme.headline2,
        ),
      ],
    );
  }
}
