import UIKit
import AVFoundation

protocol ScannerVCDelegate: AnyObject {
    func didFindQR(code: String)
    func getError(error: String)
}

final class ScannerVC: UIViewController {
    
    private let captureSession = AVCaptureSession()
    private var previewLAyer: AVCaptureVideoPreviewLayer?
    private weak var delegate: ScannerVCDelegate?
    
    init(delegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLAyer?.frame = view.layer.bounds
    }
    
    private func setupCameraSession() {
        guard let device = AVCaptureDevice.default(for: .video) else { delegate?.getError(error: "no device"); return }
        let videoInput: AVCaptureDeviceInput
        do {
            try videoInput = AVCaptureDeviceInput(device: device)
        } catch {
            delegate?.getError(error: "some error")
            return
        }
        guard captureSession.canAddInput(videoInput) else { delegate?.getError(error: "cant add"); return }
        captureSession.addInput(videoInput)
        let dataOutput = AVCaptureMetadataOutput()
        guard captureSession.canAddOutput(dataOutput) else { delegate?.getError(error: "cant add"); return }
        captureSession.addOutput(dataOutput)
        dataOutput.setMetadataObjectsDelegate(self, queue: .main)
        dataOutput.metadataObjectTypes = [.qr, .ean8, .ean13]
        previewLAyer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLAyer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLAyer!)
        captureSession.startRunning()
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
        let code = object.stringValue else { return }
        captureSession.stopRunning()
        delegate?.didFindQR(code: code)
    }
}
