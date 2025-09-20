import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final bool isPositive;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
  });

  double _getScale(double width) {
    if (width < 600) {
      // موبايل
      return 0.8;
    } else if (width < 1024) {
      // تابلت
      return 1.0;
    } else {
      // ديسكتوب
      return 1.2;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final scale = _getScale(width);

    return Container(
      padding: EdgeInsets.all(16.0 * scale),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12 * scale),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6 * scale,
            offset: Offset(0, 3 * scale),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 📝 العنوان
          Text(
            title,
            style: TextStyle(
              fontSize: 14 * scale,
              color: const Color(0xFF64748B),
            ),
          ),
          SizedBox(height: 8 * scale),

          /// 📊 القيمة
          Text(
            value,
            style: TextStyle(
              fontSize: 24 * scale,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 8 * scale),

          /// 🔼🔽 التغيير
          Row(
            children: [
              Icon(
                isPositive
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
                color: isPositive
                    ? const Color(0xFF10B981)
                    : const Color(0xFFEF4444),
                size: 16 * scale,
              ),
              SizedBox(width: 4 * scale),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12 * scale,
                  color: isPositive
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
