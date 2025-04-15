import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DrawingPage extends StatefulWidget {
  @override
  _DrawingPageState createState() => _DrawingPageState();
}

class _DrawingPageState extends State<DrawingPage> {
  List<Offset?> points = [];
  Color currentColor = Colors.black;
  double strokeWidth = 5.0;
  bool isErasing = false;
  GlobalKey _globalKey = GlobalKey();
  List<File> savedDrawings = [];

  @override
  void initState() {
    super.initState();
    loadSavedDrawings();
  }

  void onPanUpdate(DragUpdateDetails details) {
    setState(() {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      Offset localPosition = renderBox.globalToLocal(details.globalPosition);
      points.add(localPosition);
    });
  }

  void clearCanvas() {
    setState(() {
      points.clear();
    });
  }

  void changeColor(Color color) {
    setState(() {
      currentColor = color;
      isErasing = false;
    });
  }

  void toggleEraser() {
    setState(() {
      isErasing = !isErasing;
      strokeWidth = isErasing ? 20.0 : 5.0;
    });
  }

  void showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(context.locale.languageCode == 'ar'
              ? "اختيار اللون"
              : "choose the color",style: TextStyle(fontFamily: 'Tajawal',),),
          content: BlockPicker(
            pickerColor: currentColor,
            onColorChanged: changeColor,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.locale.languageCode == 'ar'
            ? "إلغاء"
            : "cancel",style: TextStyle(fontFamily: 'Tajawal',),)),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(context.locale.languageCode == 'ar'
            ? "تم"
            : "done",style: TextStyle(fontFamily: 'Tajawal',),),
            ),
          ],
        );
      },
    );
  }

  Future<void> saveDrawingInApp() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String filePath = '${directory.path}/drawing_${DateTime.now().millisecondsSinceEpoch}.png';

      RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      var byteData = await image.toByteData(format: ImageByteFormat.png);

      if (byteData == null) throw Exception("تعذر التقاط الصورة من اللوحة".tr());

      var uint8List = byteData.buffer.asUint8List();
      File file = File(filePath);
      await file.writeAsBytes(uint8List);

      setState(() {
        savedDrawings.add(file);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.locale.languageCode == 'ar'
            ? "تم حفظ الرسم داخل التطبيق!"
            : "The drawing has been saved within the application:",
        style: TextStyle(fontFamily: 'Tajawal',),)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.locale.languageCode == 'ar'
            ? "حدث خطأ أثناء حفظ الرسم! حاول مرة أخرى."
            : "An error occurred while saving the drawing! Try again.",
        style: TextStyle(fontFamily: 'Tajawal',),)),
      );
    }
  }

  Future<void> loadSavedDrawings() async {
    final directory = await getApplicationDocumentsDirectory();
    List<FileSystemEntity> files = directory.listSync();
    setState(() {
      savedDrawings = files.whereType<File>().toList();
    });
  }

  Future<void> deleteDrawing(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
        setState(() {
          savedDrawings.remove(file);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.locale.languageCode == 'ar'
              ? "تم حذف الرسم بنجاح!"
              : "The drawing has been successfully deleted!",
            style: TextStyle(fontFamily: 'Tajawal',),)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.locale.languageCode == 'ar'
            ? "تعذر حذف الرسم! حاول مرة أخرى."
            : "Could not delete drawing! Try again..",
        style: TextStyle(fontFamily: 'Tajawal',),)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.locale.languageCode == 'ar'
            ? "ارسم مشاعرك"
            : "draw your feeling",style: TextStyle(fontFamily: 'Tajawal',),),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: clearCanvas,
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: Icon(Icons.color_lens), onPressed: showColorPickerDialog),
              IconButton(
                icon: Icon(isErasing ? Icons.brush : Icons.cleaning_services),
                onPressed: () => setState(() => isErasing = !isErasing),
              ),
            ],
          ),
          Expanded(
            child: RepaintBoundary(
              key: _globalKey,
              child: GestureDetector(
                onPanUpdate: onPanUpdate,
                onPanEnd: (details) => points.add(null),
                child: CustomPaint(
                  painter: MyPainter(points, currentColor, strokeWidth),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.teal, width: 3)),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: saveDrawingInApp,
            child: Text(context.locale.languageCode == 'ar'
                ? "حفظ الرسم"
                : "Save the drawing",style: TextStyle(fontFamily: 'Tajawal',),),
          ),
          if (savedDrawings.isNotEmpty)
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: savedDrawings.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Image.file(savedDrawings[index], width: 80, height: 80, fit: BoxFit.cover),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red, size: 20),
                            onPressed: () => deleteDrawing(savedDrawings[index]),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;

  MyPainter(this.points, this.color, this.strokeWidth);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
