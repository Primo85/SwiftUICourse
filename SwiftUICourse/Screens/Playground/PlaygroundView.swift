import SwiftUI
//import Combine

extension Data {
    var hex: String {
        self.map { String(format: "%02hhX", $0) }.joined()
    }
    var bytesArr: [UInt8] {
        self.map { $0 }
    }
}

struct PlaygroundView: View {
    @StateObject var viewModel = PlaygroundViewModel()
    
    let b64 =
//    "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsyF4KwTZBKHE+4NKftRbfy4Vo2G9igdD4GbE+wmYjouLqqACPwXLZIROvKnLrvDuvftyiwnjXFu1p1Dc8taDtEdFIDnbzGpBd2IoKHUijb+KPGKvczYpXXpISpO/0u+jOYRnPkBbCNnnxBvA+d0TSTe01UctrfN5TCxonX4E/YZMrxd9lrn5mwMGOC17ZEQIcfwPvxDl5g0LbOBFzV62O4Spt0610ui6T5rFzxuFXD5W108/GMrqtti8yo2b4ouHC2fAcM+Gfel5n136H6/Q0wJd+7oO569al1TZL8YMk37P5Uxp2TxfjXFi/61ARGarp1eEtrWTbfGhFmaZicym0wIDAQAB"
    "AQAB"
    
    @State var counter = Counter()
    
    @State var name: String = "Anna"
    
    init() {
        print("init view")
        print(b64)
        let data = Data(base64Encoded: b64)!
        print(data.hex)
        print(data.bytesArr)
        
        print(1)
        for x in 0...23 {
            var a = 1
            for _ in 0...x {
                a *= 2
            }
            print(a)
            if x == 6 { print("_") }
            if x == 14 { print("_") }
        }
    }
    
    var body: some View {
//        ZStack {
//            viewModel.backGr
//                .ignoresSafeArea()
//            Color.yellow
//            
//            VStack(spacing: 16) {
//                Text("refresh counter: \(counter.value)")
//                Text("refresh counter: \(counter.value)")
//                Text("refresh counter: \(counter.value)")
//                Text("timer: \(viewModel.timer)")
//                TextField("name", text: $name)
//                Button("Click") {
//                    viewModel.backGr = Color.black
//                }
//                .foregroundColor(.black)
//                Button("Click") {
//                    viewModel.backGr = Color.blue
//                }
//                Button("Click") {
//                    viewModel.backGr = Color.red
//                }
//                .foregroundColor(.red)
//                Button("RESET") {
//                    counter = Counter()
//                }
//            }
//            .font(.title)
//        }
        Text("")
    }
}

#Preview {
    PlaygroundView()
}
