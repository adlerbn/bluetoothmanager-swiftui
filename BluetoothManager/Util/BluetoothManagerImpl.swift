import CoreBluetooth
import Combine

class BluetoothManagerImpl: NSObject {
  
  private var queue = DispatchQueue(label: "bluetooth-queue", target: .main)
  private var manager: CBCentralManager?
  
  @Published var deviceList: Set<DeviceModel> = []
  @Published var currentState: CBManagerState = .unknown
  @Published var authorization: CBManagerAuthorization = .restricted
  @Published var isScanning: Bool = false
  
  override init() {
    super.init()
    
    self.manager = CBCentralManager(delegate: self, queue: queue)
  }
}

//MARK: Function Handler
extension BluetoothManagerImpl: BluetoothManager {
  func stopScan() {
    isScanning = false
    
    if let manager {
      manager.stopScan()
    }
  }
  
  func startScan() {
    let services: Array<CBUUID> = []
    let options: [String: Any] = [:]
    
    isScanning = true
    
    if let manager {
      manager.scanForPeripherals(
        withServices: services,
        options: options
      )
    }
  }
  
  func connect(_ deviceModel: DeviceModel, options: [String : Any]?) {
    if
      let manager,
      let peripheral = deviceModel.peripheral
    {
      manager.connect(peripheral, options: options)
    }
  }
  
  func disconnect(_ deviceModel: DeviceModel) {
    if
      let manager,
      let peripheral = deviceModel.peripheral
    {
      manager.cancelPeripheralConnection(peripheral)
    }
  }
}

//MARK: CBCentralManagerDelegate
extension BluetoothManagerImpl: CBCentralManagerDelegate {
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    currentState = central.state
  }
  
  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    print("Did connect")
  }
  
  func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
    print("Will restore state")
  }
  
  func centralManager(_ central: CBCentralManager, didUpdateANCSAuthorizationFor peripheral: CBPeripheral) {
    print("Did update ANCS authorization for")
  }
  
  func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
    print("Did fail to connect")
  }
  
  func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    print("Did disconnect peripheral")
  }
  
  func centralManager(_ central: CBCentralManager, connectionEventDidOccur event: CBConnectionEvent, for peripheral: CBPeripheral) {
    print("Connection event did occur")
  }
  
  func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
    debugPrint(peripheral.debugDescription)
    
    let deviceModel = DeviceModel(peripheral: peripheral)
    deviceList.insert(deviceModel)
  }
}
