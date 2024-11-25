
import 'package:WrLogistics/app/app.dart';
import 'package:WrLogistics/app/phone/phone.dart';
import 'package:WrLogistics/app/phone/widgets/text_animation.dart';
import 'package:WrLogistics/assets/palette.dart';
import 'package:WrLogistics/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PhoneInputPageForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return BlocListener<PhoneInputCubit, PhoneInputState>(
      listener: (context, state) {
        if(state.status.isSuccess){
          Navigator.of(context).pop();
        }else if (state.status.isFailure){
          ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text('Algo salió mal.'))
          );
        }
      },child:Padding(
          padding: const EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MaterializeTextAnimation(),
              const SizedBox(height: 40),
              _PhoneInputWidget(),
              const SizedBox(height: 16),
               _SubmitPhoneButton()
            ],
          ),
        )
    );
      }
  }


class _PhoneInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      key: const Key('phoneInputPage_phoneInput_textField'),
      keyboardType: TextInputType.phone,
      onChanged: (phoneNumber)=>
        context.read<PhoneInputCubit>().phoneNumberChanged(phoneNumber),
      decoration: InputDecoration(
        labelText: 'Número de teléfono',
        hintText: 'Ingresa tu número de teléfono',
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(8.0),
        ),
        prefix:const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 8),
            Text(
              '+56',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}

class _SubmitPhoneButton extends StatelessWidget{
  @override
  Widget build(BuildContext context){
        final String appUserId = context.select((AppBloc bloc) => bloc.state.user.id);
    return BlocBuilder<PhoneInputCubit,PhoneInputState>(

      builder: (context,state){
        return state.status.isInProgress
        ?const CircularProgressIndicator()
        :ElevatedButton(
                key:const Key('phoneInput_continue_button'),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                backgroundColor: AppColors.secondary,),
                onPressed: state.isValid? () {
                  context.read<PhoneInputCubit>().submitPhoneNumber(appUserId).then((_){Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));});
                }:null,
                child:const Text('Continuar',style: TextStyle(color: Colors.white),),
              );
    

      });
  }
}
