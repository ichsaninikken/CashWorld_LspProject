import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cash_world/utils/app_color.dart';

class CustomInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool disabled;
  final EdgeInsetsGeometry margin;
  final bool obsecureText;
  final Widget? suffixIcon;
  final bool isDate;
  final bool isNumber;
  final bool isNominal;
  final bool isClickEmpty;
  const CustomInput({super.key, 
    required this.controller,
    required this.label,
    required this.hint,
    this.disabled = false,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.obsecureText = false,
    this.isDate = false,
    this.suffixIcon,
    this.isNumber = false,
    this.isNominal = false,
    this.isClickEmpty = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              color: AppColor.secondarySoft,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
            margin: widget.margin,
            decoration: BoxDecoration(
              color: (widget.disabled == false)
                  ? Colors.transparent
                  : AppColor.primaryExtraSoft,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 1, color: AppColor.secondaryExtraSoft),
            ),
            child: TextField(
              readOnly: widget.disabled,
              obscureText: widget.obsecureText,
              style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
              maxLines: 1,
              controller: widget.controller,
              keyboardType:
                  widget.isNumber ? TextInputType.number : TextInputType.text,
              onChanged: (text) {
                if (widget.isNumber && widget.isNominal) {
                  final numericText = text.replaceAll(
                      RegExp(r'[^0-9]'), ''); 
                  final formattedText = NumberFormat.currency(
                    symbol: 'Rp ',
                    decimalDigits: 0, // Tidak ada desimal
                    locale: 'id_ID', 
                  ).format(int.tryParse(numericText) ??
                      0); // Format angka ('Rp ')

                  widget.controller.value = widget.controller.value.copyWith(
                    text: formattedText,
                    selection:
                        TextSelection.collapsed(offset: formattedText.length),
                  );
                }
              },
              onTap: () async {
                if (widget.isDate) {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.now(), // Atur ke tanggal awal yang sesuai
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    print(
                        pickedDate); 
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate);
                    print(
                        formattedDate); 

                    setState(() {
                      widget.controller.text =
                          formattedDate; 
                    });
                  } else {
                    print("Tanggal belum dipilih");
                  }
                }
                if (widget.isClickEmpty) {
                  setState(() {
                    widget.controller.text = "";
                  });
                }
              },
              decoration: InputDecoration(
                suffixIcon: widget.suffixIcon ?? const SizedBox(),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  color: AppColor.secondarySoft,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
