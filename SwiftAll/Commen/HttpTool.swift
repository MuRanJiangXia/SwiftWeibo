//
//  HttpTool.swift
//  SwiftAll
//
//  Created by cyan on 2018/3/27.
//  Copyright © 2018年 cyan. All rights reserved.
//

import UIKit
import Alamofire

class HttpTool {

    
    //创建单例
    static let shareIntance : HttpTool = {
        
        let tools = HttpTool()
        return  tools
    }()
    
}


extension HttpTool{
    
    //post
    func postRequest(urlString:String, params : [String : Any], finished : @escaping (_ response : [String :AnyObject]?,_ error:NSError?)->()) {
        
        
        Alamofire.request(urlString, method: .post, parameters: params)
            .responseJSON { (response)in
                
                if response.result.isSuccess{
                    
                    finished(response.result.value as? [String : AnyObject], nil)
                }else{
                    
                    finished(nil, response.result.error! as NSError)
                    
                }
        }
        
    }
    
    
    //get
    func getRequest(urlString:String,params:[String :Any],finished : @escaping(_ response : [String : AnyObject]?,_ error : NSError?) -> ()) {
        
        Alamofire.request(urlString, method: .get, parameters: params)
            .responseJSON { (response)in
                
                if response.result.isSuccess{
                    
                    finished(response.result.value as? [String : AnyObject], nil)
                    
                }else{
                    
                    finished(nil, response.result.error! as NSError)
                    
                    
                }
        }
        
    }
    
    
}
