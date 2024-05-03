import 'package:auto_route/annotations.dart';
import 'package:bayad_test/model/data_model.dart';
import 'package:bayad_test/widgets/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage()
class MovieDataScreen extends StatefulWidget {
  final DataModel model;

  const MovieDataScreen({super.key, required this.model});

  @override
  State<MovieDataScreen> createState() => _MovieDataScreenState();
}

class _MovieDataScreenState extends State<MovieDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.model.movieTitle ?? '',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 2.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CacheNetworkImageWidget(
                imageUrl: widget.model.imageUrl ?? '',
                height: 20.0.h,
                width: double.infinity),
            SizedBox(
              height: 2.0.h,
            ),
            Text(
              widget.model.movieSubtitle ?? '',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
