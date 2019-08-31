//
//  RefreshFooter.swift
//  KCFramework
//
//  Created by kai zhou on 2018/12/6.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import Foundation

open class RefreshFooterControl:RefreshComponent{
    var lock:NSLock = NSLock()
    
    //    public override init(frame: CGRect) {
    //        super.init(frame: CGRect(x: (UIScreen.main.bounds.width - 200)/2, y: 0, width: 200, height: 50))
    //        self.backgroundColor = UIColor.red
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    //    deinit {
    //        debugPrint("deinit-RefreshFooter")
    //    }
    
    
    public func endRefreshingWithNoMoreData(closure:(()->())? = nil){
        self.endRefreshingClosure = closure
        self.endRefreshingTarget = nil
        self.endRefreshingSelector = nil
        endRefreshWithNoMoreDataExcute()
    }
    
    public func endRefreshingWithNoMoreData(target:AnyObject?,selector:Selector){
        self.endRefreshingClosure = nil
        self.endRefreshingTarget = target
        self.endRefreshingSelector = selector
        endRefreshWithNoMoreDataExcute()
    }
    
    func endRefreshWithNoMoreDataExcute(){
        endRefreshingAnimating(state:.noMoreData)
    }
    
    //    //当header.endRefreshing()后，table.reloadData()后。重置
    public func resetNoMoreData(closure:(()->())? = nil){
        self.endRefreshingClosure = closure
        self.endRefreshingTarget = nil
        self.endRefreshingSelector = nil
        endRefreshingExecute()
    }
    
    open override func scrollViewContentOffsetDidChange(scrollView: UIScrollView, change: [NSKeyValueChangeKey : Any]?) {
        guard scrollView.isUserInteractionEnabled else {
            return
        }
        guard scrollView.contentSize.height > 0 else {
            return
        }
        //        guard scrollView.bounces else {
        ////            debugPrint("bounces监听:contentOffset :\(scrollView.contentOffset),\n contentInset:\(scrollView.contentInset),\n contentSize:\(scrollView.contentSize)")
        //            return
        //        }
        guard state != .noMoreData else {
            return
        }
        
        //        debugPrint("监听:contentOffset :\(scrollView.contentOffset),\n contentInset:\(scrollView.contentInset),\n contentSize:\(scrollView.contentSize)")
        
        let offsetWithoutInsets = self.previousOffset + self.scrollViewInsetsDefaultValue.top
        
        
        if state == .refreshing {
            //            debugPrint("正在刷新")  //Refreshing
        }else{
            
            if scrollView.isDragging {
                isFirstLoad = false
                if offsetWithoutInsets + scrollView.frame.height >  scrollView.contentSize.height + self.frame.height  {
                    state = .pullingOutRect
                    //                    debugPrint("正在pull") //pulling
                }else{
                    state = .pullingInRect
                    //                    debugPrint("正在pull") //pulling
                }
                
            }else{
                if !isFirstLoad{
                    //上拉加载的释放  //pull release
                    if offsetWithoutInsets > 0 {
                        if offsetWithoutInsets + scrollView.frame.height >  scrollView.contentSize.height + self.frame.height  {
                            state = .refreshing
                            refreshingAnimating()
                            
                            //                            debugPrint("释放超出范围") //release out off rect
                            //                        }else if offsetWithoutInsets == self.previousOffset{
                            //                            debugPrint("结束") //end
                        }else  {
                            //                            debugPrint("释放在范围内") //release in rect
                        }
                    }
                }
                
            }
        }
        
        self.previousOffset = scrollView.contentOffset.y
        
    }
    
    open override func scrollViewContentSizeDidChange(scrollView: UIScrollView, change: [NSKeyValueChangeKey : Any]?) {
        
        self.frame.origin.y = scrollView.contentSize.height
        //        snp.updateConstraints { (make) in
        //            make.top.equalTo(scrollView.contentSize.height)
        //        }
    }
    
    override  func refreshingAnimating() {
        isRefreshing = true
        if let scrollView = superview as? UIScrollView {
            
            var insets = scrollView.contentInset //self.previousOffset
            insets.bottom = frame.size.height
            
            UIView.animate(withDuration: 0.3,  animations: {
                scrollView.contentInset = insets
            }, completion: {[weak self] finished in
                
                
                
                self?.postRefreshing()
                
            })
        }
    }
    
    override  func endRefreshingAnimating(state:RefreshState = .idle) {
        
        if let scrollView = superview as? UIScrollView {
            
            DispatchQueue.global(qos: .userInteractive).async {[weak self] in
                self?.lock.lock()
                
                DispatchQueue.main.async {
                    
                    //scrollView.layer.removeAllAnimations() //header动画，联动footer的reset。会造成header动画被取消。
                    
                    var insets = scrollView.contentInset //self.previousOffset
                    insets.bottom = self?.height ?? 50
                    
                    UIView.animate(withDuration: 0.3,  animations: {
                        
                        if state == .noMoreData{
                            scrollView.contentInset = insets
                        }else{
                            scrollView.contentInset = self?.scrollViewInsetsDefaultValue ?? UIEdgeInsets.zero
                        }
                        
                    }, completion: {[weak self] finished in
                        self?.isRefreshing = false
                        self?.state = state
                        //                        debugPrint("footer结束动画end") //footer end animate
                        self?.postEndRefreshing()
                        self?.lock.unlock()
                    })
                }
            }
            
        }
    }
}
