import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';
import 'package:spotify_downloader/core/presentation/widgets/custom_button.dart';
import 'package:spotify_downloader/core/utils/utils.dart';

class SelectOptionsModal extends StatefulWidget {
  final List<String> items;
  final Function(String?) onSelect;

  const SelectOptionsModal({
    super.key,
    required this.items,
    required this.onSelect,
  });

  @override
  State<SelectOptionsModal> createState() => _SelectOptionsModalState();
}

class _SelectOptionsModalState extends State<SelectOptionsModal> {
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            itemCount: widget.items.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              final item = widget.items[index];
              return GestureDetector(
                onTap: () => setState(() => _selectedValue = item),
                child: Row(
                  children: [
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: ColorsConstant.greyShade100,
                      ),
                      child: Radio<String>(
                        value: item,
                        activeColor: ColorsConstant.primaryColor,
                        groupValue: _selectedValue,
                        onChanged: (v) => setState(() => _selectedValue = v),
                      ),
                    ),
                    Text(
                      capitalizeFirstLetter(item),
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorsConstant.primaryGreyText,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Divider(color: ColorsConstant.grey50, height: 0),

          const SizedBox(height: 10),
          Row(
            children: [
              // CANCEL BUTTON
              Expanded(
                child: CustomButton(
                  btnText: 'Cancel',
                  onTap: () {},
                  height: 54,
                  bgColor: ColorsConstant.black50,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomButton(
                  btnText: 'Ok',
                  height: 54,
                  onTap: _selectedValue != null
                      ? () {
                          widget.onSelect(_selectedValue);
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                      : null,
                  bgColor: ColorsConstant.darkerPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
