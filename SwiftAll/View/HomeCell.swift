//
//  HomeCell.swift
//  SwiftAll
//
//  Created by cyan on 2018/3/27.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell , WXLabelDelegate {
    
    var weiboModel : WeiBoModel!{
        willSet{

        }
        didSet{
            self.userNameLab.text = self.weiboModel.user.screen_name! as String
            let userUrl :URL = URL(string: self.weiboModel.user.profile_image_url! as String)!
            self.userImageV.sd_setImage(with:userUrl, placeholderImage: nil, options: .highPriority, completed: nil)
            let  time = CYTools.getYearAndMonthByYear(time: self.weiboModel.created_at! as String)
            self.timeLab.text = CYTools.compareCurentTime(theDate: time) as String
            let source = self.weiboModel.source
            if self.weiboModel.source.length == 0 || self.weiboModel.source == nil{
                 self.sourceLab.text = "来自未知应用"

            }else{
                //XMLDictionary 转一下
                let soureceDic =   NSDictionary.init(xmlString: source! as String)
                let phoneSourece = soureceDic?.object(forKey: "__text")
                self.sourceLab.text = NSString.init(format: "来自%@",phoneSourece! as! String) as String
            }
    
            self.contetLab.text = self.weiboModel.text as String?
            self.repostBtn.setTitle(self.weiboModel.reposts_count.stringValue , for: .normal)
            self.commentBtn.setTitle(self.weiboModel.comments_count.stringValue, for: .normal)
            self.attitudeBtn.setTitle(self.weiboModel.attitudes_count.stringValue, for: .normal)
    
            layoutSubviews()
        }

    }
    //文本
    var contetLab: WXLabel!
    //用户头像
    var userImageV: UIImageView!
    //用户昵称
    var userNameLab: UILabel!
    //发博时间
    var timeLab: UILabel!
    //手机型号
    var sourceLab: UILabel!
    //转发数
    var repostBtn :UIButton!
    //评论数
    var commentBtn :UIButton!
    //表态数
    var attitudeBtn :UIButton!
    //分割线
    var lineView : UIView!
    //cell分割view
    var cellSegmentationView : UIView!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        creatUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.userImageV.layer.cornerRadius = 45/2
        self.userImageV.layer.masksToBounds = true
        self.userImageV.layer.borderColor = RGBColor(248, g: 248, b: 248).cgColor
        self.userImageV.layer.borderWidth = 1
        
        self.reloadLayout()

    }

    
    func creatUI()  {
        
        self.userImageV = UIImageView()
//        self.userImageV.backgroundColor = UIColor.cyan
        self.contentView.addSubview(self.userImageV)

        
        self.userNameLab = UILabel()
//        self.userNameLab.backgroundColor = UIColor.red
        self.userNameLab.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(self.userNameLab)
        
        self.timeLab = UILabel()
//        self.timeLab.backgroundColor = UIColor.gray
        self.timeLab.font = UIFont.systemFont(ofSize: 10)
        self.timeLab.textColor = RGBColor(195, g: 195, b: 195)
        self.contentView.addSubview(self.timeLab)
        
        self.sourceLab = UILabel()
//        self.sourceLab.backgroundColor = UIColor.brown
        self.sourceLab.font = UIFont.systemFont(ofSize: 10)
        self.sourceLab.textColor = RGBColor(147, g: 163, b: 184)
        self.contentView.addSubview(self.sourceLab)
        
        self.contetLab = WXLabel()
//        self.contetLab.backgroundColor = UIColor.orange
        self.contetLab.font = UIFont.systemFont(ofSize: 14)
        self.contetLab.numberOfLines = 0
        self.contetLab.wxLabelDelegate = self
        self.contentView.addSubview(self.contetLab)
        
        
        self.repostBtn = UIButton(type: .custom)
        self.repostBtn.setTitle("转发", for: .normal)
//        self.repostBtn.backgroundColor = UIColor.orange
        self.repostBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.repostBtn.setTitleColor(RGBA(129, g: 129, b: 129, a: 1), for: .normal)
        self.repostBtn.setImage(UIImage(named: "artical_detail_icon_repost"), for: .normal)
//        button.addTarget(self, action: #selector(<#action#>), for:.touchUpInside)
        self.contentView.addSubview(self.repostBtn)
        
        self.commentBtn = UIButton(type: .custom)
        self.commentBtn.setTitle("评论", for: .normal)
//        self.commentBtn.backgroundColor = UIColor.green
        self.commentBtn.setTitleColor(RGBA(129, g: 129, b: 129, a: 1), for: .normal)
        self.commentBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.commentBtn.setImage(UIImage(named: "artical_detail_icon_comment"), for: .normal)
        //        button.addTarget(self, action: #selector(), for:.touchUpInside)
        self.contentView.addSubview(self.commentBtn)
        
        
        self.attitudeBtn = UIButton(type: .custom)
        self.attitudeBtn.setTitle("赞", for: .normal)
//        self.attitudeBtn.backgroundColor = UIColor.orange
        self.attitudeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.attitudeBtn.setTitleColor(RGBA(129, g: 129, b: 129, a: 1), for: .normal)
        self.attitudeBtn.setTitleColor(RGBColor(210, g: 84, b: 82), for: .selected)
        self.attitudeBtn.setImage(UIImage(named: "artical_detail_icon_like"), for: .normal)
        self.attitudeBtn.setImage(UIImage(named: "artical_detail_icon_liked"), for: .selected)
        self.contentView.addSubview(self.attitudeBtn)
        
        self.lineView = UIView()
        self.lineView.backgroundColor = RGBColor(243, g: 243, b: 243)
        self.contentView.addSubview(self.lineView)
        
        self.cellSegmentationView = UIView()
        self.cellSegmentationView.backgroundColor = RGBColor(238, g: 238, b: 238)
        self.contentView.addSubview(self.cellSegmentationView)
        
    }
    
    
    func reloadLayout() {
        
        self.userImageV.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.width.equalTo(45)
            make.height.equalTo(45)
        }
        self.userNameLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.userImageV.snp.right).offset(10)
            make.top.equalTo(self.userImageV)
            make.right.equalTo(self.snp.right).offset(-10)
            make.height.equalTo(15)
            
        }
        //根据字符串设置宽度
        let width =  CYTools.getWidthWithContent(content: self.timeLab.text! as NSString, height: 10, font: 10)
        self.timeLab.frame = CGRect(x: self.timeLab.frame.minX, y: self.timeLab.frame.minY, width: width, height: self.timeLab.frame.height)
        self.timeLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.userNameLab)
            make.top.equalTo(self.userNameLab.snp.bottom).offset(5)
            make.width.equalTo(width).priority(.high)
            make.height.equalTo(10)
        }
        self.sourceLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.timeLab.snp.right).offset(5)
            make.top.equalTo(self.timeLab)
            make.right.equalTo(self.userNameLab)
            make.height.equalTo(10)
        }
