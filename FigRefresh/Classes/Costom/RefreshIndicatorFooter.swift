//
//  RefreshIndicatorFooter.swift
//  KCFramework
//
//  Created by kai zhou on 2018/12/10.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import Foundation

public class RefreshIndicatorFooter:RefreshFooter{
    
    var activityIndicatorV:UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    public override func refreshComponentDidMoveToSuperview() {
        super.refreshComponentDidMoveToSuperview()
        
        addSubview(activityIndicatorV)
        activityIndicatorV.frame = CGRect(x: (frame.width - height/2)/2 - 40, y: height/4, width: height/2, height: height/2)
//        activityIndicatorV.snp.makeConstraints { (make) in
//            make.centerX.equalTo(self).offset(-70)
//            make.centerY.equalToSuperview()
//            make.height.equalTo(height/2)
//            make.width.equalTo(height/2)
//        }
        
        titleLabel?.textColor = UIColor.gray
        titleLabel?.textAlignment = .left
        titleLabel!.font = UIFont.systemFont(ofSize: 13)
        titleLabel!.frame = CGRect(x: activityIndicatorV.frame.maxX + 5, y: 0, width: frame.width - (activityIndicatorV.frame.maxX + 5), height: height)
//        titleLabel?.snp.remakeConstraints({ (make) in
//            make.left.equalTo(activityIndicatorV.snp.right).offset(5)
//            make.centerY.equalToSuperview()
//            make.height.equalToSuperview()
//            make.right.equalToSuperview()
//        })
        
//        setTitle("没有更多的数据", for: .noMoreData)  //no more data
    }
    
    override open func refreshComponentStateChange(state: RefreshState) {
        super.refreshComponentStateChange(state: state)
        
        switch state{
        case .refreshing:
            activityIndicatorV.startAnimating()
            
            titleLabel?.textAlignment = .left
            titleLabel!.frame = CGRect(x: activityIndicatorV.frame.maxX + 5, y: 0, width: frame.width - (activityIndicatorV.frame.maxX + 5), height: height)
//            titleLabel?.snp.remakeConstraints({ (make) in
//                make.left.equalTo(activityIndicatorV.snp.right).offset(5)
//                make.centerY.equalToSuperview()
//                make.height.equalToSuperview()
//                make.right.equalToSuperview()
//            })
            break
        default:
            activityIndicatorV.stopAnimating()
            
            titleLabel?.textAlignment = .center
            titleLabel!.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
//            titleLabel?.snp.remakeConstraints { (make) in
//                make.edges.equalToSuperview()
//            }
            break
        }
        
    }
    
}
