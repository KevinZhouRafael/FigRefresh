//
//  RefreshComponent.swift
//  KCFramework
//
//  Created by kai zhou on 2018/12/5.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import Foundation

/// 刷新状态
///
/// - idle: 普通闲置状态
/// - pullingInRect: 手指拉动状态(header或者footer未完全显示，不满足刷新条件）
/// - pullingOutRect: 手指拉动状态(header或者footer完全显示，满足刷新条件）
/// - releaseing: 释放后不刷新状态
/// - refreshing: 释放后刷新状态
/// - noMoreData: 没有更多数据
public enum RefreshState {
    case idle
    case pullingInRect //pulling and component not displays fully
    case pullingOutRect  //pulling and component displays fully
    case releaseing  //Releaseing, not refreshing, from pullingInRect state.
    case refreshing  //Releaseing, and refreshing, from pullingOutRect state.
    case noMoreData
}


//public protocol RefreshComponentProtocol{
//    func rfLayout()
//}
//* 刷新控件的基类
open class RefreshComponent: UIView{

    open var height:CGFloat = 50
    
    public var titleLabel:UILabel? //文案。默认居中。Text, center
    public var isRefreshing:Bool = false
    public var state:RefreshState = .idle
    {
        didSet{
            if state != oldValue{
//                switch state{
//                case .idle:break
//                case .pullingInRect:break
//                case .releaseing:break
//                case .refreshing:break
//                case .noMoreData:break
//                }
                refreshComponentStateChange(state: state)
            }
        }
    }
    
    public var enableRefresh:Bool = true{
        didSet{
            if isHidden == enableRefresh{
                isHidden = !enableRefresh
                
                if !enableRefresh{
                    if let scrollView = superview as? UIScrollView {
                        
                        UIView.animate(withDuration: 0.3,  animations: {
                            scrollView.contentInset = self.scrollViewInsetsDefaultValue
                        }, completion: {[weak self] finished in
                            self?.isRefreshing = false
                            self?.state = .idle
                            self?.postEndRefreshing()
                        })
                    }
                }
                
            }

        }
    }
    
    var titles:[RefreshState:String] = [RefreshState:String]()
    
    var previousOffset: CGFloat = 0
    var isFirstLoad:Bool = true //是否第一次加载
    var scrollViewBouncesDefaultValue: Bool = false
    var scrollViewInsetsDefaultValue: UIEdgeInsets = UIEdgeInsets.zero
    
    var refreshingClosure:(()->())?
    var endRefreshingClosure:(()->())?
    
    weak var refreshingTarget:AnyObject?
    var refreshingSelector:Selector?
    weak var endRefreshingTarget:AnyObject?
    var endRefreshingSelector:Selector?

   @objc public required init(refreshingClosure:@escaping ()->(), endRefreshingClosure:(()->())? = nil){
        self.refreshingClosure = refreshingClosure
        self.endRefreshingClosure = endRefreshingClosure
        self.refreshingTarget = nil
        self.refreshingSelector = nil
        self.endRefreshingTarget = nil
        self.endRefreshingSelector = nil
        super.init(frame: CGRect.zero)
    }
    
