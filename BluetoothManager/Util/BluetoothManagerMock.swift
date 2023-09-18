import CoreBluetooth

class BluetoothManagerMock: BluetoothManager {
  @Published var deviceList: Set<DeviceModel> = []
  
  @Published var currentState: CBManagerState = .unknown
  
  @Published var authorization: CBManagerAuthorization = .restricted
  
  @Published var isScanning: Bool = false
  
  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
      guard let self = self else { return }
      
      self.currentState = .poweredOn
      self.authorization = .notDetermined
    }
  }
  
  func stopScan() {
    isScanning = false
  }
  
  func startScan() {
    isScanning = true
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
      guard let self = self else { return }
      
      self.deviceList = DeviceModel.dummy
    }
  }
  
  func connect(_ deviceModel: DeviceModel, options: [String : Any]?) {}
  
  func disconnect(_ deviceModel: DeviceModel) {}
}
