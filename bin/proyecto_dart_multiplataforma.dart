import 'dart:io';
import 'transaccion.dart';

void main() {
  double monto = 0.0;
  String categoria = "";
  String concepto = "";
  String tipo = "";

  Transaccion transaccion = Transaccion(monto, concepto, categoria, tipo);

  bool salir = false;

  while (!salir) {
    print("");
    print("!!! Sistema de gestion de finanzas personales !!!");
    print('1.- Registrar Transacción');
    print('2.- Ver Saldo y Estado Financiero');
    print('3.- Establecer Metas y Presupuestos');
    print('4.- Salir');
    stdout.write("Ingrese el numero de la opcion a utilizar: ");
    String opcion = stdin.readLineSync() ?? '';

    switch (opcion) {
      case "1":
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
          stdout.write("Transaccion Exitosa!");
        } catch (e) {
          print("Error: Ingrese un monto valido!");
        }
        break;

      case "2":
        //generar resumen;
        break;

      case "3":
        break;

      case "4":
        print("Hasta Luego");
        salir = true;
        break;

      default:
        print("Opcion invalida, ingrese una opcion del menú");
        break;
    }
  }
}
