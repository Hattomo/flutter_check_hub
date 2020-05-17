import 'package:flutter/material.dart';
import 'package:flutter_check_hub/models/Item.dart';
import 'package:flutter_check_hub/pages/graph/bar_graph_builder.dart';

@immutable
class GraphBuilder extends StatefulWidget {
  const GraphBuilder({this.item});
  final Item item;
  @override
  _GraphBuilderState createState() => _GraphBuilderState();
}

class _GraphBuilderState extends State<GraphBuilder> {
  @override
  Widget build(BuildContext context) {
    if (widget.item.dataType == 'Number')
      return BarGraphBuilder(widget.item);
    else if (widget.item.dataType == 'Text')
      return const SizedBox();
    else if (widget.item.dataType == 'Time')
      return BarGraphBuilder(widget.item);
    else
      return const SizedBox();
  }
}
