//
//  MineHeaderCell.swift
//  SwiftAll
//
//  Created by cyan on 2018/3/29.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit

class MineHeaderCell: UITableViewCell {
    
    //头像
    var userImageV:UIImageView!
    //昵称
    var userNameLab:UILabel!
    //简介
    var introductionLab:UILabel!
    //分割线
    var lineView:UIView!
    //微博数
    var weiboCountLab:UILabel!
    //关注数
    var focusLab:UILabel!
    //粉丝
    var funsLab:UILabel!
    
    var userModel : UserModel!{
        willSet{
            
        }
        didSet{
            let userUrl :URL = URL(string: self.userModel.profile_image_url! as String)!
            self.userImageV.sd_setImage(with: userUrl, placeholderImage: nil, options: .highPriority, completed: nil)
            self.userNameLab.text = userModel.screen_name! as String
            self.introductionLab.text = NSString.init(format: "简介:%@",  self.userModel.descriptionUser) as String
            self.weiboCountLab.text = NSString.init(format: "%@\n微博", self.userModel.statuses_count.stringValue) as String
            self.focusLab.text = NSString.init(format: "%@\n关注", self.userModel.friends_count.stringValue) as String
            self.funsLab.text = NSString.init(format: "%@\n粉丝", self.userModel.followers_count.stringValue) as String
                
            
            
        
        }
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatUI()
        reloadLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.userImageV.layer.cornerRadius = 60/2
        self.userImageV.layer.masksToBounds = true
        self.userImageV.layer.borderColor = RGBColor(248, g: 248, b: 248).cgColor
        self.userImageV.layer.borderWidth = 1
        
    }
    
    
    func creatUI(){
        
        self.userImageV = UIImageView()
//        self.userImageV.backgroundColor = UIColor.cyan
        self.contentView.addSubview(self.userImageV)
        
        
        self.userNameLab = UILabel()
//        self.userNameLab.backgroundColor = UIColor.red
        self.userNameLab.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(self.userNameLab)
        
        
        self.introductionLab = UILabel()
//        self.introductionLab.backgroundColor = UIColor.orange
        self.introductionLab.font = UIFont.systemFont(ofSize: 15)
        self.introductionLab.textColor = RGBColor(173, g: 173, b: 173)
        self.contentView.addSubview(self.introductionLab)
        
        self.weiboCountLab = UILabel()
//        self.weiboCountLab.backgroundColor = UIColor.green
        self.weiboCountLab.font = UIFont.systemFont(ofSize: 14)
        self.weiboCountLab.numberOfLines = 2
        self.weiboCountLab.textAlignment = .center
        self.contentView.addSubview(self.weiboCountLab)
        
        self.focusLab = UILabel()
//        self.focusLab.backgroundColor = UIColor.gray
        self.focusLab.font = UIFont.systemFont(ofSize: 14)
        self.focusLab.numberOfLines = 2
        self.focusLab.textAlignment = .center
        self.contentView.addSubview(self.focusLab)
        
        self.funsLab = UILabel()
//        self.funsLab.backgroundColor = UIColor.red
        self.funsLab.font = UIFont.systemFont(ofSize: 14)
        self.funsLab.numberOfLines = 2
        self.funsLab.textAlignment = .center
        self.contentView.addSubview(self.funsLab)
        
        self.lineView = UIView()
        self.lineView.backgroundColor = RGBColor(243, g: 243, b: 243)
        self.contentView.addSubview(self.lineView)
        
    }

    func reloadLayout() {
        self.userImageV.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        self.userNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.userImageV.snp.right).offset(10)
            make.top.equalTo(self.userImageV)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(15)
            
        }
        self.introductionLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.userNameLab)
            make.top.equalTo(self.userNameLab.snp.bottom).offset(10)
            make.right.equalTo(self.userNameLab)
            make.height.equalTo(14)
        }
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(5)
            make.top.equalTo(self.userImageV.snp.bottom).offset(5)
            make.right.equalTo(self).offset(-5)
            make.height.equalTo(1)
        }
        let btnWidth = (kScreenWidth - 20)/3

        self.weiboCountLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.userImageV)
            make.top.equalTo(self.lineView.snp.bottom).offset(5)
            make.width.equalTo(btnWidth)
            make.height.equalTo(36)
        }
        
        self.focusLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.weiboCountLab.snp.right)
            make.top.equalTo(self.weiboCountLab)
            make.width.equalTo(btnWidth)
            make.height.equalTo(36)
            
        }
        
        self.funsLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.focusLab.snp.right)
            make.top.equalTo(self.weiboCountLab)
            make.width.equalTo(btnWidth)
            make.height.equalTo(36)
            
        }
        
    }
 
}
