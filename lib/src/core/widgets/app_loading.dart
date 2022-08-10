import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog<dynamic>(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (_) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
