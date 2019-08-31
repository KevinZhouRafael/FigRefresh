//
//  RefreshImagesHeader.swift
//  KCFramework
//
//  Created by kai zhou on 2018/12/10.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import Foundation
import UIKit

public class RefreshImagesHeader:RefreshHeader{
    
    var animationIV:UIImageView = UIImageView(image: UIImage(named: "ic_refresh_0"))
    var images:[UIImage]?


    public override func refreshComponentHeight() -> CGFloat {
        return animationIV.image?.size.height ?? height
    }
    
    public override func refreshComponentDidMoveToSuperview() {
        super.refreshComponentDidMoveToSuperview()
        
        //Gif动图
        if images == nil {
            images = [UIImage]()
            for i in 1 ... 8 {
                let image = UIImage(named: "ic_refresh_\(i)")
                images?.append(image!)
            }
            animationIV.animationDuration = 6*0.12
            animationIV.animationImages = images
        }
        animationIV.contentMode = .center
        
        addSubview(animationIV)
        let imageWidth = animationIV.image?.size.width ?? height
//        animationIV.snp.makeConstraints { (make) in
//            make.centerY.equalToSuperview()
//            make.centerX.equalToSuperview().offset(-imageWidth)
//            make.width.equalTo(imageWidth)
//            make.height.equalTo(height)
//        }
        animationIV.frame = CGRect(x: frame.width/2 - imageWidth - 20, y: 0, width: imageWidth, height: height)
        
//        titleLabel?.textColor = UIColor(hex: 0xADACAA)
        titleLabel?.textColor = UIColor.gray
        titleLabel?.textAlignment = .left
        titleLabel!.font = UIFont.systemFont(ofSize: 13)
        
//        titleLabel?.snp.remakeConstraints({ (make) in
//            make.left.equalTo(animationIV.snp.right).offset(10)
//            make.centerY.equalToSuperview()
//            make.height.equalToSuperview()
//            make.right.equalToSuperview()
//        })
        titleLabel?.frame = CGRect(x: animationIV.frame.maxX + 10, y: 0, width: frame.width - (animationIV.frame.maxX + 10), height: height)
        
    }

    
    public override  func refreshComponentStateChange(state: RefreshState) {
        super.refreshComponentStateChange(state: state)
        switch state{
        case .refreshing:
            animationIV.startAnimating()
            break
        default:
            animationIV.stopAnimating()
            break
        }
        
    }
    
}
