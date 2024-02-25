class Transaccion {
  double monto;
  String tipo;
  String categoria;
  String concepto;

  Transaccion(this.monto, this.concepto, this.categoria, this.tipo);

  List<Transaccion> transacciones = [];

  void agregarTransaccion(Transaccion transaccion) {
    transacciones.add(transaccion);
  }
}
