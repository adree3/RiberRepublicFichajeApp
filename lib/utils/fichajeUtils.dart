import 'package:riber_republic_fichaje_app/model/fichaje.dart';

class FichajeUtils {
  /// Filtra los fichajes de la lista que correspondan al día actual.
  static List<Fichaje> filtradosDeHoy(List<Fichaje> fichajes) {
    final ahora = DateTime.now();
    return fichajes.where((f) {
      final entrada = f.fechaHoraEntrada;
      if (entrada == null) return false;
      return entrada.year  == ahora.year && entrada.month == ahora.month && entrada.day   == ahora.day;

    }).toList();
  }
  /// Calcula el total de los fichajes de hoy cuya horaSalida sea distinto a null
  static Duration calcularFichajesHoy (List<Fichaje> fichajesFiltrados){
    return fichajesFiltrados.fold(Duration.zero, (sum, f) {
      if (f.fechaHoraSalida != null) {
        return sum + f.fechaHoraSalida!.difference(f.fechaHoraEntrada!);
      }
      return sum;
    });
  }

  /// Suma las horas totales por dia
  static Map<DateTime, Duration> sumarHorasPorDia(List<Fichaje> fichajes) {
    final Map<DateTime, Duration> totales = {};
    for (final f in fichajes) {
      if (f.fechaHoraEntrada != null && f.fechaHoraSalida != null) {
        final entrada = f.fechaHoraEntrada!;
        final salida  = f.fechaHoraSalida!;
        final dia = DateTime(entrada.year, entrada.month, entrada.day);
        final dur = salida.difference(entrada);
        totales.update(dia, (ant) => ant + dur, ifAbsent: () => dur);
      }
    }
    return totales;
  }

}