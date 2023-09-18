import CoreBluetooth

extension CBManagerState {
  var name: String {
    switch self {
    case .unknown:
      return "Unknown"
    case .resetting:
      return "Resetting"
    case .unsupported:
      return "Unsupported"
    case .unauthorized:
      return "Unauthorized"
    case .poweredOff:
      return "Powered off"
    case .poweredOn:
      return "Powered on"
    @unknown default:
      return ""
    }
  }
}
