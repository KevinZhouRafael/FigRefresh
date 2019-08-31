//
//  DefaultRefreshVC.swift
//  demo
//
//  Created by kai zhou on 2018/12/5.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import UIKit
import ZKRefresh

class CustomeRefreshVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    deinit {
        debugPrint("deinit-CustomeRefreshVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 63)
        //        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height*2)
        
        
         //One;
         // Designative header footer
         //指定 header 和 footer
//         scrollView.zk_header = RefreshImagesHeader(refreshingClosure: { [weak self] in
//         scrollView.zk_header = RefreshHeader(refreshingClosure: { [weak self] in
         scrollView.zk_header = RefreshIndicatorHeader(refreshingClosure: { [weak self] in
             DispatchQueue.global().async {
                sleep(3)
                DispatchQueue.main.async {
                    self?.scrollView.zk_header?.endRefreshing()
                }
            }
         })
         
//         scrollView.zk_footer = RefreshFooter(refreshingClosure: {
         scrollView.zk_footer = RefreshIndicatorFooter(refreshingClosure: {
         [weak self] in
             DispatchQueue.global().async {
                sleep(3)
                DispatchQueue.main.async {
                    self?.scrollView.zk_footer?.endRefreshing()
                }
             }
         })
 

    }
    
}
