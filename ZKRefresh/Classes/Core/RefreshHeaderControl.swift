//
//  RefreshHeader.swift
//  KCFramework
//
//  Created by kai zhou on 2018/12/6.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import Foundation

open class RefreshHeaderControl:RefreshComponent{
    //    public override init(frame: CGRect) {
    //        super.init(frame: CGRect(x: (UIScreen.main.bounds.width - 200)/2, y: -50, width: 200, height: 50))
    //        self.backgroundColor = UIColor.red
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    //    deinit {
    //        debugPrint("deinit-RefreshHeader")
    //    }
    
    
    open override func scrollViewContentOffsetDidChange(scrollView:UIScrollView,change:[NSKeyValueChangeKey : Any]?){
        
        //        debugPrint("监听:contentOffset :\(scrollView.contentOffset),\n contentInset:\(scrollView.contentInset),\n contentSize:\(scrollView.contentSize)")
        
        let offsetWithoutInsets = self.previousOffset + self.scrollViewInsetsDefaultValue.top
        
        
        if state == .refreshing {
            //            debugPrint("正在刷新")  //refreshing
        }else{
            
            if scrollView.isDragging {
                isFirstLoad = false
                if offsetWithoutInsets < -frame.size.height{
                    state = .pullingOutRect
                    //                debugPrint("正在pull") //pulling
                }else{
                    state = .pullingInRect
                    //                debugPrint("正在pull") //pulling
                }
                
            }else{
                
                //下拉刷新的释放 //release
                if !isFirstLoad && offsetWithoutInsets < 0 {
                    if offsetWithoutInsets < -frame.size.height {
                        state = .refreshing
                        refreshingAnimating()
                        //                    debugPrint("释放超出范围") //release out of rect
                        //                        }else if offsetWithoutInsets == self.previousOffset{
                        //                            debugPrint("结束") //end
                    }else  {
                        state = .releaseing
                        //                        debugPrint("header释放在范围内")  //release in rect
                        
                        //                    debugPrint("header offsetWithoutInsets:\(offsetWithoutInsets), scrollView.contentOffset:\(scrollView.contentOffset)")
                    }
                }
                
            }
        }
        
        self.previousOffset = scrollView.contentOffset.y
        
    }
    
    override func refreshingAnimating() {
        isRefreshing = true
        let scrollView = superview as! UIScrollView
        var insets = scrollView.contentInset
        insets.top += self.frame.size.height
        
        
        scrollView.contentOffset.y = previousOffset
        scrollView.bounces = false
        
        //        debugPrint("header开始动画start")  //header start animation -- start
        UIView.animate(withDuration: 0.3, animations: {
            scrollView.contentInset = insets
            scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: -insets.top)
        }, completion: {[weak self]finished in
            //            debugPrint("header开始动画End") //header start animation -- end
            
            self?.postRefreshing()
        })
    }
    
    override func endRefreshingAnimating(state:RefreshState = .idle) {
        let scrollView = superview as! UIScrollView
        scrollView.bounces = self.scrollViewBouncesDefaultValue
        
        //结束刷新位置在上方  //end up of new position
        if self.previousOffset < 0.0 {
            //        debugPrint("header结束动画Start")  //header end animation -- start
            UIView.animate(withDuration: 0.3, animations: {[unowned self ] in
                scrollView.contentInset = self.scrollViewInsetsDefaultValue
                
                scrollView.contentOffset = CGPoint.zero
                }, completion: {[weak self] finished in
                    
                    self?.isRefreshing = false
                    self?.state = state
                    //            debugPrint("header结束动画End") ////header end animation -- end
                    self?.postEndRefreshing()
            })
            
            //结束刷新位置在内容区域 //end in contentSize
        }else{
            scrollView.contentInset = self.scrollViewInsetsDefaultValue
            
            //            scrollView.contentOffset = CGPoint.zero
            
            self.isRefreshing = false
            self.state = state
            // debugPrint("header结束刷新，无动画End")
            self.postEndRefreshing()
        }
        
    }
    
    public func endRefreshingWithResetFooter(closure:(()->())? = nil){
        self.endRefreshingClosure = closure
        self.endRefreshingTarget = nil
        self.endRefreshingSelector = nil
        endRefreshingExecute()
        let scrollView = superview as! UIScrollView
        if let footer = scrollView.zk_footer{
            footer.resetNoMoreData()
        }
    }
    
}
