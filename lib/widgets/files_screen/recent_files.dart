import 'package:cached_network_image/cached_network_image.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:drivey_files/core/utils/app_values.dart';
import 'package:flutter/material.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Recent files",
            textAlign: TextAlign.left,
            style: AppStyles.textStyle(
              fontSize: 14,
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 75,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 75,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                "assets/images/image.jpg",
                                fit: BoxFit.cover,
                              ),
                              // child: CachedNetworkImage(
                              //   width: 75,
                              //   imageUrl: AppValues.testImage,
                              // ),
                            ),
                          ),
                          // constSizedBox(height: 3,),
                          Text(
                            "Photp.png",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: AppStyles.textStyle(
                                fontSize: 10, color: AppColors.textColor),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
