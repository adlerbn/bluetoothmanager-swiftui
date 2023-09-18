import CoreBluetooth

struct DeviceModel: Hashable, Identifiable {
  var id: UUID { peripheral?.identifier ?? UUID() }
  var peripheral: CBPeripheral?
  var name: String
  
  init(
    peripheral: CBPeripheral
  ) {
    self.peripheral = peripheral
    self.name = peripheral.name ?? "Unknown"
  }
  
  init(
    name: String
  ) {
    self.name = name
  }
}

extension DeviceModel {
  static var dummy: Set<Self> {
    return [
      DeviceModel(name: "Device 1"),
      DeviceModel(name: "Device 2"),
      DeviceModel(name: "Device 3"),
      DeviceModel(name: "Device 4"),
      DeviceModel(name: "Device 5"),
    ]
  }
}
