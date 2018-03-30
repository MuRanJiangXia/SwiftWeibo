//
//  WeiBoModel.swift
//  SwiftAll
//
//  Created by cyan on 2018/3/27.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit



class WeiBoModel: NSObject {
    
    //微博创建时间
    @objc var created_at : NSString!
    //微博ID
    @objc var id : NSString!
    //微博来源
    @objc var source : NSString!
    //微博信息内容
    @objc var text : NSString!
    //缩略图片地址，没有时不返回此字段
    @objc var thumbnail_pic : NSString!
    //微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。
    @objc var pic_ids : NSString!
    //转发数
    @objc var reposts_count : NSNumber!
    //评论数
    @objc var comments_count : NSNumber!
    //表态数
    @objc var attitudes_count : NSNumber!
    //是否点赞
    @objc var isFavourite : NSNumber!
    
    @objc var user : UserModel!
    //cell高度
    var   cellHeight : CGFloat = 0.0
    
    override init() {
        super.init()
        self.isFavourite = NSNumber.init(value: 0)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
      
   
    
   }
    
    override func setValue(_ value: Any?, forKey key: String) {
        super.setValue(value, forKey: key)
        if key == "user" {
            self.user = UserModel()
            self.user.setValuesForKeys(value as! [String : Any])
            
        }
    }

    
  
}




class UserModel: NSObject {
    
   
    //用户ID
    @objc var id : NSString!
    //用户昵称
    @objc var screen_name : NSString!
    //用户头像地址（中图），50×50像素
    @objc var profile_image_url : NSString!
    //description 用户个人描述
    @objc var descriptionUser:String!
    //statuses_count 微博数
    @objc var statuses_count:NSNumber!
    //followers_count 粉丝数
    @objc var followers_count:NSNumber!
    //friends_count 关注数
    @objc var friends_count:NSNumber!
    //follow_me 该用户是否关注当前登录用户，true：是，false：否
    @objc var follow_me:NSNumber!

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "description" {
            self.descriptionUser = value as! String 
        }
        
        
    }
    
}




