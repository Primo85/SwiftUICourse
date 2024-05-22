import SwiftUI

struct QRscannerView: View { // TODO: handle some console logs
    @State private var code: String = ""
    
    var body: some View {
        VStack {
            ScannerView(code: $code)
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .padding()
            Spacer().frame(height: 60)
            Label("sss", systemImage: "qrcode.viewfinder")
                .font(.title)
            Text(code.isEmpty ? "not scanned yet" : code)
                .bold()
                .font(.largeTitle)
                .foregroundColor(code.isEmpty ? .red : .green)
                .padding()
        }
        .navigationTitle("QR scanner")
    }
}

struct QRscannerView_Previews: PreviewProvider {
    static var previews: some View {
        QRscannerView()
    }
}
