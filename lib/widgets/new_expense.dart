import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {

  const NewExpense({required this.onAddExpense, super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {


  /**
   * For input value to be saved, use Controller, because it does all the heavy lifting for you
   */
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    // Future
    final pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {

    // tryParse('Hello') => null if cannot parse
    final enteredAmount = double.tryParse(_amountController.text);

    final amountisInvalid = enteredAmount == null || enteredAmount <= 0;

    if(_titleController.text.trim().isEmpty || amountisInvalid || _selectedDate == null) {
      // Show Error Message
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please make sure a valid title, amount, date and cateogry was entered.'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(ctx);
          },
          child: const Text('Close'))
        ],
      ));

      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory
      )
    );
  }

  /**
   * 
   * Dispose method is important for Controller or else it would cause memory leak
   * 
   * Note: Only "State" classes can implement "dispose" method,
   * which means you must use a StatefulWidget
   */
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  /**
   * Instead use Controller
   */
  // String _enteredTitle = '';
  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  onCancel() {
    // _titleController.value = '';
    // _amountController.value = '';
    // widget.onClose();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: TextField(
                  // onChanged: _saveTitleInput,
                  controller: _titleController,
                  maxLength: 50,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    label: Text('Title')
                  ), // Placeholder.....STRANGE
                )
              ),
            ],
          ),
          Row(
            children: [
              Expanded(child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$ ',
                    label: Text('Amount')
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Exclaimation to tell dart that this wont be null
                  Text(_selectedDate == null ? 'No date selected': formatter.format(_selectedDate!)),
                  IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              // Yuck!!!!
              // Dropdown doesn't have controller
              DropdownButton(
                value: _selectedCategory,
                items: Category.values.map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category.name.toUpperCase(),
                    )
                  )
                ).toList(),
                onChanged: (value) {
                  if(value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  _submitExpenseData();
                }, child: const Text('Save Expense')
              ),
              ElevatedButton(onPressed: onCancel, child: const Text('Cancel'))
            ],
          ),
        ],
      ),
    );
  }
}