//
//  CountDownButton.swift
//  renbo
//
//  Created by dev on 2017/12/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit

class CountDownButton: UIButton {
    
    @IBInspectable
    let countDownInterval: Int = 60
    
    private var timer: Timer!
    private var leftInterval: Int = 0
    
    
    // =================================
    // MARK:
    // =================================
    
    func buttonBeginCountDown() {
        self.beginCountDown()
        self.isEnabled = false
    }
    
    private func beginCountDown() {
        //
        self.leftInterval = countDownInterval
        //
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownHandler), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc private func countDownHandler() {
        //
        self.setTitle("\(self.leftInterval)秒后重新获取", for: .disabled)
        //
        leftInterval -= 1
        if leftInterval < 0 {
            self.stopCountDown()
        }
    }
    
    private func stopCountDown() {
        if timer.isValid {
            timer.invalidate()
            timer = nil
        }
        self.isEnabled = true
    }
    
    

}
