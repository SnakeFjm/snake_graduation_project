//
//  LoopBannerView.swift
//  renbo
//
//  Created by dev on 2017/12/21.
//  Copyright © 2017年 iAskDoc Technology. All rights reserved.
//

import UIKit

@objc protocol LoopScrollBannerDelegate: NSObjectProtocol {
    
    @objc func numberOfItemsInloopScrollBanner(_ banner: LoopScrollBanner) -> Int
    
    @objc func loopScrollBanner(_ banner: LoopScrollBanner, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
    @objc func loopScrollBanner(_ banner: LoopScrollBanner, didSelectItemAt indexPath: IndexPath)
}



class LoopScrollBanner: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    var pageControl: UIPageControl!
    
    var delegate: LoopScrollBannerDelegate!
    
    var timer: Timer! // 计时器
    var scrollInterval: TimeInterval = 4 // 滚动间隔
    
    private var currentIndex: Int = 0 // 当前索引
    private var totalCount: Int = 0 // 全部视图数
    
    
    // =================================
    // MARK:
    // =================================
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initSubviews() {
        //
        self.flowLayout = UICollectionViewFlowLayout.init()
        self.flowLayout.scrollDirection = .horizontal
        self.flowLayout.minimumLineSpacing = 0
        self.flowLayout.minimumInteritemSpacing = 0
        self.flowLayout.itemSize = CGSize(width: ScreenWidth, height: 120)
        
        //
        self.collectionView = UICollectionView.init(frame: CGRect(), collectionViewLayout: self.flowLayout)
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.isPagingEnabled = true
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "UICollectionViewCell")
        self.addSubview(self.collectionView)
        //
        self.collectionView.autoPinEdgesToSuperviewEdges()
        
        //
        self.pageControl = UIPageControl.init()
        self.addSubview(self.pageControl)
        self.pageControl.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        self.pageControl.autoPinEdge(toSuperviewEdge: .bottom, withInset: 15)
        self.pageControl.autoSetDimensions(to: CGSize(width: 150, height: 20))
        
    }
    
    // =================================
    // MARK:
    // =================================
    
    func beginScroll() {
        self.stopScroll()
        //
        let count = self.collectionView(self.collectionView, numberOfItemsInSection: 0)
        if count <= 0 {
            return
        }
        //
        self.totalCount = count
        self.pageControl.numberOfPages = self.totalCount
        self.pageControl.currentPage = 0
        //
        timer = Timer.scheduledTimer(timeInterval: self.scrollInterval, target: self, selector: #selector(scrollPageHandler), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func scrollPageHandler() {
        //
        currentIndex += 1
        if currentIndex >= self.totalCount {
            currentIndex = 0
        }
        //
        self.collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .left, animated: true)
        //
        self.pageControl.currentPage = currentIndex
    }
    
    func stopScroll() {
        //
        if timer != nil {
            timer.invalidate()
        }
        timer = nil
    }
    
    // =================================
    // MARK:
    // =================================
    
    func updateOffset() {
        //
        let itemSize = self.flowLayout.itemSize
        let offsetX = self.collectionView.contentOffset.x
        var page: Int = Int(offsetX / itemSize.width)
        let half: Bool = (offsetX.truncatingRemainder(dividingBy: itemSize.width) > (itemSize.width / 2))
        page += half ? 1 : 0
        //
        if page >= self.totalCount {
            page = 0
        }
        if page < 0 {
            page = 0
        }
        self.currentIndex = page
        //
        self.pageControl.currentPage = currentIndex
    }
    
    
    // =================================
    // MARK:
    // =================================
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.delegate != nil && self.delegate.responds(to: #selector(LoopScrollBannerDelegate.numberOfItemsInloopScrollBanner(_:))) {
            return self.delegate.numberOfItemsInloopScrollBanner(self)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.delegate != nil && self.delegate.responds(to: #selector(LoopScrollBannerDelegate.loopScrollBanner(_:cellForItemAt:))) {
            return self.delegate.loopScrollBanner(self, cellForItemAt: indexPath)
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
            
            let color = arc4random_uniform(254) + 1
            cell.backgroundColor = UIColor.RGBSameMake(value: CGFloat(color))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil && self.delegate.responds(to: #selector(LoopScrollBannerDelegate.loopScrollBanner(_:didSelectItemAt:))) {
            self.delegate.loopScrollBanner(self, didSelectItemAt: indexPath)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateOffset()
    }

    
    // =================================
    // MARK:
    // =================================
    
    func reloadData() {
        self.stopScroll()
        self.collectionView.reloadData()
        self.beginScroll()
    }
    
    
}
