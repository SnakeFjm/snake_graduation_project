//
//  BaseViewController.swift
//  FoodDetect
//
//  Created by dev on 2017/10/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit
import QMUIKit
import MobileCoreServices

import Alamofire
import SwiftyJSON


class BaseViewController: QMUICommonViewController {
    
    
    var isHiddenNavigationBarShadowLine: Bool = false // 是否需要隐藏导航栏的分割线
    
    var rightBarButton: UIBarButtonItem! // 导航栏右上角按钮
    
    
    
    // 图片预览器
    lazy var imagePreviewVC: QMUIImagePreviewViewController = {
        let vc = QMUIImagePreviewViewController.init()
        vc.imagePreviewView.delegate = self
        vc.imagePreviewView.currentImageIndex = 0
        return vc
    }()
    
    
    
    // =================================
    // MARK:
    // =================================

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.view.backgroundColor = UIColor.RGBSameMake(value: 0xf0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        if isHiddenNavigationBarShadowLine {
            self.hiddenNavBarShadowLine()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //
        if isHiddenNavigationBarShadowLine {
            self.resetNavBarShadowLine()
        }
    }
    
    // =================================
    // MARK:
    // =================================
    
    func hiddenNavBarShadowLine() {
        let image = UIImage.qmui_image(with: UIColor.white, size: CGSize(width: ScreenWidth, height: NavigationBarHeight), cornerRadius: 0)
        self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func resetNavBarShadowLine() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    // =================================
    // MARK:
    // =================================
    
    func navBarAddRightBarButton(title: String) {
        self.rightBarButton = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(navBarRightBarButtonDidTouch(_:)))
        self.navigationItem.rightBarButtonItem = self.rightBarButton
    }
    
    func navBarAddRightBarButton(image: UIImage) {
        self.rightBarButton = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(navBarRightBarButtonDidTouch(_:)))
        self.navigationItem.rightBarButtonItem = self.rightBarButton
    }
    
    @objc func navBarRightBarButtonDidTouch(_ sender: Any) {
        
    }

}




// ========================
// MARK: 图片查看器
// ========================

extension BaseViewController: QMUIImagePreviewViewDelegate {
    
    // 开始查看图片
//    self.imagePreviewViewController.imagePreviewView.currentImageIndex = index
//    self.imagePreviewViewController.startPreviewFading()
    
    // 返回图片个数
    func numberOfImages(in imagePreviewView: QMUIImagePreviewView!) -> UInt {
        return 0
    }
    
    // 返回图片资源
    func imagePreviewView(_ imagePreviewView: QMUIImagePreviewView!, renderZoomImageView zoomImageView: QMUIZoomImageView!, at index: UInt) {
//        zoomImageView.image = image
    }
    
    // 单击结束预览
    func singleTouch(inZooming zoomImageView: QMUIZoomImageView!, location: CGPoint) {
        self.imagePreviewVC.endPreviewFading()
    }
    
    
}




// 选取图片

extension BaseViewController: QMUIAlbumViewControllerDelegate, QMUIImagePickerViewControllerDelegate, QMUIImagePickerPreviewViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    // =================================
    // MARK: 弹窗询问相册
    // =================================
    
    // 弹窗询问是要相册还是拍照
    func askAssetsOrCameraWithSheet() {
        showActionSheet(title: "", otherTitles: ["拍照", "相册"]) { (action: QMUIAlertAction?, index: Int) in
            if index == 1 {
                // 拍照
                self.presentCamera()
            } else if index == 2 {
                // 相册
                authorizationPresentAlbumViewController { (isSuccess) in
                    if isSuccess {
                        self.presentAlbumViewController()
                    }
                }
            }
        }
    }
    
    // 相册
    func presentAlbumViewController() {
        
        let albumVC: QMUIAlbumViewController = QMUIAlbumViewController.init()
        albumVC.albumViewControllerDelegate = self
        albumVC.contentType = QMUIAlbumContentType.onlyPhoto
        albumVC.title = "相册"
        //
        let navController: UINavigationController = UINavigationController(rootViewController: albumVC)
        
        // 获取最近发送图片时使用过的相簿，如果有则直接进入该相簿
        let assetsGroup: QMUIAssetsGroup? = QMUIImagePickerHelper.assetsGroupOfLastestPickerAlbum(withUserIdentify: nil)
        if assetsGroup != nil {
            let imagePicker: QMUIImagePickerViewController = self.imagePickerViewController(for: albumVC)
            imagePicker.refresh(with: assetsGroup)
            imagePicker.title = assetsGroup?.name()
            navController.pushViewController(imagePicker, animated: false)
        }
        
        //
        self.present(navController, animated: true, completion: nil)
    }
    
    
    // 照相
    func presentCamera() {
        let imagePicker: UIImagePickerController = UIImagePickerController.init()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.mediaTypes = [kUTTypeImage as String]
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    // =================================
    // MARK: QMUIAlbum ViewController Delegate
    // =================================
    
    public func imagePickerViewController(for albumViewController: QMUIAlbumViewController!) -> QMUIImagePickerViewController! {
        let imagePickerVC: QMUIImagePickerViewController = QMUIImagePickerViewController.init()
        imagePickerVC.imagePickerViewControllerDelegate = self
        imagePickerVC.maximumSelectImageCount = self.imageSelectMaximumSelectImageCount()
        return imagePickerVC
    }
    
    // =================================
    // MARK: QMUIImagePicker ViewController Delegate
    // =================================
    
    public func imagePickerViewController(_ imagePickerViewController: QMUIImagePickerViewController!, didFinishPickingImageWithImagesAssetArray imagesAssetArray: NSMutableArray!) {
        // 储存最近选择了图片的相册，方便下次直接进入该相册
        QMUIImagePickerHelper.updateLastestAlbum(with: imagePickerViewController.assetsGroup, ablumContentType: QMUIAlbumContentType.onlyPhoto, userIdentify: nil)
        self.imageSelectAssetArrayCallBack(imagesAssetArray: imagesAssetArray);
    }
    
    public func imagePickerPreviewViewController(for imagePickerViewController: QMUIImagePickerViewController!) -> QMUIImagePickerPreviewViewController! {
        let imagePickerPreviewVC: QMUIImagePickerPreviewViewController = QMUIImagePickerPreviewViewController.init()
        imagePickerPreviewVC.delegate = self
        imagePickerPreviewVC.maximumSelectImageCount = self.imageSelectMaximumSelectImageCount()
        return imagePickerPreviewVC
    }
    
    // =================================
    // MARK: UIImagePickerController Delegate
    // =================================
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType: String = info[UIImagePickerControllerMediaType] as! String
        if mediaType == (kUTTypeImage as String) {
            let orgImage: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.imagePickerCameraCallBack(image: orgImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    /** 让调用者决定调用选择图片的上限 */
    @objc func imageSelectMaximumSelectImageCount() -> UInt {
        return 9
    }
    
    /** 拍照片的回调 */
    @objc func imagePickerCameraCallBack(image: UIImage) {
    }
    
    /** */
    @objc func imageSelectAssetArrayCallBack(imagesAssetArray: NSMutableArray) {
    }
    
    
}






