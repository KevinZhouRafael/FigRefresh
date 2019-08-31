//
//  UIScrollView+Refresh.swift
//  KCFramework
//
//  Created by kai zhou on 2018/12/5.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import Foundation


public protocol Refreshable:NSObjectProtocol {
    var fig_header:RefreshHeader?{set get}
    var fig_footer:RefreshFooter?{set get}
    
}

private var REFRESHABLE_HEADER:String = "REFRESHABLE_HEADER"
private var REFRESHABLE_FOOTER:String = "REFRESHABLE_FOOTER"
extension Refreshable where Self:UIScrollView{
    public var fig_header:RefreshHeader?{
        set{
            if let  newHeader = newValue{
                if let oldHeader = fig_header,oldHeader != newHeader{
                    oldHeader.removeFromSuperview()
                }
                insertSubview(newHeader,at:0)
                objc_setAssociatedObject(self, &REFRESHABLE_HEADER, newHeader, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
           
        }
        get{
            return objc_getAssociatedObject(self, &REFRESHABLE_HEADER) as? RefreshHeader
        }
    }
    
    public  var fig_footer:RefreshFooter?{
        set{
            if let newFooter = newValue{
                if let oldFooter = fig_footer,oldFooter != newFooter{
                    oldFooter.removeFromSuperview()
                }
                insertSubview(newFooter,at:0)
                objc_setAssociatedObject(self, &REFRESHABLE_FOOTER, newFooter, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
           
        }
        get{
            return objc_getAssociatedObject(self, &REFRESHABLE_FOOTER) as? RefreshFooter
        }
    }
}

extension UIScrollView:Refreshable{}


