import 'package:drivey_files/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class NonViewableWidget extends StatelessWidget {
  const NonViewableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sorry, can't view this file :(",
            style: AppStyles.textStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
            ),
            onPressed: () {},
            child: Text("Downlaod"),
          )
        ],
      ),
    );
  }
}
