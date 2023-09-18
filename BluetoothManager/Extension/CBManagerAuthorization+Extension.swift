import CoreBluetooth

extension CBManagerAuthorization {
  var name: String {
    switch self {
    case .notDetermined:
      return "Not determined"
    case .restricted:
      return "Restricted"
    case .denied:
      return "Denied"
    case .allowedAlways:
      return "Allowed always"
    @unknown default:
      return ""
    }
  }
}
