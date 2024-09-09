//
//  ScanAreaViewController.swift
//  rtbbamap_sample
//
//  Created by Rizal Hilman on 09/09/24.
//

import GLKit

enum ScanStatus {
    case stopped
    case scanning
    case paused
}

class ScanAreaViewController: GLKViewController {
    
    @IBOutlet weak var scanButton: UIView!
    @IBOutlet weak var scanButtonOutline: UIView!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var pauseAndResumeButtonOutline: UIView!
    @IBOutlet weak var pauseAndResumeButtonIcon: UIImageView!
    
    private var scanningStatus: ScanStatus = .stopped
    private var isRecording: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        updateScanningIndicators()
    }
    
    private func setupViews() {
        // Setup scan button outline
        setupCircularOutlineView(view: scanButtonOutline)
        setupCircularButton(scanButton)
        
        // Add tap gesture for scan button
        addTapGesture(to: scanButtonOutline, action: #selector(handleRecord))
        
        // Setup label status
        labelStatus.backgroundColor = .green
        labelStatus.layer.cornerRadius = 15
        labelStatus.clipsToBounds = true
        labelStatus.text = "READY TO SCAN"
        
        // Setup pause/resume button outline
        setupCircularOutlineView(view: pauseAndResumeButtonOutline)
        
        // Add tap gesture for pause/resume button
        addTapGesture(to: pauseAndResumeButtonOutline, action: #selector(handlePauseResume))
        
        // Setup pause/resume button icon
        pauseAndResumeButtonIcon.tintColor = .myStrokeColor
    }
    
    private func setupCircularOutlineView(view: UIView) {
        let minDimension = min(view.frame.size.width, view.frame.size.height)
        view.layer.cornerRadius = minDimension / 2
        view.layer.borderColor = UIColor.myStrokeColor.cgColor
        view.layer.borderWidth = 2
    }
    
    private func setupCircularButton(_ button: UIView) {
        let minDimension = min(button.frame.size.width, button.frame.size.height)
        button.layer.cornerRadius = minDimension / 2
    }
    
    private func addTapGesture(to view: UIView, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: self, action: action)
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleRecord(_ sender: UITapGestureRecognizer? = nil) {
        if scanningStatus == .stopped {
            changeScanStatus(to: .scanning)
        } else {
            changeScanStatus(to: .stopped)
        }
        UIView.animate(withDuration: 0.25) {
            self.updateScanningIndicators()
        }
    }
    
    @objc private func handlePauseResume(_ sender: UITapGestureRecognizer? = nil) {
        if scanningStatus == .scanning {
            changeScanStatus(to: .paused)
        } else {
            changeScanStatus(to: .scanning)
        }
        updateScanningIndicators()
    }
    
    private func changeScanStatus(to status: ScanStatus) {
        scanningStatus = status
    }
    
    private func updateScanningIndicators() {
        switch scanningStatus {
        case .stopped:
            resetScanButton()
            pauseAndResumeButtonOutline.isHidden = true
            pauseAndResumeButtonIcon.isHidden = true
            print("Stopped")
        case .scanning:
            shrinkScanButton()
            pauseAndResumeButtonOutline.isHidden = false
            pauseAndResumeButtonIcon.isHidden = false
            pauseAndResumeButtonIcon.image = UIImage(systemName: "pause.fill")
            print("Scanning")
        case .paused:
            pauseAndResumeButtonOutline.isHidden = false
            pauseAndResumeButtonIcon.isHidden = false
            pauseAndResumeButtonIcon.image = UIImage(systemName: "play.fill")
            print("Paused")
        }
    }
    
    private func resetScanButton() {
        scanButton.transform = .identity
        setupCircularButton(scanButton) // Resets the corner radius to original circular shape
    }
    
    private func shrinkScanButton() {
        scanButton.layer.cornerRadius = 10
        scanButton.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
}
