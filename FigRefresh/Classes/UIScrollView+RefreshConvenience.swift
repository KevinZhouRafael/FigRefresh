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
    public  func fig_header(refreshingClosure:@escaping ()->()){
        fig_header = Default_Header.init(refreshingClosure: refreshingClosure)
    }
    public  func fig_header(refreshingClosure:@escaping ()->(), endRefreshingClosure:(()->())? = nil){
        fig_header = Default_Header.init(refreshingClosure: refreshingClosure, endRefreshingClosure: endRefreshingClosure)
    }
    
    //MARK: footer refreshing
    public  func fig_footer(refreshingClosure:@escaping ()->()){
        fig_footer = Default_Footer.init(refreshingClosure: refreshingClosure)
    }
    
    public  func fig_footer(refreshingClosure:@escaping ()->(), endRefreshingClosure:(()->())? = nil){
        fig_footer = Default_Footer.init(refreshingClosure: refreshingClosure, endRefreshingClosure: endRefreshingClosure)
    }
    
    
    //MARK: target
//    public  func fig_header(refreshingTarget:AnyObject?,refreshingSelector:Selector?){
//        fig_header = Default_Header.init(refreshingTarget: refreshingTarget, refreshingSelector: refreshingSelector)
//    }
//
//    public  func fig_header(refreshingTarget:AnyObject?,refreshingSelector:Selector?, endRefreshingTarget:AnyObject? = nil,endRefreshingSelector:Selector? = nil){
//        fig_header = Default_Header.init(refreshingTarget: refreshingTarget, refreshingSelector: refreshingSelector, endRefreshingTarget: endRefreshingTarget, endRefreshingSelector: endRefreshingSelector)
//    }
    
    //    public  func fig_footer(refreshingTarget:AnyObject?,refreshingSelector:Selector?){
    //        fig_footer = Default_Footer.init(refreshingTarget: refreshingTarget, refreshingSelector: refreshingSelector)
    //    }
    //
    //    public  func fig_footer(refreshingTarget:AnyObject?,refreshingSelector:Selector?, endRefreshingTarget:AnyObject? = nil,endRefreshingSelector:Selector? = nil){
    //        fig_footer = Default_Footer.init(refreshingTarget: refreshingTarget, refreshingSelector: refreshingSelector, endRefreshingTarget: endRefreshingTarget, endRefreshingSelector: endRefreshingSelector)
    //    }
    
}
