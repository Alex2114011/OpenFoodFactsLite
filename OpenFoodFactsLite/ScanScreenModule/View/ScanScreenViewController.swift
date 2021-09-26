//
//  ScanViewController.swift
//  OpenFoodFactsLite
//
//  Created by Alex on 22.09.2021.
//

import UIKit
import AVFoundation

class ScanScreenViewController: UIViewController {

    var presenter: ScanViewPresenterProtocol?
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var metadataOutput = AVCaptureMetadataOutput()
    var backCamera: AVCaptureDevice!
    var torch: AVCaptureDevice!
    var torchInput: AVCaptureDeviceInput!
    var backInput: AVCaptureInput!
    var rootStackView = UIStackView()
    var embedStackView = UIStackView()
    var alertLabel = UILabel()
    var flashButton = UIButton()

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "Сканер", image: UIImage(named: "barcode"), tag: 1)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupRootStackView()
        setupEmbedStackView()
        setupAlertLabel()
        setupFlashButton()
        addSubviewRootStackView()
        addSubviewEmbedStackView()
        setupAndStartCaptureSession()
        setTextAlertScan()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if captureSession?.isRunning == false {
            captureSession.startRunning()
            setupAlertLabel()
            setTextAlertScan()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }

    @objc func flashButtonPressed(sender: UIButton) {
        if sender.isSelected {
            switchTorch(isOn: false)
        } else {
            switchTorch(isOn: true)
        }
        sender.isSelected = !sender.isSelected
    }

    func switchTorch(isOn: Bool) {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else {return}
            self.torch = device
            try? torch.lockForConfiguration()

            switch isOn {
            case true:
                torch.torchMode = .on
                self.flashButton.setImage(UIImage(named: "flash_on"), for: .normal)
            case false:
                torch.torchMode = .off
                self.flashButton.setImage(UIImage(named: "flash_off"), for: .normal)
            }
            torch.unlockForConfiguration()
    }
}

extension ScanScreenViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {

        if let metadataObjects = metadataObjects.first {
            guard let readableObject = metadataObjects as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            guard let presenter = presenter else { return }
            if !presenter.isDetailPresented {
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                presenter.goToDetailModal(barCode: stringValue)
                setupAlertLabel()
                setTextAlertScan()
            }
        }
    }
}

extension ScanScreenViewController: ScanViewProtocol {

}
