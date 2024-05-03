import 'package:auto_route/auto_route.dart';
import 'package:bayad_test/router/routes.gr.dart';
import 'package:bayad_test/services/providers.dart';
import 'package:bayad_test/widgets/cache_network_image.dart';
import 'package:bayad_test/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage()
class MovieListScreen extends ConsumerStatefulWidget {
  const MovieListScreen({super.key});

  @override
  ConsumerState<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends ConsumerState<MovieListScreen> {
  @override
  Widget build(BuildContext context) {
    final apiState = ref.watch(apiNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Movie List',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 2.0,
      ),
      body: apiState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : apiState.errorMessage != null
              ? Text('Error: ${apiState.errorMessage}')
              : apiState.data != null
                  ? RefreshIndicator(
                      onRefresh: () async {
                        ref.read(apiNotifierProvider.notifier).fetchData();
                      },
                      child: ListView.builder(
                        itemCount: apiState.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final movie = apiState.data![index];
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            key: Key(movie.sId!),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                bool dismiss = false;
                                var result =
                                    await showDeleteConfirmDialog(context);
                                if (result == 1) {
                                  ref
                                      .read(apiNotifierProvider.notifier)
                                      .deleteData(id: movie.sId!);
                                }
                                return dismiss;
                              }
                              return null;
                            },
                            background: Container(
                              color: Colors.red,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerLeft,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            child: ListTile(
                              onTap: () {
                                AutoRouter.of(context)
                                    .push(MovieDataScreen(model: movie));
                                ref
                                    .read(apiNotifierProvider.notifier)
                                    .updateData(movie);
                              },
                              title: Text(
                                movie.movieTitle ?? '',
                                style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.w700),
                              ),
                              subtitle: Text(
                                movie.movieSubtitle ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              leading: CacheNetworkImageWidget(
                                imageUrl: movie.imageUrl ?? '',
                                height: 10.0.h,
                                width: 10.0.w,
                              ),
                              trailing: Icon(
                                Icons.check,
                                color: movie.read == 1
                                    ? Colors.green
                                    : Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Center(child: Text('No data')),
    );
  }
}