   @objc public  init(refreshingTarget:AnyObject?,refreshingSelector:Selector?, endRefreshingTarget:AnyObject? = nil,endRefreshingSelector:Selector? = nil){
        self.refreshingClosure = nil
        self.endRefreshingClosure = nil
        self.refreshingTarget = refreshingTarget
        self.refreshingSelector = refreshingSelector
        self.endRefreshingTarget = endRefreshingTarget
        self.endRefreshingSelector = endRefreshingSelector
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    deinit {
//        superview?.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset),context:nil)
//        superview?.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize),context:nil)
////        scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset) , options:  [.initial], context: nil)
////        scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize), options: [.initial], context: nil)
//    }
    
    //MARK: livecrycle
    open override func removeFromSuperview() {
        //        debugPrint("component_removeFromSuperview")
        superview?.removeObserver(self, forKeyPath:#keyPath(UIScrollView.contentOffset))
        superview?.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize))
        super.removeFromSuperview()
    }
    
    //removeFromSuperview() 后会调用
    //Invoke thie method after removeFromSuperview()
    open override func willMove(toSuperview newSuperview: UIView!) {
        
        if let scrollView = newSuperview as? UIScrollView {
            
            if #available(iOS 11.0, *) {
                scrollView.contentInsetAdjustmentBehavior = .never
                
                if let tableV = scrollView as? UITableView{
                    tableV.estimatedRowHeight = 0
                    tableV.estimatedSectionHeaderHeight = 0
                    tableV.estimatedSectionFooterHeight = 0
                }
            } else {
                //view controller
                // Fallback on earlier versions
                //            automaticallyAdjustsScrollViewInsets = false
            }
            
            scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentOffset) , options:  [.new,.old,.initial], context: nil)
            scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize), options: [.new,.old,.initial], context: nil)
            
            scrollViewBouncesDefaultValue = scrollView.bounces
            scrollViewInsetsDefaultValue = scrollView.contentInset
        }
    }
    
    open override func didMoveToSuperview() {
        if let _ = superview {
            height = refreshComponentHeight()
            titles = refreshComponentTitlesWithStates()
            refreshComponentDidMoveToSuperview()
        }
    }
    
    open func refreshComponentHeight()->CGFloat{
        return Default_Component_Height
    }
    
    open func refreshComponentTitlesWithStates() -> [RefreshState:String]{
        return [RefreshState:String]()
    }
    
    open func refreshComponentDidMoveToSuperview() {
        if self.titleLabel == nil {
            let titleLabel = UILabel()
            //        titleLabel.backgroundColor = UIColor.purple
            titleLabel.textAlignment = .center
            addSubview(titleLabel)
            
//          titleLabel.snp.makeConstraints { (make) in
//              make.edges.equalToSuperview()
//          }
            if let sView = superview{
                titleLabel.frame = CGRect(x: 0, y: 0, width: sView.frame.width, height: height) 
            }
            
            self.titleLabel = titleLabel
        }
    }
    
    
    
    //MARK: observe
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard isUserInteractionEnabled else {return}
        guard !isHidden else { return}
        guard let kPath = keyPath else {return}
        guard let scrollView = superview as? UIScrollView else{return}
        guard enableRefresh else { return }
        
        switch kPath {
        case #keyPath(UIScrollView.contentOffset):
            scrollViewContentOffsetDidChange(scrollView:scrollView, change: change)
            break
        case #keyPath(UIScrollView.contentSize):
            scrollViewContentSizeDidChange(scrollView:scrollView, change: change)
            break
        default:
            break
            
        }
    }
    
    open func scrollViewContentOffsetDidChange(scrollView:UIScrollView,change:[NSKeyValueChangeKey : Any]?){}
    
    open func scrollViewContentSizeDidChange(scrollView:UIScrollView,change:[NSKeyValueChangeKey : Any]?){}
    
    //MARK: control
    public func endRefreshing(closure:(()->())? = nil){
        self.endRefreshingClosure = closure
        self.endRefreshingTarget = nil
        self.endRefreshingSelector = nil
        endRefreshingExecute()
    }
    
    public func endRefreshing(target:AnyObject?,selector:Selector){
        self.endRefreshingClosure = nil
        self.endRefreshingTarget = target
        self.endRefreshingSelector = selector
        endRefreshingExecute()
    }
    
    func endRefreshingExecute(){
//        if isRefreshing{
            endRefreshingAnimating()
//        }
    }

    func postRefreshing(){
        DispatchOnMainQueue {[unowned self] in
            self.refreshingClosure?()
            
            if let target = self.refreshingTarget as? NSObjectProtocol,
                let selector = self.refreshingSelector,
                target.responds(to: selector){
                target.perform(selector)
            }
        }
    }
    
    func postEndRefreshing(){
        DispatchOnMainQueue {[unowned self] in
            self.endRefreshingClosure?()
            if let target = self.endRefreshingTarget as? NSObjectProtocol,
                let selector = self.endRefreshingSelector,
                target.responds(to: selector){
                target.perform(selector)
            }
        }
    }
    
    //刷新动画
    func refreshingAnimating() {}
    
    //结束刷新动画
    func endRefreshingAnimating(state:RefreshState = .idle) {}
    
    //MARK: State
    open func refreshComponentStateChange(state: RefreshState) {
        
        switch state{
        case .idle:
            titleLabel?.text = titles[state]
            break
        case .pullingInRect:
            titleLabel?.text =   titles[state]
            break
        case .pullingOutRect:
            titleLabel?.text =   titles[state]
            break
        case .releaseing:
            titleLabel?.text =  titles[state]
            break
        case .refreshing:
            titleLabel?.text =  titles[state]
            break
        case .noMoreData: //footer有
            titleLabel?.text = titles[state]
            
        default:
            titleLabel?.text =   titles[.idle]
            break
        }
        
    }


   public  func setTitle(_ title:String?,for state:RefreshState){
        titles[state] = title
    }
    
}

