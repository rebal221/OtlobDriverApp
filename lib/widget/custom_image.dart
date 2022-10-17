import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomPngImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomPngImage(
      {Key? key,
      this.imageName,
      this.height,
      this.width,
      this.boxFit,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/$imageName.png',
      color: color,
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomJpgImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomJpgImage(
      {this.imageName, this.height, this.width, this.boxFit, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$imageName.jpg',
      color: color,
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomImageNetwork extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;

  const CustomImageNetwork(
      {this.imageUrl, this.height, this.width, this.boxFit, this.color});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl ?? '',
      color: color,
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: boxFit ?? BoxFit.contain,
      isAntiAlias: true,
    );
  }
}

class CustomSvgImage extends StatelessWidget {
  final String? imageName;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? boxFit;

  const CustomSvgImage(
      {this.imageName, this.height, this.width, this.color, this.boxFit});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/$imageName.svg',
      height: height ?? 30.h,
      width: width ?? 30.w,
      fit: boxFit ?? BoxFit.contain,
      color: color,
    );
  }
}
