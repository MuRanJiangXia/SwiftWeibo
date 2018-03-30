//
//  CYTools.swift
//  SwiftAll
//
//  Created by cyan on 2018/3/28.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit


class CYTools{

}



extension CYTools{
   //类方法
    // MARK: -    Wed Mar 28 11:01:46 +0800 2018 --> yyyy-MM-dd
   static func getYearAndMonthByYear(time : String) -> String {
        let form = DateFormatter()
        form.dateFormat = "EE MM dd HH:mm:ss Z yyyy"
        let date = form.date(from: time)
        form.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return form.string(from: date!)
    }
    
    /// 根据时间和当前时间做判断，返回处理的时间 
    ///
    /// - Parameter theDate: 时间
    /// - Returns: 比较后的时间字符串
    static func compareCurentTime(theDate : String) -> NSString{
        let formate = DateFormatter()
        formate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let compareDate = formate.date(from: theDate)
        var timeInterval:TimeInterval = (compareDate?.timeIntervalSinceNow)!
        timeInterval = -timeInterval
        var result = NSString()
        var temp = NSInteger()

        if (timeInterval < 60) {
            result = NSString.init(format: "刚刚")
        }
        else if timeInterval < 60 * 60 {
            temp = NSInteger(timeInterval / 60)
            result = NSString.init(format: "%ld分钟前", temp)
        }else if timeInterval < 60 * 60 * 24 {
            temp = NSInteger(timeInterval / (60 * 60 ))
            result = NSString.init(format: "%ld小时前", temp)

        }else if timeInterval < 60 * 60 * 24 * 30{
            temp = NSInteger(timeInterval / (60 * 60 * 24))
            result = NSString.init(format: "%ld天前", temp)
            
        }else{
            return theDate as NSString
        }
        return result as NSString
    
    }
    // MARK: -  根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
    static func getHeightWithContent(content : NSString , width : CGFloat , font : CGFloat) -> CGFloat{
        let rect = content.boundingRect(with:  CGSize(width: width, height: 999), options: .usesLineFragmentOrigin, attributes:   [NSAttributedStringKey.font:UIFont.systemFont(ofSize: font)], context: nil)
        
        return rect.height
    }
    
    // MARK: -  根据宽高度求宽度  content 计算的内容  width 计算的宽度 font字体大小
    static func getWidthWithContent(content : NSString , height : CGFloat , font : CGFloat) -> CGFloat{
        let rect = content.boundingRect(with:  CGSize(width: 999, height: height), options: .usesLineFragmentOrigin, attributes:   [NSAttributedStringKey.font:UIFont.systemFont(ofSize: font)], context: nil)
        
        return rect.width
    }
    
}

//存取json文件
extension CYTools{
    
    /// 根据json文件名写入json
    ///
    /// - Parameters:
    ///   - jsonObject: jsonobjec（字典数组对象）
    ///   - name: json文件名
    /// - Returns: 是否写入成功
   static func writeJson(jsonObject : AnyObject , name : NSString) -> Bool {
        var  sp = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .allDomainsMask, true)
        let jsonName = NSString.init(format: "%@/%@.json", sp[0], name)
        let jsonData:NSData = try! JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) as NSData
        return  jsonData.write(toFile: jsonName as String, atomically: true)
    }
    
    
    
    /// 根据json文件名 读取json
    ///
    /// - Parameter name: json名
    /// - Returns: jsonobjec（字典数组对象）
   static func readJson(name : NSString) -> AnyObject {
        var  sp = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .allDomainsMask, true)
        let jsonName = NSString.init(format: "%@/%@.json", sp[0], name)
        let data:NSData
        do {
            data =   try NSData.init(contentsOfFile: jsonName as String)
        } catch let err as NSError {
            print("err:\(err.description)")
            return NSNull()

        }
    
        guard   let jsonObject = try?JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) else {
            return NSNull()
        }
        return jsonObject as AnyObject
    }
    
}
