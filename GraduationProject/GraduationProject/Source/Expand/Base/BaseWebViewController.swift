//
//  BaseWebViewController.swift
//  meimabang
//
//  Created by dev on 2016/12/2.
//  Copyright © 2016年 广州雅特网络科技. All rights reserved.
//

import UIKit
import JavaScriptCore
import WebKit


class BaseWebViewController: BaseViewController, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
    
    var url: URL!
    var webView: WKWebView!
    
    var leftLayoutConstraint: NSLayoutConstraint!
    var rightLayoutConstraint: NSLayoutConstraint!
    var topLayoutConstraint: NSLayoutConstraint!
    var bottomLayoutConstraint: NSLayoutConstraint!
    
    
    lazy var closeAllPagesButton: UIBarButtonItem = {
        let btn: UIBarButtonItem = UIBarButtonItem.init(title: "关闭", style: .plain, target: self, action: #selector(closeAllPagesButtonDidTouch(_:)))
        return btn
    }()
    
    lazy var backBarButton: UIBarButtonItem = {
        let btn: UIBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "arrow_left"), style: .plain, target: self, action: #selector(back))
        return btn
    }()
    
    private var onlyOnceFlag: Bool = false
    
    // =================================
    // MARK:
    // =================================
    
    convenience init(urlString: String) {
        self.init()
        
        let updateUrl = self.updateUrlString(urlString: urlString)
        //
        debugPrint("=======================")
        debugPrint("访问网址：\(updateUrl)")
        
//        guard let encodedStr: String = updateUrl.urlEncoding() else {
//            if let resultUrl: URL = URL.init(string: urlString) {
//                self.url = resultUrl
//            } else {
//                self.url = URL.init(string: "http://www.baidu.com")
//            }
//            return
//        }
        //
        if let resultUrl: URL = URL.init(string: updateUrl) {
            self.url = resultUrl
        } else {
            self.url = URL.init(string: "http://www.baidu.com")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.initWebView()
        //
        self.needShowCloseAllPagesButton(show: false)
    }
    
    // 初始化WebView
    func initWebView() {

        // 配置
        let config: WKWebViewConfiguration = WKWebViewConfiguration.init()
        config.preferences = WKPreferences.init()
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = true

        // 注入JS交互的方法名
        config.userContentController = WKUserContentController.init()
//        config.userContentController.add(self, name: "appHandler")

        //
        self.webView = WKWebView.init(frame: CGRect(), configuration: config)
        self.webView.uiDelegate = self
        self.webView.navigationDelegate = self
//        self.webView.scrollView.bounces = false
//        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.webView)
        
        //
        leftLayoutConstraint = self.webView.autoPinEdge(toSuperviewEdge: .left)
        rightLayoutConstraint = self.webView.autoPinEdge(toSuperviewEdge: .right)
        topLayoutConstraint = self.webView.autoPinEdge(toSuperviewEdge: .top)
        bottomLayoutConstraint = self.webView.autoPinEdge(toSuperviewEdge: .bottom)
        
        // 加载地址
        self.webViewBeginLoadRequest()
        
    }
    
    // 加载地址
    func webViewBeginLoadRequest() {
        let request: URLRequest = URLRequest.init(url: self.url)
        self.webView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // =================================
    // MARK: 更新访问地址
    // =================================
    
    // 补全
    func updateUrlString(urlString: String) -> String {
        var resultString: String = urlString
        // 补全前缀
        // 如果不存在http开头的
        if !resultString.hasPrefix("http") {
            let tempString = "http://" + resultString
            guard let encodedStr: String = tempString.urlEncoding() else {
                return tempString
            }
            // 如果组合后能够正常生成URL,则赋值，
            // 如果不能正常生成，则不赋值
            if let _ = URL.init(string: encodedStr) {
                resultString = encodedStr
            }
        }
        return resultString
    }
    
    
    // =================================
    // MARK: 关闭按钮
    // =================================
    
    func needShowCloseAllPagesButton(show: Bool) {
        if self.navigationController?.viewControllers.count != 0 && (self.navigationController?.viewControllers.first)! == self {
            self.navigationItem.leftBarButtonItem = nil
            return
        }
        //
        if show {
            self.navigationItem.leftBarButtonItems = [self.backBarButton, self.closeAllPagesButton]
        } else {
            self.navigationItem.leftBarButtonItem = self.backBarButton
        }
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    @objc func closeAllPagesButtonDidTouch(_ sender: Any) {
        if self.webView != nil {
            self.webView.stopLoading()
        }
        super.back()
    }
    
    
    override func back() {
        if self.webView.canGoBack {
            self.webView.goBack()
            self.needShowCloseAllPagesButton(show: true)
        } else {
            self.closeAllPagesButtonDidTouch(self.closeAllPagesButton)
        }
    }
    
    
    // =======================================
    //   MARK: webview delegate
    // =======================================
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.title") {
            [weak self] (result: Any?, err: Error?) in
            if let title: String = result as? String {
                self?.title = title
            }
        }
        //
        if !self.onlyOnceFlag {
            webView.configuration.userContentController.add(self, name: "appHandler")
            self.onlyOnceFlag = true
        }
    }


    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        debugPrint("createWebViewWithConfiguration request \(navigationAction.request)")
        if navigationAction.targetFrame == nil || !(navigationAction.targetFrame?.isMainFrame)! {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    
    // =======================================
    // MARK: JS Message Handler
    // =======================================
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        print(message.name)
        print(message.frameInfo)
    
        if message.name == "appHandler" {
            print("========== appHandler")
            if let bodyStr: String = message.body as? String {
                if let dict = bodyStr.toDictionary {
                    if let methodName: String = dict.object(forKey: "method") as? String {
                        let selector = Selector(methodName + ":")
                        if self.responds(to: selector) {
                            self.perform(selector, with: dict)
                        }
                    }
                }
            }
        }
    }
    
    
}
