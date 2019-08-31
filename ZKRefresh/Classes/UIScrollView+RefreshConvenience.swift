//
//  UIScrollView+RefreshConvenience.swift
//  KCConfigModule
//
//  Created by kai zhou on 2018/12/14.
//  Copyright © 2018 kai zhou. All rights reserved.
//

import Foundation



@objc extension UIScrollView{
    
    //MARK: header refreshing
    public  func zk_header(refreshingClosure:@escaping ()->()){
        zk_header = Default_Header.init(refreshingClosure: refreshingClosure)
    }
    public  func zk_header(refreshingClosure:@escaping ()->(), endRefreshingClosure:(()->())? = nil){
        zk_header = Default_Header.init(refreshingClosure: refreshingClosure, endRefreshingClosure: endRefreshingClosure)
    }
    
    //MARK: footer refreshing
    public  func zk_footer(refreshingClosure:@escaping ()->()){
        zk_footer = Default_Footer.init(refreshingClosure: refreshingClosure)
    }
    
    public  func zk_footer(refreshingClosure:@escaping ()->(), endRefreshingClosure:(()->())? = nil){
        zk_footer = Default_Footer.init(refreshingClosure: refreshingClosure, endRefreshingClosure: endRefreshingClosure)
    }
    
    
    //MARK: target
//    public  func zk_header(refreshingTarget:AnyObject?,refreshingSelector:Selector?){
//        zk_header = Default_Header.init(refreshingTarget: refreshingTarget, refreshingSelector: refreshingSelector)
//    }
//
//    public  func zk_header(refreshingTarget:AnyObject?,refreshingSelector:Selector?, endRefreshingTarget:AnyObject? = nil,endRefreshingSelector:Selector? = nil){
//        zk_header = Default_Header.init(refreshingTarget: refreshingTarget, refreshingSelector: refreshingSelector, endRefreshingTarget: endRefreshingTarget, endRefreshingSelector: endRefreshingSelector)
//    }
    
    //    public  func zk_footer(refreshingTarget:AnyObject?,refreshingSelector:Selector?){
    //        zk_footer = Default_Footer.init(refreshingTarget: refreshingTarget, refreshingSelector: refreshingSelector)
    //    }
    //
    //    public  func zk_footer(refreshingTarget:AnyObject?,refreshingSelector:Selector?, endRefreshingTarget:AnyObject? = nil,endRefreshingSelector:Selector? = nil){
    //        zk_footer = Default_Footer.init(refreshingTarget: refreshingTarget, refreshingSelector: refreshingSelector, endRefreshingTarget: endRefreshingTarget, endRefreshingSelector: endRefreshingSelector)
    //    }
    
}
