import 'package:flutter/material.dart';
import 'package:wins_core_flutter/components/InputText.dart';

import '../style/AppStyle.dart';
import 'BuisnesLayer/OptionFormly.dart';

class OptionsBottomSheet extends StatefulWidget {
  final String label;
  final List<OptionFormly> options;
  final ValueChanged<dynamic> onSelected;

  const OptionsBottomSheet({
    super.key,
    required this.label,
    required this.options,
    required this.onSelected,
  });

  static void show({
    required BuildContext context,
    required String label,
    required List<OptionFormly> options,
    required ValueChanged<dynamic> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Позволяет BottomSheet подниматься вместе с клавиатурой
      backgroundColor: AppStyle().black,
      builder: (BuildContext context) => OptionsBottomSheet(
        label: label,
        options: options,
        onSelected: onSelected,
      ),
    );
  }

  @override
  State<OptionsBottomSheet> createState() => _OptionsBottomSheetState();
}

class _OptionsBottomSheetState extends State<OptionsBottomSheet> {
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Фильтруем список на лету: приводим к нижнему регистру для регистронезависимого поиска
    final filteredOptions = widget.options.where((option) {
      return option.label.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    // Используем Padding + AnimatedPadding, чтобы клавиатура не перекрывала BottomSheet на смартфонах
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: AppStyle().white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(widget.label, style: AppStyle().body0()),
              ),

              // Показываем поиск, только если ИЗНАЧАЛЬНЫЙ список больше 7 элементов
              if (widget.options.length > 7)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: InputText(
                    placeholder: "Поиск...",
                    onChanged: (txt) {
                      setState(() {
                        searchQuery = txt; // Перерисовываем виджет с новой строкой поиска
                      });
                    },
                  ),
                ),

        //      const Divider(height: 1),
              Flexible(
                child: filteredOptions.isEmpty
                    ? Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text("Ничего не найдено", style: AppStyle().body1()),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredOptions.length,
                  itemBuilder: (context, index) {
                    final option = filteredOptions[index];
                    return ListTile(
                      title: Text(
                        option.label,
                        style: AppStyle().body1(),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        widget.onSelected(option.value ?? "");
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
           //   const Divider(height: 1),
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: Text('Отмена', style: AppStyle().body0()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
