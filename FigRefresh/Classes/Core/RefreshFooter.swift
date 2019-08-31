//
//  RefreshFooter.swift
//  KCFramework
//
//  Created by kai zhou on 2018/12/6.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import Foundation

open class RefreshFooter:RefreshFooterControl{

    
    open override func refreshComponentDidMoveToSuperview() {
         //contentSize change to reset
//        frame =  CGRect(x: 0, y: 0, width:UIScreen.main.bounds.width, height: height)
        super.refreshComponentDidMoveToSuperview()
        
        if let sview = self.superview {
//            snp.remakeConstraints { (make) in
//                make.top.equalTo(0)
//                make.centerX.equalToSuperview()
//                make.width.equalTo(sview)
//                make.height.equalTo(height)
//            }
            frame = CGRect(x: 0, y: 0, width: sview.frame.width, height: height)
        }
        
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        titleLabel?.textColor = UIColor.gray
        
//        self.backgroundColor = UIColor.red
    }
    
    
    open override func refreshComponentTitlesWithStates() -> [RefreshState : String] {
        return [.idle: "Pull up to load more",
                .pullingInRect: "Pull up to load more",
                .pullingOutRect: "Release to load more",
                .releaseing:"Pull up to load more",
                .refreshing:"Loading...",
                .noMoreData:"No more data"]
        
//        return [.idle: "上拉加载更多数据",
//                .pullingInRect: "上拉加载更多数据",
//                .pullingOutRect: "松开加载更多数据",
//                .releaseing:"上拉加载更多数据",
//                .refreshing:"正在加载更多的数据...",
//                .noMoreData:"已经没有更多了"]

    }
    
}
