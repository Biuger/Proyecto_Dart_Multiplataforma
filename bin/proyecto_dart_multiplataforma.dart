import 'dart:io';
import 'transaccion.dart';

void main() {
  double monto = 0.0;
  String categoria = "";
  String concepto = "";
  String tipo = "";

  Transaccion transaccion = Transaccion(monto, concepto, categoria, tipo);

  try {
    stdout.write('Ingrese el monto: ');
    monto = double.parse(stdin.readLineSync()!);

    stdout.write('Ingrese el categoria: ');
    categoria = stdin.readLineSync()!;

    stdout.write('Ingrese el concepto: ');
    concepto = stdin.readLineSync()!;

    stdout.write('Ingrese el tipo (Ingreso o Retiro): ');
    tipo = stdin.readLineSync()!;

    transaccion.agregarTransaccion(transaccion);
    stdout.write("Registro Exitoso!");
  } catch (e) {
    print("Error: Ingrese un monto valido!");
  }
}
