//
//  MineViewController.swift
//  SwiftAll
//
//  Created by cyan on 2018/3/27.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit

class MineViewController: BaseViewController , UITableViewDelegate ,UITableViewDataSource{

    
    var  mineTableView : UITableView!
    var  userModel : UserModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        creatUI()
        getMineInfo()
         //做本地存储用
//        let json = CYTools.readJson(name: "mineJson")
//        if json is NSNull {
//            getMineInfo()
//        }else{
//            self.userModel = UserModel()
//            self.userModel.setValuesForKeys(json as! [String : Any])
//            self.mineTableView.reloadData()
//        }
    }
    //懒加载sinaweibo
    lazy var sinaweibo :SinaWeibo = {
        () -> SinaWeibo in
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return AppDelegate.sinaweibo
    }()
    
    // MARK: -  获取用户信息
    func getMineInfo()  {
        let url = NSString.init(format: "%@%@", BASEURL,UserPersonalInformationURL)
        let paramter:NSDictionary = ["access_token":self.sinaweibo.accessToken,
                        "uid":self.sinaweibo.userID,
                        "screen_name":"",
                        ]
        
        HttpTool.shareIntance.getRequest(urlString: url as String, params: paramter as! [String : Any], finished: { (response:[String:AnyObject]?, error:NSError?) in
        
            let dic = response! as NSDictionary
            let errorStr = dic.object(forKey: "error")
            if (errorStr != nil){
                let error_code = dic.object(forKey: "error_code")
                print("errorStr : \(String(describing: errorStr)),error_code : \(String(describing: error_code))")
            }else{
            
                self.userModel = UserModel()
                self.userModel.setValuesForKeys(dic as! [String : Any])
                self.mineTableView.reloadData()
            }
       
            
  
        })
    }
    

    func creatUI()  {
        
        self.mineTableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
        //         self.homeTableView.backgroundColor = UIColor.yellow
        self.mineTableView.delegate = self
        self.mineTableView.dataSource = self
        self.mineTableView.register(MineHeaderCell.classForCoder(), forCellReuseIdentifier: "MineHeaderCell")
        self.mineTableView.separatorStyle = .none
        self.mineTableView.estimatedRowHeight = 175;
        self.view.addSubview( self.mineTableView)
    }
    // MARK: -  UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MineHeaderCell = tableView.dequeueReusableCell(withIdentifier: "MineHeaderCell", for: indexPath) as! MineHeaderCell
        if self.userModel != nil{
            cell.userModel = self.userModel
        }
        return cell
  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
