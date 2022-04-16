import 'dart:async';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfcdemo/widgets/drawerWidget.dart';
import 'package:skeletons/skeletons.dart';
import 'package:swipe_image_gallery/swipe_image_gallery.dart';

import '../utilities/constants.dart';

class CopyRightText extends StatelessWidget {
  const CopyRightText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      width: size.width,
      child: Center(
        child: CustomTextSingleLine(
          content: '@Copyright 2019 2020 powered By MICM Net Solution Pvt. Ltd',
          style: GoogleFonts.lato(
              fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ImageWithAsset extends StatelessWidget {
  final String path;
  final double? height, width;
  final BoxFit? boxFit;

  const ImageWithAsset({
    Key? key,
    required this.path,
    this.height,
    this.width,
    this.boxFit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image(
      image: AssetImage('assets/' + path),
      height: height ?? size.height * .20,
      width: width ?? size.width * .20,
      fit: boxFit ?? BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return ImageWithAsset(
          path: 'images/imgNotAvailable.png',
          boxFit: BoxFit.fill,
          height: size.width * .16,
          width: size.width * .16,
        );
      },
    );
  }
}

class ImageWithNetwork extends StatelessWidget {
  final String url;
  final double? height, width;
  final BoxFit? boxFit;

  const ImageWithNetwork(
      {Key? key, required this.url, this.height, this.width, this.boxFit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Image(
      image: NetworkImage(imageFileHostedPath + url),
      height: height ?? size.height * .20,
      width: width ?? size.width * .20,
      fit: boxFit ?? BoxFit.contain,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return ImageWithAsset(
          path: 'images/imgNotAvailable.png',
          boxFit: BoxFit.fill,
          height: height ?? size.width * .20,
          width: width ?? size.width * .20,
        );
      },
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText(
      {Key? key, required this.content, this.style, this.textAlign})
      : super(key: key);

  final String content;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: 100,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.0,
      style: style ?? GoogleFonts.lato(),
    );
  }
}

class CustomTextSingleLine extends StatelessWidget {
  const CustomTextSingleLine(
      {Key? key, required this.content, this.style, this.textAlign})
      : super(key: key);

  final String content;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1.0,
      style: style ?? GoogleFonts.lato(),
    );
  }
}

class CustomSkeletonTheme extends StatelessWidget {
  const CustomSkeletonTheme({Key? key, required this.childSkeleton})
      : super(key: key);

  final Widget childSkeleton;

  @override
  Widget build(BuildContext context) {
    return SkeletonTheme(
      shimmerGradient: LinearGradient(
        colors: [
          Colors.white,
          Colors.grey.shade300,
          Colors.white,
        ],
        stops: [
          0.1,
          0.5,
          0.9,
        ],
      ),
      themeMode: ThemeMode.system,
      child: childSkeleton,
    );
  }
}

class CustomListViewAnimation extends StatelessWidget {
  const CustomListViewAnimation(
      {Key? key, required this.count, required this.child})
      : super(key: key);

  final int count;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
        position: count,
        delay: Duration(milliseconds: 100),
        child: SlideAnimation(
            duration: Duration(milliseconds: 2500),
            curve: Curves.fastLinearToSlowEaseIn,
            child: FadeInAnimation(
                duration: Duration(milliseconds: 2500),
                curve: Curves.fastLinearToSlowEaseIn,
                child: child)));
  }
}

typedef NavigateWidgetBuilder = Widget Function();

mixin NavigateMixin on Widget {
  NavigateWidgetBuilder? get navigationBuilder;

  Future<T?> navigate<T>(BuildContext context) {
    if (navigationBuilder == null) {
      return Future.value();
    } else {
      return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => navigationBuilder!(),
        ),
      );
    }
  }
}

const kNavigationCardRadius = 8.0;

class NavigationCard extends StatelessWidget with NavigateMixin {
  const NavigationCard({
    Key? key,
    this.margin,
    this.borderRadius =
        const BorderRadius.all(Radius.circular(kNavigationCardRadius)),
    this.navigationBuilder,
    required this.child,
  }) : super(key: key);

  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Widget child;
  final NavigateWidgetBuilder? navigationBuilder;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: margin,
      shape: borderRadius != null
          ? RoundedRectangleBorder(borderRadius: borderRadius!)
          : null,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => navigate(context),
        child: child,
      ),
    );
  }
}

class TitleAppBar extends StatelessWidget with PreferredSizeWidget {
  TitleAppBar(
    this.title, {
    Key? key,
  })  : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
    );
  }
}

