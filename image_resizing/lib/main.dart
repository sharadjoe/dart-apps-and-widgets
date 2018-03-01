import 'package:http/http.dart' as http;
import 'package:image/image.dart';
import 'dart:io';

void download(String url,String path, String preview)
{
  // get the file
  var data= http.readBytes(url);

  //write file to disk
  data.then((buffer){
    File f = new File(path);
    RandomAccessFile rf = f.openSync(mode: FileMode.WRITE);
    rf.writeFromSync(buffer);
    rf.flushSync();
    rf.close();

    //load the image
    var image = decodeImage(new File(path).readAsBytesSync());

    //resize the image
    var thumbnail= copyRotate(image, 200);

    //save thumbnail to disk
    new File(preview)
    ..writeAsBytesSync(encodePng(thumbnail));

  });

}

main(List<String> args) {
  String url = 'https://flutter.io/images/intellij/hot-reload.gif';
  String path = "/Users/sharadjoe/Desktop/test.gif";
  String preview ='/Users/sharadjoe/Desktop/preview.png';

  download(url, path, preview);
}
