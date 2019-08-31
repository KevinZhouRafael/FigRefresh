//
//  DefaultRefreshVC.swift
//  demo
//
//  Created by kai zhou on 2018/12/5.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import UIKit
import ZKRefresh

class DefaultRefreshVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    deinit {
        debugPrint("deinit-DefaultRefreshVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 63)
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height*2)
        
        //Two:
        //默认 header 和 footer
        //Set Default Header and Footer
        
        ZKRefreshSetDefaultHeader(RefreshImagesHeader.self)
        ZKRefreshSetDefaultFooter(RefreshFooter.self)
        
        scrollView.zk_header {
            DispatchQueue.global().async {  [weak self] in
                sleep(3)
                DispatchQueue.main.async {
                    self?.scrollView.zk_header?.endRefreshing()
                }
            }
        }
        scrollView.zk_footer { [weak self] in
            DispatchQueue.global().async {
                sleep(3)
                DispatchQueue.main.async {
                    self?.scrollView.zk_footer?.endRefreshing()
                }
            }
        }
    }

}
