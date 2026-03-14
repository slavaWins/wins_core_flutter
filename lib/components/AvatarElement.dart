import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wins_core_flutter/style/AppStyle.dart';

class AvatarElement extends StatelessWidget {
  final double size;
  final double radius;
  final String? url;
  final String? name;
  final bool isOnline;
  final int isNotify;

  const AvatarElement({
    Key? key,
    required this.size,
    this.url,
    this.name,
    this.isOnline = false, // По умолчанию false
    this.isNotify = 0, // По умолчанию false
    this.radius = 100, // По умолчанию false
  }) : super(key: key);

  // Генерация цвета на основе первого символа имени
  Color _getColorFromName() {
    if (name == null || name!.isEmpty) return Colors.grey;

    final firstChar = name!.codeUnitAt(0);
    final colors = [
      Colors.indigo,
      Colors.black26,
      Colors.teal,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.pink,
      Colors.black26,
    ];

    return colors[firstChar % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Основной аватар
        ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: url != null && url!.isNotEmpty
              ? CachedNetworkImage(
            imageUrl: url!,
            width: size,
            height: size,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Image.asset(
              'assets/img/user.png',
              width: size,
              height: size,
              fit: BoxFit.cover,
            ),
          )
              : (name != null)
              ? Container(
            color: _getColorFromName(),
            width: size,
            height: size,
            child: Center(
              child: Text(
                name!.substring(0, 2),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size / 3,
                ),
              ),
            ),
          )
              : Image.asset(
            'assets/img/user.png',
            width: size,
            height: size,
            fit: BoxFit.cover,
          ),
        ),

        // Индикатор онлайн (только если isOnline == true)
        if (isOnline)
          Positioned(
            right: size * 0.0014, // 2% от размера аватара
            bottom: size * 0.0121, // 2% от размера аватара
            child: Container(
              width: size * 0.26, // 25% от размера аватара
              height: size * 0.26, // 25% от размера аватара
              decoration: BoxDecoration(
                color: AppStyle().primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppStyle().background,
                  width: size * 0.03, // 3% от размера аватара
                ),
              ),
            ),
          ),


        if (isNotify>0)
          Positioned(
            right: 0, // 2% от размера аватара
            top: size * 0.0121 , // 2% от размера аватара
            child: Container(
              alignment: AlignmentGeometry.center,
              width: size * 0.26 *1.6, // 25% от размера аватара
              height: size * 0.26 *1.6, // 25% от размера аватара
              decoration: BoxDecoration(
                color: AppStyle().accent,
                shape: BoxShape.circle,
              ),
              child: Text(isNotify.toString(), style: AppStyle().body2(),),
            ),
          ),
      ],
    );
  }
}