import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stm2/models/catfactsmodel.dart';

final httpClientProvider = Provider<Dio>(
  (ref) {
    return Dio(BaseOptions(baseUrl: "https://catfact.ninja/"));
  },
);

final catFactsProvider = FutureProvider.autoDispose
    .family<List<CatFactsModel>, Map<String, dynamic>>(
  (ref, parametersmap) async {
    ref.keepAlive();
    final _dio = ref.watch(httpClientProvider);
    final result = await _dio.get("facts", queryParameters: parametersmap);
    List<Map<String, dynamic>> _MapData = List.from(result.data["data"]);
    List<CatFactsModel> _catFactList =
        _MapData.map((e) => CatFactsModel.fromMap(e)).toList();
    return _catFactList;
  },
);

class FutureProviderExample extends ConsumerWidget {
  const FutureProviderExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var list =
        ref.watch(catFactsProvider(const {"limit": 4, "max_length": 50}));
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: list.when(data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].fact),
                );
              },
            );
          }, error: (error, stack) {
            return Center(
              child: Text(error.toString()),
            );
          }, loading: () {
            return Center(
              child: CircularProgressIndicator(),
            );
          })),
    );
  }
}
