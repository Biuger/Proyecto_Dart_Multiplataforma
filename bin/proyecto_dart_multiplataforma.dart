import 'dart:io';
import 'transaccion.dart';

void main() {
  double monto = 0.0;
  String categoria = "";
  String concepto = "";
  String tipo = "";

  double montoMeta = 0.0;
  String conceptoMeta = "";
  double presupuestoMeta = 0.0;
  List<double> metasCompletadas = [];
  List<double> presupuestoMetas = [];
  List<double> metas = [];
  List<String> conceptosMetas = [];

  double saldoActual = 0.0;
  double ingresos = 0.0;
  double gastos = 0.0;

  Transaccion transaccion = Transaccion(monto, concepto, categoria, tipo);

  bool salir = false;
  print("\n!!! Sistema de gestion de finanzas personales !!!");
  while (!salir) {
    print('\n1.- Registrar Transacción');
    print('2.- Ver Saldo y Estado Financiero');
    print('3.- Establecer Metas');
    print('4.- Ver historial de metas');
    print('5.- Salir');
    stdout.write("Ingrese el numero de la opcion a utilizar: ");
    String opcion = stdin.readLineSync() ?? '';

    switch (opcion) {
      case "1":
        try {
          print("\n============ Nueva Transacción ==============");
          stdout.write('Ingrese el monto de la transacción: ');
          monto = double.parse(stdin.readLineSync()!);

          while (monto <= 0) {
            print("\nError: El monto no puede ser negativo o cero.");
            stdout.write('Ingrese el monto de la transacción: ');
            monto = double.parse(stdin.readLineSync()!);
          }

          stdout.write('Ingrese el categoria: ');
          categoria = stdin.readLineSync()!;

          stdout.write('Ingrese el concepto: ');
          concepto = stdin.readLineSync()!;

          stdout.write('Ingrese el tipo (Ingreso o Retiro): ');
          tipo = stdin.readLineSync()!;

          if (tipo.toLowerCase() == "ingreso") {
            transaccion.agregarTransaccion(Transaccion(
              monto,
              concepto,
              categoria,
              tipo,
            ));
            saldoActual += monto;
            ingresos += monto;

            print("\nTransaccion Exitosa!\n");
          } else if (tipo.toLowerCase() == "retiro") {
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
          } else {
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
        } else {
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
          } else {
            for (Transaccion retiro in transaccion.retiros) {
              print(
                  "Retiro de \$${retiro.monto}, con categoría de ${retiro.categoria} y un concepto de ${retiro.concepto}");
            }
          }

          print("\nIngresos totales: \$$ingresos");
          print("Gastos totales: \$$gastos");
          print("Saldo actual: \$$saldoActual");
          print("====================================\n");
        }
        break;

      case "3":
        print("\n============ Establecer Meta Financiera ==============");
  bool validar;

  do {
    try {
      stdout.write('Ingresa el costo total de la meta: ');
      double montoMeta = double.parse(stdin.readLineSync()!);

      if (montoMeta > 0) {
        stdout.write('Ingresa el concepto de la meta: ');
        String conceptoMeta = stdin.readLineSync()!;
        stdout.write('Ingresa el presupuesto actual para la meta: ');
        double presupuestoMeta = double.parse(stdin.readLineSync()!);

        conceptosMetas.add(conceptoMeta);
        metas.add(montoMeta);
        metasCompletadas.add(presupuestoMeta);
        presupuestoMetas.add(presupuestoMeta);
        print("\nMeta establecida con éxito!\n");
        validar = true;
      } else {
        print("\nError: El monto de la meta debe ser mayor a 0. Intenta nuevamente.\n");
        validar = false;
      }
    } catch (e) {
      print("\nError: Ingresa un número entero válido. Intenta nuevamente.\n");
      validar = false;
    }
  } while (!validar);
        break;

      case "4":
        print(
            "\n================ HISTORIAL DE METAS Y PRESUPUESTOS =================");
        for (int i = 0; i < metas.length; i++) {
          if (metasCompletadas[i] >= metas[i] &&
              (presupuestoMetas[i] + saldoActual) < metas[i]) {
            print(
                "Meta establecida: \$${metas[i]} con presupuesto de: \$${presupuestoMetas[i]} y un saldo bancario de \$${saldoActual} ( Felicidades ya completaste esta meta! )");
          } else if ((presupuestoMetas[i] + saldoActual) >= metas[i]) {
            print(
                "Meta establecida: \$${metas[i]} con presupuesto de: \$${presupuestoMetas[i]} y un saldo bancario de \$${saldoActual} ( Felicidades ya completaste esta meta! )");
          } else {
            print(
                "Meta establecida: \$${metas[i]} con presupuesto de: \$${presupuestoMetas[i]} y un saldo bancario de \$${saldoActual} ( Aún te faltan \$${(metas[i] - presupuestoMetas[i] - saldoActual)} )");
          }
        }
        break;

      case "5":
        print("Hasta Luego!");
        salir = true;
        break;

      default:
        print("\nOpcion invalida, ingrese una opcion del menú\n");
        break;
    }
  }
}
