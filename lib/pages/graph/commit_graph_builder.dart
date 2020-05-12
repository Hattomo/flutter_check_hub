import 'package:flutter/material.dart';

class CommitGraphBuilder extends StatefulWidget {
  @override
  _CommitGraphBuilderState createState() => _CommitGraphBuilderState();
}

class _CommitGraphBuilderState extends State<CommitGraphBuilder> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  '🏷',
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  width: 38,
                ),
                const Text(
                  'StampCard',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  '2019',
                  style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 30,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 10.0,
                      width: 10.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: Colors.blue),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
