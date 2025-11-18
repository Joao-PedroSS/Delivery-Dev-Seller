import 'package:delivery_dev_seller/modules/dashboard/data/services/geocoding_service.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/viewmodels/solitations_viewmodel.dart';
import 'package:delivery_dev_seller/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class OrderFormModal extends StatefulWidget {

  const OrderFormModal({super.key});

  @override
  State<OrderFormModal> createState() => _OrderFormModalState();
}

class _OrderFormModalState extends State<OrderFormModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _locationController;
  late TextEditingController _numberController;
  late TextEditingController _complementController;

  final _viewmodel = Modular.get<SolitationsViewmodel>();

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
    _numberController = TextEditingController();
    _complementController = TextEditingController();
  }

  @override
  void dispose() {
    _locationController.dispose();
    _numberController.dispose();
    _complementController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    try {
      final street = _locationController.text;
      final number = _numberController.text;
      final complement = _complementController.text;
      
      final String fullAddress = "$street, $number, Santa Cruz do Sul - RS";

      final locationData = await GeocodingService().getCoordinatesFromAddress(fullAddress);

      final double customerLat = locationData!.lat;
      final double customerLon = locationData.lon;

      await _viewmodel.createSolitation(
        customerLat: customerLat,
        customerLon: customerLon,
        customerAddressLabel: complement.isNotEmpty ? complement : null,
        customerAddressStreet: "$street, $number"
      );
      
      if (mounted) {
        Navigator.of(context).pop();
      }

    } catch (e) {
      print("Erro no _onSave (geocoding ou viewmodel): $e, ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Center(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Usar mapa →',
                      style: TextStyle(color: AppColors.surface, fontSize: 13),
                    ),
                  ),
                ),
                _ModalTextField(
                  controller: _locationController,
                  labelText: 'Local de entrega*',
                  hintText: 'ex: Rua Prudente',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o local de entrega';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _ModalTextField(
                  controller: _numberController,
                  labelText: 'Número*',
                  hintText: 'ex: 518',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o número';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _ModalTextField(
                  controller: _complementController,
                  labelText: 'Complemento',
                  hintText: 'ex: apto. 2',
                  isRequired: false,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _viewmodel.isLoadingModal ? () {} : _onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Salvar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isRequired;

  const _ModalTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.isRequired = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(color: AppColors.text, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: isRequired ? validator : null,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.text.withOpacity(0.6)),
            fillColor: AppColors.secundary,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}