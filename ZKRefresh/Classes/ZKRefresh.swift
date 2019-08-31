//
//  ZKRefresh.swift
//  ZKRefresh
//
//  Created by zhoukai on 2019/8/31.
//  Copyright © 2019 wumingapie@gmail.com. All rights reserved.
//

import Foundation

var Default_Header:RefreshHeader.Type = RefreshIndicatorHeader.self
var Default_Footer:RefreshFooter.Type = RefreshIndicatorFooter.self
var Default_Component_Height:CGFloat = 50.0

public func ZKRefreshSetDefaultHeader(_ header:RefreshHeader.Type) {
    Default_Header = header
}

public func ZKRefreshGetDefaultHeader() -> RefreshHeader.Type{
    return Default_Header
}

public func ZKRefreshSetDefaultFooter(_ footer:RefreshFooter.Type){
    Default_Footer = footer
}

public func ZKRefreshGetDefaultFooter() -> RefreshFooter.Type{
    return Default_Footer
}

public func ZKRefreshSetDefaultComponentHeight(_ h:CGFloat){
    Default_Component_Height = h
}

public func ZKRefreshGetDefaultComponentHeight() -> CGFloat{
    return Default_Component_Height
}

//MARK: Utils
let bundle = Bundle(for: RefreshComponent.self)
extension UIImage{
    convenience init?(named:String) {
        let sourceBundlePath = bundle.path(forResource: "ZKRefreshResource", ofType: "bundle")
        let sourceBundle = Bundle.init(path: sourceBundlePath!)
        self.init(named: named, in: sourceBundle, compatibleWith: nil)
    }
}

extension UIColor {
    convenience init(hex hexColor:CGFloat, alpha: CGFloat = 1) {
        let red = CGFloat((Int(hexColor) & 0xFF0000) >> 16)  / 255.0
        let green = CGFloat((Int(hexColor) & 0xFF00) >> 8)  / 255.0
        let blue = CGFloat((Int(hexColor) & 0xFF))  / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

func DispatchOnMainQueue(_ closure:@escaping ()->()){
    if Thread.current.isMainThread {
        closure()
    }else{
        DispatchQueue.main.async {
            closure()
        }
    }
}
