
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: const ExpenseLocatorApp(),
    ),
  );
}

class ExpenseLocatorApp extends StatelessWidget {
  const ExpenseLocatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Locator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FlutterLogo(size: 150),
            const SizedBox(height: 20),
            const Text(
              'Expense Locator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Expense {
  final String id;
  final String title;
  final String category;
  final double amount;
  final DateTime date;
  final String? description;
  final bool isShared;
  final double? userAShare;
  final double? userBShare;

  Expense({
    required this.id,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    this.description,
    this.isShared = false,
    this.userAShare,
    this.userBShare,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'amount': amount,
      'date': date.toIso8601String(),
      'description': description,
      'isShared': isShared,
      'userAShare': userAShare,
      'userBShare': userBShare,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      category: map['category'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
      description: map['description'],
      isShared: map['isShared'] ?? false,
      userAShare: map['userAShare'],
      userBShare: map['userBShare'],
    );
  }
}

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void removeExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Locator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hello, User! Welcome to Expense Locator!',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
                );
              },
              child: const Text('Add New Expense'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExpenseListScreen()),
                );
              },
              child: const Text('View Expense History'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.receipt),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.pie_chart),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'Food';
  DateTime _selectedDate = DateTime.now();
  bool _isShared = false;
  bool _isExpense = true;
  String _splitType = 'equal';
  double _userAPercentage = 50;
  double _userBPercentage = 50;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      final expenseProvider = Provider.of<ExpenseProvider>(context, listen: false);

      double? userAShare;
      double? userBShare;

      if (_isShared) {
        final totalAmount = double.parse(_amountController.text);
        if (_splitType == 'equal') {
          userAShare = totalAmount / 2;
          userBShare = totalAmount / 2;
        } else {
          userAShare = (_userAPercentage / 100) * totalAmount;
          userBShare = (_userBPercentage / 100) * totalAmount;
        }
      }

      final newExpense = Expense(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        category: _selectedCategory,
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        description: _descriptionController.text,
        isShared: _isShared,
        userAShare: userAShare,
        userBShare: userBShare,
      );

      expenseProvider.addExpense(newExpense);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expense saved successfully')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Expense'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChoiceChip(
                    label: const Text('Expense'),
                    selected: _isExpense,
                    onSelected: (selected) {
                      setState(() {
                        _isExpense = selected;
                      });
                    },
                  ),
                  ChoiceChip(
                    label: const Text('Income'),
                    selected: !_isExpense,
                    onSelected: (selected) {
                      setState(() {
                        _isExpense = !selected;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Food', child: Text('Food')),
                  DropdownMenuItem(value: 'Transport', child: Text('Transport')),
                  DropdownMenuItem(value: 'Bills', child: Text('Bills')),
                  DropdownMenuItem(value: 'Shopping', child: Text('Shopping')),
                  DropdownMenuItem(value: 'Education', child: Text('Education')),
                  DropdownMenuItem(value: 'Entertainment', child: Text('Entertainment')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != _selectedDate) {
                    setState(() {
                      _selectedDate = picked;
                    });
                  }
                },
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${_selectedDate.toLocal()}".split(' ')[0],
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text('Share this expense'),
                value: _isShared,
                onChanged: (newValue) {
                  setState(() {
                    _isShared = newValue!;
                  });
                },
              ),
              if (_isShared) ...[
                const SizedBox(height: 20),
                const Text('Split Options:'),
                RadioListTile(
                  title: const Text('Equal Split'),
                  value: 'equal',
                  groupValue: _splitType,
                  onChanged: (value) {
                    setState(() {
                      _splitType = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Custom Percentage'),
                  value: 'custom',
                  groupValue: _splitType,
                  onChanged: (value) {
                    setState(() {
                      _splitType = value.toString();
                    });
                  },
                ),
                if (_splitType == 'custom') ...[
                  const SizedBox(height: 10),
                  const Text('User A Percentage:'),
                  Slider(
                    value: _userAPercentage,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: _userAPercentage.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        _userAPercentage = value;
                        _userBPercentage = 100 - value;
                      });
                    },
                  ),
                  Text('User A: ${_userAPercentage.round()}%, User B: ${_userBPercentage.round()}%'),
                ],
              ],
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _saveExpense,
                    child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.receipt),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.pie_chart),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
        ],
      ),
      body: expenseProvider.expenses.isEmpty
          ? const Center(
        child: Text(
          'No expenses yet. Add your first expense!',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: expenseProvider.expenses.length,
        itemBuilder: (context, index) {
          final expense = expenseProvider.expenses[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        expense.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'PKR ${expense.amount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    expense.category,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${expense.date.toLocal()}".split(' ')[0],
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  if (expense.description != null && expense.description!.isNotEmpty) ...[
                    const SizedBox(height: 5),
                    Text(
                      expense.description!,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                  if (expense.isShared) ...[
                    const SizedBox(height: 5),
                    Text(
                      'Shared: ${expense.userAShare?.toStringAsFixed(2)} / ${expense.userBShare?.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Edit functionality
                        },
                        child: const Text('Edit'),
                      ),
                      TextButton(
                        onPressed: () {
                          expenseProvider.removeExpense(expense.id);
                        },
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.receipt),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.pie_chart),
              onPressed: null,
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: null,
            ),
          ],
        ),
      ),
    );
  }
}

