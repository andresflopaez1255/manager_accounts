String formatDateString(String? dateString) {
  if (dateString != null) {
    List<String> parts = dateString.split('/');
    // Reordenar los componentes para formar "yyyy-MM-dd"
    return "${parts[2]}-${parts[1]}-${parts[0]}";
  }
  return DateTime.now().toString();
}