class CustomExpansionTileCard extends StatelessWidget {
  const CustomExpansionTileCard(
      {Key? key,
      required this.children,
      required this.initiallyExpanded,
      required this.title})
      : super(key: key);

  final List<Widget> children;
  final bool initiallyExpanded;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.only(top: 18),
      child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(color: theme.colorScheme.primary, width: 3))),
          child: ExpansionTileCard(
            animateTrailing: true,
            title: title,
            duration: Duration(milliseconds: 500),
            colorCurve: Curves.easeIn,
            initiallyExpanded: initiallyExpanded,
            children: children,
            elevation: 0,
            initialElevation: 0,
          )),
    );
  }
}

class CustomChipDesign extends StatelessWidget {
  const CustomChipDesign(
      {Key? key,
      required this.label,
      this.bGColor,
      this.color,
      this.borderRadius,
      this.padding,
      this.fontsize,
      this.style})
      : super(key: key);

  final String label;
  final Color? bGColor;
  final Color? color;
  final double? borderRadius;
  final double? padding;
  final double? fontsize;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Chip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 40),
      ),
      label: CustomText(
        textAlign: TextAlign.center,
        content: label,
        style: style ??
            GoogleFonts.lato(
                color: color ?? theme.colorScheme.secondaryVariant,
                fontWeight: FontWeight.bold,
                fontSize: fontsize ?? 13),
      ),
      backgroundColor: bGColor ?? theme.colorScheme.primaryVariant,
      elevation: 0,
      shadowColor: theme.colorScheme.secondaryVariant,
      padding: EdgeInsets.all(padding ?? 10),
    );
  }
}

class CustomMessage extends StatelessWidget {
  const CustomMessage({Key? key, this.msg}) : super(key: key);

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        content: msg ?? "No Data Available",
        style: GoogleFonts.lato(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontSize: 17),
      ),
    );
  }
}

class CustomeCardHeader extends StatelessWidget {
  const CustomeCardHeader(
      {Key? key, required this.row, this.height, this.padding, this.bgColor})
      : super(key: key);
  final Widget row;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    var them = Theme.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor ?? them.colorScheme.secondaryVariant,
      ),
      alignment: Alignment.centerLeft,
      child: row,
    );
  }
}

class CustomChipIcone extends StatelessWidget {
  const CustomChipIcone(
      {Key? key,
      this.height,
      this.width,
      this.icone,
      this.onClick,
      this.bgColor,
      this.size})
      : super(key: key);

  final double? height;
  final double? width;
  final double? size;
  final Icon? icone;
  final VoidCallback? onClick;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: height ?? 35,
      width: width ?? 35,
      child: CircleAvatar(
        backgroundColor: bgColor ?? theme.colorScheme.primaryVariant,
        child: IconButton(
          icon: icone ??
              Icon(
                Icons.download_rounded,
                size: size ?? 20,
              ),
          onPressed: onClick ?? () {},
        ),
      ),
    );
  }
}

Future<void> swipeImage(BuildContext context, List<Image> lstIamges, int index,
    bool showControll) async {
  StreamController<Widget> overlayController =
      StreamController<Widget>.broadcast();
  SwipeImageGallery(
    initialIndex: index,
    context: context,
    images: lstIamges,
    onSwipe: (inx) {
      overlayController.add(OverlayExample(
        title: '${inx + 1}/${lstIamges.length}',
      ));
    },
    overlayController: overlayController,
    initialOverlay: OverlayExample(
      title: showControll ? '${index + 1}/${lstIamges.length}' : '',
    ),
  ).show();
}

class OverlayExample extends StatelessWidget {
  const OverlayExample({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black.withAlpha(50),
            padding: EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 18.0,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            color: Colors.white,
            tooltip: 'Close',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

Future<T?> showBottomSheetPage<T>({
  required BuildContext context,
  AppBar? appbar,
  String? appBarTitle = "Manage Students",
  required Widget body,
  bool? isDrawerRequired = false,
  Color? backgroundcolor = Colors.black12,
  bool isFullScreen = false,
  bool isDismissible = false,
  ShapeBorder? shape,
}) {
  return showModalBottomSheet<T>(
    isDismissible: isDismissible,
    context: context,
    backgroundColor: backgroundcolor,
    isScrollControlled: isFullScreen,
    builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appbar != null ? appbar : null,
        body: body,
        drawer: isDrawerRequired == true ? DrawerWidget() : null,
      );
    },
    shape: shape != null
        ? shape
        : RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
  );
}
