//
//  HomeViewController.swift
//  SwiftAll
//
//  Created by cyan on 2018/3/27.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit
import SnapKit
import MJRefresh

class HomeViewController: BaseViewController ,SinaWeiboRequestDelegate,UITableViewDelegate,UITableViewDataSource{
  
    
    var  cellArr = NSMutableArray()
    var  homeTableView : UITableView!
    var  layoutCell : HomeCell!
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    //get请求字典
    var paramterDic:NSMutableDictionary!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页"
        self.view.backgroundColor = UIColor.white
        
        creatUI()
        initConFigure()
        self.layoutCell = HomeCell.init(style: UITableViewCellStyle(rawValue: 0)!, reuseIdentifier: "HomeCell")
        
        if self.sinaweibo.isAuthValid() {
//             headerAction()
            //做本地存储用
            let json = CYTools.readJson(name: "homeJson")
            if json is NSNull  {
                headerAction()

            }else{
                let jsonArr:NSArray = json as! NSArray
                jsonArr.enumerateObjects { (obj, int, stop) in
                    let weiboModel:WeiBoModel = WeiBoModel()
                    weiboModel.setValuesForKeys(obj as! [String : Any])
                    self.cellArr.add(weiboModel)
                }
                self.homeTableView.reloadData()
            }
        }else{
            
            self.sinaweibo.logIn()
        }
  

      
    }
    
    func initConFigure() {
        //下拉刷新
        header.setRefreshingTarget(self, refreshingAction: #selector(headerAction))
        self.homeTableView.mj_header = header
        
        //上拉刷新
        footer.setRefreshingTarget(self, refreshingAction: #selector(footerAction))
        self.homeTableView.mj_footer = footer
    
    }
    
    func creatUI()  {
   
        self.homeTableView = UITableView.init(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
//         self.homeTableView.backgroundColor = UIColor.yellow
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.register(HomeCell.classForCoder(), forCellReuseIdentifier: "HomeCell")
        self.homeTableView.separatorStyle = .none
        self.homeTableView.estimatedRowHeight = 175;
        self.view.addSubview( self.homeTableView)
    }
    
    //懒加载sinaweibo
    lazy var sinaweibo :SinaWeibo = {
        () -> SinaWeibo in
        let AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return AppDelegate.sinaweibo
    }()
    
    // MARK: -  UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:HomeCell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.weiboModel = self.cellArr[indexPath.row] as? WeiBoModel
        cell.attitudeBtn.addTarget(self, action: #selector(attitudeAction(btn:)), for: .touchUpInside)
        cell.attitudeBtn.tag = 2018 + indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model:WeiBoModel = self.cellArr[indexPath.row] as! WeiBoModel
        if  model.cellHeight == 0{
        model.cellHeight = self.layoutCell.heightForModel(weiboModel: model)
        }
        return model.cellHeight
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    // MARK: -  点赞方法
    @objc func attitudeAction(btn : UIButton){

        let row = btn.tag - 2018
        let model:WeiBoModel = self.cellArr[row] as! WeiBoModel
        model.isFavourite = NSNumber.init(value: !model.isFavourite.boolValue)
        btn.isSelected = model.isFavourite.boolValue
        
        if  model.isFavourite.boolValue {
            //动画
            let keyAnimation = CAKeyframeAnimation.init()
            keyAnimation.keyPath  = "transform.rotation"
            let angle = Double.pi/10
            let values = [(-angle),(0)]
            keyAnimation.values = values
            keyAnimation.duration = 0.2
            keyAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
            keyAnimation.autoreverses = true
            btn.imageView?.layer.add(keyAnimation, forKey: "attitudemove")
        }
        
        
    }
    
    
    // MARK: -  上下拉刷新方法
    //下拉刷新
    @objc func headerAction(){
        self.cellArr = NSMutableArray()
        let since_id : NSString!
        if self.cellArr.count > 0{
            let weiboModel:WeiBoModel = self.cellArr.firstObject as! WeiBoModel
            since_id = weiboModel.id
        }else{
            since_id = "0"
        }
        let dic:NSDictionary = ["count":"20",
                                "access_token":self.sinaweibo.accessToken,
                                "since_id":since_id
        ]
        self.paramterDic = dic.mutableCopy() as! NSMutableDictionary
        self.getWeiBo()
    }
    //上拉刷新
    @objc func footerAction(){
        let max_id : NSString!
        if self.cellArr.count > 0{
            let weiboModel:WeiBoModel = self.cellArr.lastObject as! WeiBoModel
            max_id = weiboModel.id
        }else{
            max_id = "0"
        }
        let dic:NSDictionary = ["count":"20",
                                "access_token":self.sinaweibo.accessToken,
                                "max_id":max_id
                                ]
        self.paramterDic = dic.mutableCopy() as! NSMutableDictionary
        self.getWeiBo()

    }
    // MARK: -  获取微博
     @objc func getWeiBo() {
        
        if self.sinaweibo.isAuthValid() {
            let url = NSString.init(format: "%@%@", BASEURL,HomeTimeLineURL)
            self.showLoadingWithView(aView: self.view)
            HttpTool.shareIntance.getRequest(urlString: url as String, params: self.paramterDic as! [String : Any], finished: { (response:[String:AnyObject]?, error:NSError?) in
                self.homeTableView.mj_header.endRefreshing()
                self.homeTableView.mj_footer.endRefreshing()
                self.hideLoadingWithView(aView: self.view)
                let dic = response! as NSDictionary
                let errorStr = dic.object(forKey: "error")
                if (errorStr != nil){
                    let error_code = dic.object(forKey: "error_code")
                    print("errorStr : \(String(describing: errorStr)),error_code : \(String(describing: error_code))")
                }else{
                    
                    let status:NSArray = dic.object(forKey: "statuses") as! NSArray
                    if self.cellArr.count > 0 { //返回的是包含最后一条的数据，不添加到数组
                        self.cellArr.removeLastObject()
                    }
                    
//                    let isWrite =  CYTools.writeJson(jsonObject: status as AnyObject, name: "homeJson")
//                    print(isWrite)
                    status.enumerateObjects { (obj, int, stop) in
                        let weiboModel:WeiBoModel = WeiBoModel()
                        weiboModel.setValuesForKeys(obj as! [String : Any])
                        self.cellArr .add(weiboModel)
                    }
                    
                    self.homeTableView.reloadData()
                }
        
            })
        }else{
            self.sinaweibo.logIn()
        }
   
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
