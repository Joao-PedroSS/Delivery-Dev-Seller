import 'dart:convert';

import 'package:delivery_dev_seller/modules/dashboard/data/services/geocoding_service.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/viewmodels/solitations_viewmodel.dart';
import 'package:delivery_dev_seller/modules/dashboard/ui/widgets/map_picker_widget.dart';
import 'package:delivery_dev_seller/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class OrderFormModal extends StatefulWidget {
  const OrderFormModal({super.key});

  @override
  State<OrderFormModal> createState() => _OrderFormModalState();
}

class _OrderFormModalState extends State<OrderFormModal> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _locationController;

  final _viewmodel = Modular.get<SolitationsViewmodel>();

  double? _manualLat;
  double? _manualLon;

  @override
  void initState() {
    super.initState();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    try {
      final double customerLat;
      final double customerLon;
      final String address;

      if ([_manualLat, _manualLon].every((value) => value == null)) {
        address = _locationController.text.trim();

        final fullAddress = '$address, Santa Cruz do Sul - RS';
        final locationData =
            await GeocodingService().getCoordinatesFromAddress(fullAddress);

        customerLat = locationData!.lat;
        customerLon = locationData.lon;
      } else {
        customerLat = _manualLat!;
        customerLon = _manualLon!;

        final reverseAddress =
            await _getAddressFromCoordinates(customerLat, customerLon);
        address = reverseAddress ?? _locationController.text.trim();
      }

      await _viewmodel.createSolitation(
        customerLat: customerLat,
        customerLon: customerLon,
        address: address.isNotEmpty ? address : 'Local nao informado',
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      _showMsg('Erro ao salvar solicitacao: $e', Colors.redAccent);
    }
  }

  void _showMsg(String msg, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: color),
    );
  }

  Future<String?> _getAddressFromCoordinates(double lat, double lon) async {
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$lat&lon=$lon',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];

        final road = address['road'] ?? '';
        final houseNumber = address['house_number'] ?? '';
        final suburb = address['suburb'] ?? address['neighbourhood'] ?? '';

        final parts = [road, houseNumber, suburb]
            .where((part) => part.toString().trim().isNotEmpty)
            .map((part) => part.toString().trim())
            .toList();

        if (parts.isEmpty) return null;
        return parts.join(', ');
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  Future<void> _openMap() async {
    const startLat = -23.550520;
    const startLon = -46.633308;

    final LatLng? result = await showDialog<LatLng>(
      context: context,
      builder: (context) => const MapPickerDialog(
        initialLat: startLat,
        initialLon: startLon,
      ),
    );

    if (result != null) {
      setState(() {
        _manualLat = result.latitude;
        _manualLon = result.longitude;
      });

      _showMsg('Buscando endereco...', Colors.blue);
      final addressLabel =
          await _getAddressFromCoordinates(result.latitude, result.longitude);

      if (addressLabel != null) {
        setState(() {
          _locationController.text = addressLabel;
        });
        _showMsg('Endereco preenchido!', Colors.green);
      } else {
        _showMsg('Coordenadas salvas! Preencha o endereco.', Colors.green);
      }
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
                    onPressed: _openMap,
                    child: const Text(
                      'Usar mapa ->',
                      style: TextStyle(color: AppColors.surface, fontSize: 13),
                    ),
                  ),
                ),
                _ModalTextField(
                  controller: _locationController,
                  labelText: 'Local de entrega*',
                  hintText: 'ex: Rua Prudente, 518, Centro',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o local de entrega';
                    }
                    return null;
                  },
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

  const _ModalTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(color: AppColors.text, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: AppColors.text.withValues(alpha: 0.6)),
            fillColor: AppColors.secundary,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
