import SwiftUI

@main
struct BluetoothManagerApp: App {
  
  @StateObject private var manager = BluetoothManagerImpl()
  
  var body: some Scene {
    WindowGroup {
      BluetoothListView<BluetoothManagerImpl>()
        .environmentObject(manager)
    }
  }
}
