class Transaccion {
  double monto;
  String tipo;
  String categoria;
  String concepto;
  Meta? meta;

  Transaccion(this.monto, this.concepto, this.categoria, this.tipo,
      [this.meta]);

  List<Transaccion> transacciones = [];
  List<Transaccion> retiros = [];

  void agregarTransaccion(Transaccion transaccion) {
    transacciones.add(transaccion);
  }

  void agregarRetiro(Transaccion transaccion) {
    retiros.add(transaccion);
  }

  void evaluarMetaAlcanzada(double saldoActual) {
    if (meta != null && meta!.metaAlcanzada(saldoActual)) {
      print("\n¡Felicidades! Has alcanzado tu meta: ${meta!.concepto}\n");
    }
  }
}

class Meta {
  double monto;
  String concepto;
  Meta(this.monto, this.concepto);

  List<Meta> metas = [];

  void agregarMeta(Meta meta) {
    metas.add(meta);
  }

  bool metaAlcanzada(double saldoActual) {
    return saldoActual >= monto;
  }
}
