import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  final file = File('assets/images/combination_logo_white.png');
  if (!file.existsSync()) {
    print('File not found');
    return;
  }

  final image = img.decodeImage(file.readAsBytesSync());
  if (image == null) return;

  int maxSize = image.width > image.height ? image.width : image.height;
  int newSize = (maxSize * 2.2).round();

  final paddedImage = img.Image(width: newSize, height: newSize);

  int xPos = (newSize - image.width) ~/ 2;
  int yPos = (newSize - image.height) ~/ 2;

  img.compositeImage(paddedImage, image, dstX: xPos, dstY: yPos);

  File(
    'assets/images/combination_logo_white_padded.png',
  ).writeAsBytesSync(img.encodePng(paddedImage));

}
