import 'dart:io';
import 'transaccion.dart';

void main() {
  double monto = 0.0;
  String categoria = "";
  String concepto = "";
  String tipo = "";

  double saldoActual = 0.0;
  double ingresos = 0.0;
  double gastos = 0.0;

  Transaccion transaccion = Transaccion(monto, concepto, categoria, tipo);

  bool salir = false;
  print("\n!!! Sistema de gestion de finanzas personales !!!");
  while (!salir) {
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

          if (tipo.toLowerCase() == "ingreso") {
            transaccion.agregarTransaccion(
                Transaccion(monto, concepto, categoria, tipo));
            saldoActual += monto;
            ingresos += monto;
            print("\nTransaccion Exitosa!\n");
          }    
          else if (tipo.toLowerCase() == "retiro") {
            if (monto > saldoActual) {
              print("\nNo hay saldo suficiente para el retiro.\n");
            } else {
              saldoActual -= monto;
              gastos += monto;
              transaccion
                  .agregarRetiro(Transaccion(monto, concepto, categoria, tipo));
              print(
                  "\nSe retiró \$$monto exitosamente con un Concepto de: $concepto\n");
            }
          }
           else {
            print(
                "Tipo de transacción desconocida, debe seleccionar entre ingreso o retiro");
          }
        } catch (e) {
          print("\nError: Ingrese un monto valido!\n");
        }
        break;

      case "2":
        if (transaccion.transacciones.isEmpty && transaccion.retiros.isEmpty) {
          print("\nNo hay transacciones realizadas en su cuenta.\n");
        }
         else {
          print(
              "\n============ Transacciones relaizadas (Ingresos) ==============");

          for (Transaccion transaccion in transaccion.transacciones) {
            print(
                "Ingreso de \$${transaccion.monto} con categoría de ${transaccion.categoria} y un concepto de ${transaccion.concepto}");
          }

          print(
              "\n============ Transacciones relaizadas (Retiros) ==============");
          if (transaccion.retiros.isEmpty) {
            print("No hay retiros en su cuenta. Sigue ahorrando!");
          }
           else {
            for (Transaccion retiro in transaccion.retiros) {
              print(
                  "Retiro de \$${retiro.monto}, con categoría de ${retiro.categoria} y un concepto de ${retiro.concepto}");
            }
          }

          print("\nIngresos totales: \$$ingresos");
          print("Gastos totales: \$$gastos");
          print("Saldo actual: \$$saldoActual\n");
          print("====================================\n");
        }
        break;

      case "3":
        break;

      case "4":
        print("Hasta Luego!");
        salir = true;
        break;

      default:
        print("\nOpcion invalida, ingrese una opcion del menú\n");
        break;
    }
  }
}
