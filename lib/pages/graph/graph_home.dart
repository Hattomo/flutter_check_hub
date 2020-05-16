import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/models/user.dart';
import 'package:flutter_check_hub/pages/graph/bar_graph_builder.dart';
import 'package:provider/provider.dart';

class GraphHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User userdata = Provider.of(context);
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: userdata.itemsid.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: BarGraphBuilder(Item(
                title: userdata.itemstitle[index],
                icon: userdata.itemsicon[index],
                id: userdata.itemsid[index])),
          );
        });
  }
}
