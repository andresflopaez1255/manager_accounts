String formatDateString(String? dateString) {
  if (dateString != null) {
    try {
      // Parsear la fecha en formato MM/dd/yyyy
      final parts = dateString.split('/');
      if (parts.length == 3) {
        final month = int.parse(parts[0]);
        final day = int.parse(parts[1]);
        final year = int.parse(parts[2]);

        // Crear un objeto DateTime con los valores correctos
        final parsedDate = DateTime(year, month, day);

        // Formatear la fecha a yyyy-MM-dd
        return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
      }
    } catch (e) {
      // Manejar errores de formato
      return "Invalid date format";
    }
  }
  // Retornar la fecha actual si no se proporciona una fecha
  final now = DateTime.now();
  return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
}