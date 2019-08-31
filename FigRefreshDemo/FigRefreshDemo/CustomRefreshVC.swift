//
//  DefaultRefreshVC.swift
//  demo
//
//  Created by kai zhou on 2018/12/5.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import UIKit
import FigRefresh

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
//         scrollView.fig_header = RefreshImagesHeader(refreshingClosure: { [weak self] in
//         scrollView.fig_header = RefreshHeader(refreshingClosure: { [weak self] in
         scrollView.fig_header = RefreshIndicatorHeader(refreshingClosure: { [weak self] in
             DispatchQueue.global().async {
                sleep(3)
                DispatchQueue.main.async {
                    self?.scrollView.fig_header?.endRefreshing()
                }
            }
         })
         
//         scrollView.fig_footer = RefreshFooter(refreshingClosure: {
         scrollView.fig_footer = RefreshIndicatorFooter(refreshingClosure: {
         [weak self] in
             DispatchQueue.global().async {
                sleep(3)
                DispatchQueue.main.async {
                    self?.scrollView.fig_footer?.endRefreshing()
                }
             }
         })
 

    }
    
}
