//
//  BaseViewController.swift
//  SwiftAll
//
//  Created by cyan on 2018/3/27.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit
import MBProgressHUD
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: -  MBProgressHUD
    
    /// 提示加载MB
    ///
    /// - Parameter aView: 添加到的 view
    func showLoadingWithView(aView : UIView){
        let hud = MBProgressHUD.showAdded(to: aView, animated: true)
        hud.label.text = "加载中…"
        hud.label.font = UIFont.systemFont(ofSize: 14)
        
    }
    
     /// 隐藏MB
     ///
     /// - Parameter aView: 添加到的 view
     func hideLoadingWithView(aView : UIView){
        MBProgressHUD.hide(for: aView, animated: true)

    }



}
