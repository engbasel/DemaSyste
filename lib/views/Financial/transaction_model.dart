// import 'package:flutter/material.dart';

// class FinancialReportsView extends StatefulWidget {
//   const FinancialReportsView({super.key});

//   @override
//   State<FinancialReportsView> createState() => _FinancialReportsViewState();
// }

// class _FinancialReportsViewState extends State<FinancialReportsView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('التقارير المالية')),
//       body: const Center(child: Text('التقارير المالية')),
//     );
//   }
// }
// نوع المعاملة: إما دخل أو مصروف
enum TransactionType { income, expense }

// الفئات المختلفة للمعاملات
enum TransactionCategory {
  rent("إيجار"),
  maintenance("صيانة"),
  utilities("فواتير خدمات"),
  salaries("رواتب"),
  other("أخرى");

  const TransactionCategory(this.name);
  final String name;
}

class Transaction {
  final String id;
  final double amount;
  final TransactionType type;
  final TransactionCategory category;
  final DateTime date;
  final String description;
  final String unitNumber; // لربط المعاملة بالوحدة

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    required this.description,
    required this.unitNumber,
  });
}

// --- بيانات وهمية واقعية ---
final List<Transaction> dummyTransactions = [
  // --- Income ---
  Transaction(
    id: 'TR-001',
    amount: 7500,
    type: TransactionType.income,
    category: TransactionCategory.rent,
    date: DateTime(2025, 7, 15),
    description: 'دفعة إيجار - عبدالله الشمري',
    unitNumber: '101',
  ),
  Transaction(
    id: 'TR-002',
    amount: 2400,
    type: TransactionType.income,
    category: TransactionCategory.rent,
    date: DateTime(2025, 7, 16),
    description: 'دفعة إيجار - سارة القحطاني',
    unitNumber: '205',
  ),
  Transaction(
    id: 'TR-003',
    amount: 9000,
    type: TransactionType.income,
    category: TransactionCategory.rent,
    date: DateTime(2025, 7, 17),
    description: 'دفعة إيجار - فيصل الحربي',
    unitNumber: '302',
  ),
  Transaction(
    id: 'TR-008',
    amount: 7500,
    type: TransactionType.income,
    category: TransactionCategory.rent,
    date: DateTime(2025, 8, 15),
    description: 'دفعة إيجار - عبدالله الشمري',
    unitNumber: '101',
  ),
  Transaction(
    id: 'TR-009',
    amount: 2400,
    type: TransactionType.income,
    category: TransactionCategory.rent,
    date: DateTime(2025, 8, 16),
    description: 'دفعة إيجار - سارة القحطاني',
    unitNumber: '205',
  ),
  Transaction(
    id: 'TR-010',
    amount: 9000,
    type: TransactionType.income,
    category: TransactionCategory.rent,
    date: DateTime(2025, 8, 17),
    description: 'دفعة إيجار - فيصل الحربي',
    unitNumber: '302',
  ),

  // --- Expenses ---
  Transaction(
    id: 'TR-004',
    amount: -350,
    type: TransactionType.expense,
    category: TransactionCategory.maintenance,
    date: DateTime(2025, 7, 20),
    description: 'إصلاح تسريب صنبور المطبخ',
    unitNumber: '101',
  ),
  Transaction(
    id: 'TR-005',
    amount: -1200,
    type: TransactionType.expense,
    category: TransactionCategory.utilities,
    date: DateTime(2025, 7, 28),
    description: 'فاتورة الكهرباء للشهر',
    unitNumber: 'مبنى A',
  ),
  Transaction(
    id: 'TR-006',
    amount: -5000,
    type: TransactionType.expense,
    category: TransactionCategory.salaries,
    date: DateTime(2025, 7, 30),
    description: 'راتب موظف الاستقبال',
    unitNumber: 'إداري',
  ),
  Transaction(
    id: 'TR-007',
    amount: -800,
    type: TransactionType.expense,
    category: TransactionCategory.maintenance,
    date: DateTime(2025, 8, 5),
    description: 'طلاء جدران الوحدة بعد الخروج',
    unitNumber: '401',
  ),
  Transaction(
    id: 'TR-011',
    amount: -1250,
    type: TransactionType.expense,
    category: TransactionCategory.utilities,
    date: DateTime(2025, 8, 28),
    description: 'فاتورة الكهرباء للشهر',
    unitNumber: 'مبنى A',
  ),
  Transaction(
    id: 'TR-012',
    amount: -5000,
    type: TransactionType.expense,
    category: TransactionCategory.salaries,
    date: DateTime(2025, 8, 30),
    description: 'راتب موظف الاستقبال',
    unitNumber: 'إداري',
  ),
];
