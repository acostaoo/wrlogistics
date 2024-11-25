import 'package:flutter/material.dart';
import 'package:repositories/repositories.dart';

class BuildPaymentMethodRadioButtons extends StatefulWidget {
  final PaymentMethod selectedPaymentMethod;
  final void Function(PaymentMethod?)? onChanged;

  const BuildPaymentMethodRadioButtons({super.key, 
    this.selectedPaymentMethod = PaymentMethod.cash,
    this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BuildPaymentMethodRadioButtonsState createState() => _BuildPaymentMethodRadioButtonsState();
}

class _BuildPaymentMethodRadioButtonsState extends State<BuildPaymentMethodRadioButtons> {
  late PaymentMethod selectedPaymentMethod;

  @override
  void initState() {
    super.initState();
    selectedPaymentMethod = widget.selectedPaymentMethod;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Método de Pago',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              const Text('Efectivo'),
              Radio<PaymentMethod>(
                value: PaymentMethod.cash,
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
              const Text('Webpay'),
              Radio<PaymentMethod>(
                value: PaymentMethod.webpay, 
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
              const Text('Tarjeta en sitio'),
              Radio<PaymentMethod>(
                value: PaymentMethod.cardOnSite,
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
