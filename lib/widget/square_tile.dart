import '../core/app_export.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.grey[300],
        ),
        child: Image.asset(
          imagePath,
          height: 35.r,
          // color: Colors.deepPurple.shade300,
        ),
      ),
    );
  }
}
