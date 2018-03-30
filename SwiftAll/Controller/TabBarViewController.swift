//
//  TabBarViewController.swift
//  SwiftAll
//
//  Created by cyan on 2018/3/27.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let textNormalAttributes = [NSAttributedStringKey.foregroundColor:UIColorFromRGB(rgbValue: 0x333333),
             NSAttributedStringKey.font :UIFont.systemFont(ofSize: 12)]
        UITabBarItem.appearance().setTitleTextAttributes(textNormalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(textNormalAttributes, for: .selected)
        
   
        
        let homeVC = HomeViewController()
        let homeNavVC = BaseNavViewController(rootViewController: homeVC)
        homeNavVC.tabBarItem = UITabBarItem.init(title: "首页", image: self.imageWithOriginalName(imageName: "tabbar_home"), selectedImage:  self.imageWithOriginalName(imageName: "tabbar_home_selected"))

        
        let mineVC = MineViewController()
        let mineNavVC = BaseNavViewController(rootViewController: mineVC)
        mineNavVC.tabBarItem = UITabBarItem.init(title: "我的", image: self.imageWithOriginalName(imageName: "tabbar_profile"), selectedImage:  self.imageWithOriginalName(imageName: "tabbar_profile_selected"))
        
        self.viewControllers = [homeNavVC,mineNavVC]
    
        
        
        
    }

    //避免图片渲染
    func imageWithOriginalName(imageName : NSString) -> UIImage {
        var image = UIImage.init(named: imageName as String)
        image = image?.withRenderingMode(.alwaysOriginal)
        return image!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
