part of 'main.dart';

Widget _iconMessageView({
  required IconData icon,
  required String message,
}) {
  return Center(
    child: Column(
      children: [
        Icon(
          icon,
          size: 100,
          color: Colors.grey,
        ),
        const SizedBox(height: 16),
        Text(message),
      ],
    ),
  );
}
