//
//  TableViewControllerRefreshTest.swift
//  demo
//
//  Created by kai zhou on 2018/12/11.
//  Copyright © 2018 wumingapie@gmail.com. All rights reserved.
//

import UIKit
import FigRefresh

class TableViewRefreshTest: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var count = 12
    var maxCount = 50
    var hasMore = true
    
    deinit {
        debugPrint("deinit-TableViewControllerRefreshTest")
    }
    @IBAction func enableRefresh(_ sender: Any) {
        tableView.fig_header?.enableRefresh = true
        tableView.fig_footer?.enableRefresh = true
    }
    @IBAction func disableRefresh(_ sender: Any) {
        tableView.fig_header?.enableRefresh = false
        tableView.fig_footer?.enableRefresh = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.fig_header = RefreshImagesHeader(refreshingClosure: { [weak self] in
            DispatchQueue.global().async {
                self?.count = 12
                sleep(3)
                DispatchQueue.main.async {
                    
                    self?.tableView.reloadData()

                    self?.tableView.fig_header?.endRefreshing()
//                    self?.tableView.fig_footer?.resetNoMoreData()
                    
//                    self?.tableView.fig_header?.enableRefresh = false
                    
//                    self?.tableView.fig_header?.endRefreshingWithResetFooter()//底层自动调用footer的setNoMoreData()
                }
            }
        })

        tableView.fig_footer = RefreshIndicatorFooter(refreshingTarget: self, refreshingSelector: #selector(requestLoadMore))
        
//        tableView.fig_footer?.setTitle("没有更多了", for: .noMoreData)
//        tableView.fig_footer?.endRefreshingWithNoMoreData()
    }

    @objc func requestLoadMore(){
        
        DispatchQueue.global(qos: .background).async {[weak self] in
            
            let c = self!.count + 12
            if c >= self!.maxCount {
                self!.hasMore = false
                self?.count = self!.maxCount
            }else{
                self!.hasMore = true
                self?.count += 12
            }
            
            sleep(3)
            DispatchQueue.main.async {
                debugPrint("load more once")
                self?.tableView.reloadData()
                
                if self?.hasMore ?? true{
                    //执行多次，会显示最后一次设置的
//                    self?.tableView.fig_footer?.endRefreshingWithNoMoreData()
//                    self?.tableView.fig_footer?.endRefreshing()
                    self?.tableView.fig_footer?.endRefreshingWithNoMoreData()
                    self?.tableView.fig_footer?.endRefreshing()
                }else{
                    self?.tableView.fig_footer?.endRefreshingWithNoMoreData()
                    // self?.tableView.fig_footer?.enableRefresh = false
                }
            }
        }
    }
    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }

    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "REFRESH_CELL", for: indexPath)

        cell.textLabel?.text = "\(indexPath.row + 1) data"
        return cell
    }
 


}
