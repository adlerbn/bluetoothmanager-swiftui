import CoreBluetooth

protocol BluetoothManager: ObservableObject {
  
  var deviceList: Set<DeviceModel> { get set }
  
  var currentState: CBManagerState { get set }
  
  var authorization: CBManagerAuthorization { get set }
  
  var isScanning: Bool { get set }
  
  func stopScan()
  
  func startScan()

  func connect(_ deviceModel: DeviceModel, options: [String : Any]?)

  func disconnect(_ deviceModel: DeviceModel)
}
