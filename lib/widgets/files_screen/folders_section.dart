import 'package:drivey_files/core/utils/app_assets.dart';
import 'package:drivey_files/core/utils/app_colors.dart';
import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FoldersSection extends StatelessWidget {
  const FoldersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // color: Colors.grey,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    offset: const Offset(10, 10),
                    blurRadius: 5),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    AppAssets.folderPath,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  "My folder",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyle(
                    fontSize: 12,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "5 files",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.textStyle(
                    fontSize: 10,
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
