import 'package:dema/views/Financial/transaction_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinancialReportsView extends StatefulWidget {
  const FinancialReportsView({super.key});

  @override
  State<FinancialReportsView> createState() => _FinancialReportsViewState();
}

class _FinancialReportsViewState extends State<FinancialReportsView> {
  // متغيرات الحالة لإدارة الفلاتر والبيانات
  late DateTimeRange _selectedDateRange;
  late List<Transaction> _filteredTransactions;
  double _totalIncome = 0;
  double _totalExpenses = 0;
  double _netProfit = 0;

  @override
  void initState() {
    super.initState();
    // تحديد الفترة الافتراضية (الشهر الحالي)
    final now = DateTime.now();
    _selectedDateRange = DateTimeRange(
      start: DateTime(now.year, now.month, 1),
      end: DateTime(now.year, now.month + 1, 0),
    );
    _applyFiltersAndCalculate();
  }

  // دالة لتطبيق الفلاتر وحساب المجاميع
  void _applyFiltersAndCalculate() {
    setState(() {
      _filteredTransactions = dummyTransactions.where((t) {
        return !t.date.isBefore(_selectedDateRange.start) &&
            !t.date.isAfter(
              _selectedDateRange.end.add(const Duration(days: 1)),
            );
      }).toList();

      _totalIncome = _filteredTransactions
          .where((t) => t.type == TransactionType.income)
          .fold(0, (sum, item) => sum + item.amount);

      _totalExpenses = _filteredTransactions
          .where((t) => t.type == TransactionType.expense)
          .fold(0, (sum, item) => sum + item.amount);

      _netProfit = _totalIncome + _totalExpenses; // Expenses are negative
    });
  }

  // دالة لاختيار نطاق التاريخ
  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      initialDateRange: _selectedDateRange,
    );
    if (picked != null && picked != _selectedDateRange) {
      _selectedDateRange = picked;
      _applyFiltersAndCalculate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'التقارير المالية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            tooltip: 'تصدير PDF',
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterBar(),
            const SizedBox(height: 16),
            _buildKpiCards(),
            const SizedBox(height: 24),
            _buildChartCard(),
            const SizedBox(height: 24),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return ActionChip(
      onPressed: _selectDateRange,
      avatar: const Icon(Icons.calendar_today),
      label: Text(
        '${DateFormat.yMMMd('ar_SA').format(_selectedDateRange.start)} - ${DateFormat.yMMMd('ar_SA').format(_selectedDateRange.end)}',
      ),
    );
  }

  Widget _buildKpiCards() {
    final currencyFormat = NumberFormat.currency(
      locale: 'ar_SA',
      symbol: 'ريال',
    );
    return Row(
      children: [
        Expanded(
          child: _buildKpiCard(
            'إجمالي الإيرادات',
            currencyFormat.format(_totalIncome),
            Colors.green.shade700,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildKpiCard(
            'إجمالي المصروفات',
            currencyFormat.format(_totalExpenses),
            Colors.red.shade700,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildKpiCard(
            'صافي الربح',
            currencyFormat.format(_netProfit),
            Colors.blue.shade700,
          ),
        ),
      ],
    );
  }

  Widget _buildKpiCard(String title, String value, Color color) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChartCard() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'نظرة عامة على الدخل والمصروفات',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              // الرسم البياني هنا
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: _createChartData(),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 7:
                              return const Text('يوليو');
                            case 8:
                              return const Text('أغسطس');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة لإنشاء بيانات الرسم البياني
  List<BarChartGroupData> _createChartData() {
    // تجميع البيانات الشهرية (مثال مبسط لشهرين فقط)
    final julyIncome = dummyTransactions
        .where((t) => t.date.month == 7 && t.type == TransactionType.income)
        .fold(0.0, (sum, item) => sum + item.amount);
    final julyExpenses = dummyTransactions
        .where((t) => t.date.month == 7 && t.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount.abs());

    final augustIncome = dummyTransactions
        .where((t) => t.date.month == 8 && t.type == TransactionType.income)
        .fold(0.0, (sum, item) => sum + item.amount);
    final augustExpenses = dummyTransactions
        .where((t) => t.date.month == 8 && t.type == TransactionType.expense)
        .fold(0.0, (sum, item) => sum + item.amount.abs());

    return [
      BarChartGroupData(
        x: 7,
        barRods: [
          BarChartRodData(toY: julyIncome, color: Colors.green, width: 15),
          BarChartRodData(toY: julyExpenses, color: Colors.red, width: 15),
        ],
      ),
      BarChartGroupData(
        x: 8,
        barRods: [
          BarChartRodData(toY: augustIncome, color: Colors.green, width: 15),
          BarChartRodData(toY: augustExpenses, color: Colors.red, width: 15),
        ],
      ),
    ];
  }

  Widget _buildTransactionList() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'آخر المعاملات',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const Divider(height: 1),
          if (_filteredTransactions.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: Text('لا توجد معاملات في هذه الفترة')),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) {
                final transaction = _filteredTransactions[index];
                final isIncome = transaction.type == TransactionType.income;
                final currencyFormat = NumberFormat.currency(
                  locale: 'ar_SA',
                  symbol: '',
                );

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: (isIncome ? Colors.green : Colors.red)
                        .withOpacity(0.1),
                    child: Icon(
                      isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                      color: isIncome ? Colors.green : Colors.red,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    transaction.description,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    '${transaction.category.name} • وحدة ${transaction.unitNumber}',
                  ),
                  trailing: Text(
                    '${currencyFormat.format(transaction.amount)} ريال',
                    style: TextStyle(
                      color: isIncome
                          ? Colors.green.shade800
                          : Colors.red.shade800,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, indent: 16, endIndent: 16),
            ),
        ],
      ),
    );
  }
}