//
        self.contetLab.snp.makeConstraints { (make) in
            make.left.equalTo(self.userImageV)
            make.top.equalTo(self.userImageV.snp.bottom).offset(5)
            make.right.equalTo(self.userNameLab)
            make.bottom.equalTo(self.lineView.snp.top).offset(-5)
        }
        
        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.userImageV)
            make.top.equalTo(self.contetLab.snp.bottom).offset(5)
            make.right.equalTo(self.contetLab)
            make.height.equalTo(1)
        }
        let btnWidth = (kScreenWidth - 20)/3
        
        self.repostBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.userImageV)
            make.top.equalTo(self.lineView.snp.bottom).offset(5)
            make.width.equalTo(btnWidth)
            make.height.equalTo(33)
        }
        
        self.commentBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.repostBtn.snp.right)
            make.top.equalTo(self.repostBtn)
            make.width.equalTo(btnWidth)
            make.height.equalTo(33)

        }
        
        self.attitudeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.commentBtn.snp.right)
            make.top.equalTo(self.repostBtn)
            make.width.equalTo(btnWidth)
            make.height.equalTo(33)
   
        }
        

        self.cellSegmentationView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.top.equalTo(self.attitudeBtn.snp.bottom)
            make.right.equalTo(self.contentView)
            make.height.equalTo(10)
        }
    
    }
    
    // MARK: -  WXLabelDelegate
    func contentsOfRegexString(with wxLabel: WXLabel!) -> String! {
        //@用户
        let regix = "(@[\\w-]+)"
        //http:
        let regix2 = "(http(s)?://([A-Za-z0-9._-]+(/)?)+)"
        //#话题#
        let regix3 = "(#[\\w]+#)"
        let finalRegix = NSString.init(format: "%@|%@|%@", regix,regix2,regix3)
        
        return finalRegix as String!
    }
    func linkColor(with wxLabel: WXLabel!) -> UIColor! {
        return UIColor.cyan
    }
    
    //用来计算布局 给cell高度 
    func heightForModel(weiboModel : WeiBoModel) -> CGFloat {
        self.weiboModel = weiboModel
        self.layoutIfNeeded()
//        let cellHeight = self.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height + 1
        
        return self.cellSegmentationView.frame.maxY
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
