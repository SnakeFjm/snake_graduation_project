//
//  ScanCodeViewController.swift
//  FoodDetect
//
//  Created by Snake on 2017/12/31.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

class ScanCodeViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var backgroundViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var scanView: UIView!
    @IBOutlet weak var manualInputImageView: UIImageView!
    
    var isManual: Bool = false
    
    //
    var captureDevice: AVCaptureDevice!
    var captureSession: AVCaptureSession!
    var input: AVCaptureDeviceInput!
    var output: AVCaptureMetadataOutput!
    //
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!   // 预览图层
    var codeFrameView: UIView!
    
    var student_id = ""
    var course_id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.navigationController?.navigationBar.isHidden = true
        //
        self.addLeftWhiteBackButton()
        //
        self.view.backgroundColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 0.7)
        
        // 给图片加手势 手动输入
        self.manualInputImageView.isUserInteractionEnabled = true
        self.manualInputImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ScanCodeViewController.manualInputGestureDidTouch)))

        // 初始化
        self.initAVCapture()
        //
        self.captureSession?.startRunning()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.captureSession.stopRunning()
    }
    
    // =================================
    // MARK:
    // =================================
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        //
        self.backgroundViewHeightConstraint.constant = ScreenHeight
    }
    
    // =================================
    // MARK:
    // =================================
    
    func initAVCapture() {
        // 获取视频设备
        self.captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do {
            self.input = try AVCaptureDeviceInput.init(device: self.captureDevice)
        } catch let error {
            debugPrint(error)
        }
        
        // 设定输出端
        self.output = AVCaptureMetadataOutput.init()
//        self.output.rectOfInterest = self.scanView.frame
        // 设置代理
        self.output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        // 添加输入输出
        self.captureSession = AVCaptureSession.init()
        self.captureSession?.addInput(self.input)
        self.captureSession?.addOutput(self.output)
        
        // 设置识别码条（一维码）
        self.output.metadataObjectTypes = [.code128, .code39, .code93, .ean13, .ean8, .code39Mod43, .qr]
        
        // 添加预留图层
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: self.captureSession)
        self.videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        self.videoPreviewLayer?.frame = CGRect.init(x: 0, y: 0, width: ScreenWidth - 50, height: self.scanView.frame.size.height)
//            self.scanView.bounds
        self.scanView.layer.insertSublayer(self.videoPreviewLayer, at: 0)
        
        // 设置边框
        self.scanView.layer.borderColor = UIColor.init(red: 255/255, green: 192/255, blue: 50/255, alpha: 1).cgColor
        self.scanView.layer.borderWidth = 2
    }
    
    // =================================
    // MARK:
    // =================================
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        //
        if metadataObjects == nil || metadataObjects.count == 0 {
            showErrorTips("No code is detected")
            self.perform(#selector(hideTips), with: self, afterDelay: 1)
            return
        }
        
        let metadataObj = metadataObjects.first as! AVMetadataMachineReadableCodeObject
        if metadataObj.stringValue != nil {
            let codeString: String = metadataObj.stringValue!
            // 停止
            self.captureSession.stopRunning()
            //
            self.handleCode(code: codeString)

        }
        
    }
    
    // =================================
    // MARK: 手动输入
    // =================================
    
    @objc func manualInputGestureDidTouch() {
        
        showAlertTextFieldController(title: "输入条码下方的编号", message: "", content: "", placeholder: "请输入条码编号", cancelTitle: "取消", confirmTitle: "激活") { (_, index, codeString) in
            if index == 1 {
                if !(codeString?.isEmpty)! {
                    self.isManual = true
                    //
                    self.handleCode(code: codeString!)
                }
            } else {
            }
        }
        
    }
    
    // 处理条码
    func handleCode(code: String) {
        
        let apiName = URLManager.student_sign()
        let parameter: Parameters = ["student_id": UserManager.shared.userModel.id,
                                     "course_id": self.course_id,
                                     "randomString": code]
        //
        HttpManager.shared.putRequest(apiName, parameters: parameter).responseJSON { (response) in
            if let result = HttpManager.parseDataResponse(response) {
                // 更新token 保存用户信息
                if let dict: [String: Any] = result.dictionaryObject {
                    //
                    if self.isManual {
                        self.isManual = false
                    } else {
                    }
                    //
                    debugPrint(dict)
                    //
                    showSuccessTips("签到成功")
                    self.back()
                    // 跳转成功页面

                }
            } else {
                //
                if self.isManual {
                    //
                    self.isManual = false
                } else {
                    //
                }
                // 开始
                self.captureSession.startRunning()
            }
        }
        
    }


}
