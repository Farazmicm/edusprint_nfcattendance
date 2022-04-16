/*

import 'package:flutter/material.dart';
import 'package:async_loader/async_loader.dart';

class ShowLoading extends StatelessWidget {
  final GlobalKey<AsyncLoaderState> _asyncLoaderState = GlobalKey<AsyncLoaderState>();
  final Future<Object> functionName;

  ShowLoading({Key? key, required this.functionName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _asyncLoader = AsyncLoader(
      key: _asyncLoaderState,
      initState: () => functionName,
      renderLoad: () => new CircularProgressIndicator(),
      renderError: ([error]) => Text('Sorry, there was an error loading your data.'),
      renderSuccess: ({data}) => new Text(data),
    );

    return Container(
      child: _asyncLoader,
    );
  }
}
*/
