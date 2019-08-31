//
//  RefreshHeader.swift
//  KCFramework
//
//  Created by kai zhou on 2018/12/6.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import Foundation

open class RefreshHeader:RefreshHeaderControl{

    
    open override func refreshComponentDidMoveToSuperview() {
        super.refreshComponentDidMoveToSuperview()
        
        if let sview = self.superview {
            
//            snp.remakeConstraints { (make) in
//                make.top.equalTo(-height)
//                make.centerX.equalToSuperview()
//                make.width.equalTo(sview)
//                make.height.equalTo(height)
//            }
            frame = CGRect(x: 0, y: -height, width: sview.frame.width, height: height)
        }
       
        titleLabel?.font = UIFont.systemFont(ofSize: 14)
        titleLabel?.textColor = UIColor.gray
        
//        backgroundColor = UIColor.red

    }
    
    
    open override func refreshComponentTitlesWithStates() -> [RefreshState : String] {
         return [.idle:"Pull down to refresh",
                 .pullingInRect:"Pull down to refresh",
                 .pullingOutRect:"Release to refresh",
                 .releaseing:"Pull down to refresh",
                 .refreshing:"Loading..."]
        
//        return [.idle:"下拉刷新",
//                .pullingInRect:"下拉刷新",
//                .pullingOutRect:"松开刷新",
//                .releaseing:"下拉刷新",
//                .refreshing:"正在刷新..."]
    }
    
}
