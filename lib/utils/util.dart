int parseMajorMinorValue(String? text) {
  try {
    int intValue = int.parse(text ?? "0");
    return intValue;
  } catch (e) {
    return 0;
  }
}
