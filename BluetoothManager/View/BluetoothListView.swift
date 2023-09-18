import SwiftUI

struct BluetoothListView<BM>: View where BM: BluetoothManager  {
  
  @EnvironmentObject private var bluetoothManager: BM
  
  var body: some View {
    NavigationStack {
      stateLabel
      
      deviceList
        .navigationTitle("Device list")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            if bluetoothManager.isScanning {
              stopScanButton
            } else {
              scanButton
            }
          }
        }
    }
    .animation(.default, value: bluetoothManager.isScanning)
  }
  
  @ViewBuilder
  var stateLabel: some View {
    VStack(spacing: 8) {
      HStack {
        Text("Authorization")
        
        Spacer()
        
        Text(bluetoothManager.authorization.name)
          .font(.callout)
          .foregroundColor(.secondary)
      }
      
      Divider()
      
      HStack {
        Text("State")
        
        Spacer()
        
        Text(bluetoothManager.currentState.name)
          .font(.callout)
          .foregroundColor(.secondary)
      }
    }
    .padding()
    .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
    .padding(.horizontal)
  }
  
  @ViewBuilder
  var deviceList: some View {
    List {
      ForEach(Array(bluetoothManager.deviceList)) { device in
        VStack(alignment: .leading, spacing: 8) {
          Text(device.name)
            .bold()
          
          Text(device.id.description)
            .font(.caption)
            .foregroundColor(.secondary)
        }
      }
    }
  }
  
  @ViewBuilder
  var scanButton: some View {
    Button(action: bluetoothManager.startScan) {
      HStack(spacing: 8) {
        Text("Scan")
        
        Image(systemName: "magnifyingglass")
          .imageScale(.small)
      }
    }
  }
  
  @ViewBuilder
  var stopScanButton: some View {
    Button(action: bluetoothManager.stopScan) {
      HStack(spacing: 8) {
        Text("Stop")
        
        ProgressView()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BluetoothListView<BluetoothManagerMock>()
      .environmentObject(BluetoothManagerMock())
  }
}
