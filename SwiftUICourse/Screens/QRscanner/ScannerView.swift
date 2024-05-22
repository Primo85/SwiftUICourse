//
//  ScannerView.swift
//  SwiftUICourse
//
//  Created by pbiskup on 31/10/2023.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding private(set) var code: String
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(delegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }

    final class Coordinator: NSObject, ScannerVCDelegate {
        
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFindQR(code: String) {
            scannerView.code = code
        }
        func getError(error: String) {
            DispatchQueue.main.async { [weak self] in
                self?.scannerView.code = error
            }
        }
    }
}


struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView(code: .constant(""))
    }
}
