import 'package:flutter/material.dart';
import 'package:video_compress/video_compress.dart';

class ProgressDialogWidget extends StatefulWidget {
  const ProgressDialogWidget({Key? key}) : super(key: key);

  @override
  _ProgressDialogWidgetState createState() => _ProgressDialogWidgetState();
}

class _ProgressDialogWidgetState extends State<ProgressDialogWidget> {
  late Subscription subscription;
  double? progress;

  @override
  void initState() {
    super.initState();
    subscription = VideoCompress.compressProgress$.subscribe((progress) {
      if (mounted) {
        setState(() {
          this.progress = progress;
        });
      }
    });
  }

  @override
  void dispose() {
    VideoCompress.cancelCompression();
    subscription.unsubscribe;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final value = progress == null ? progress : progress! / 100;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(
            'Compressing video...',
            style: TextStyle(
                fontSize: size.width * .05, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: size.width * .05),
          LinearProgressIndicator(
            value: value,
            minHeight: 10,
          ),
        ],
      ),
    );
  }
}
