import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconSvg extends StatelessWidget
{
  final String icon;
  final double? size;
  final Color? color;

  const IconSvg(this.icon,{super.key, this.size, this.color});

  @override
  Widget build(BuildContext context)
  {
    final String iconString = "lib/Assets/Icons/$icon.svg";
    final double iconSize = size ?? 35;
    return color == null
        ? SvgPicture.asset(iconString,width: iconSize,height: iconSize)
        : SvgPicture.asset(iconString,color: color, width: iconSize,height: iconSize);
  }
}

class ImageSvg extends StatelessWidget
{
  final String image;
  final double? width;
  final double? height;

  const ImageSvg(this.image,{super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) => SvgPicture.asset("lib/Assets/Images/$image.svg", width: width, height: height);
}