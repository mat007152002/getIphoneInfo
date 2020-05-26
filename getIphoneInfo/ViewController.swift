//
//  ViewController.swift
//  getIphoneInfo
//
//  Created by 旌榮 凌 on 2020/5/26.
//  Copyright © 2020 旌榮 凌. All rights reserved.
//

import UIKit
import SystemConfiguration

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = UIDevice.current.name
        let udid = UIDevice.current.identifierForVendor?.uuidString
        let sname = UIDevice.current.systemName
        let version = UIDevice.current.systemVersion
        let deviceOS = sname+" "+version
        let devicemodel = UIDevice.current.model.description
          
        print(name) //phone type
        print(udid ?? "") //user device id
        print(deviceOS) //deviceOS
        print(devicemodel) //devicemodel
        
        let data = DataModel()
        data.name = name
        data.udid = udid ?? ""
        data.deviceOS = deviceOS
        data.devicemodel = devicemodel
        
        let jsondata = try? JSONEncoder().encode(data)
        
        postAPIdata(jsondata: jsondata!)
        
    }
    
    class DataModel : Codable{
        var name = ""
        var udid = ""
        var deviceOS = ""
        var devicemodel = ""
    }

    
    func postAPIdata(jsondata: Data){
        let resourceString = "https://cloud.mds.com.tw/WistronMobile/SysFun/WebService/LoginChk_Test.aspx"
        let url = URL(string: resourceString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = jsondata
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if(error != nil){
                print("發送失敗 ", error!.localizedDescription)
            }
            else{
                print("發送成功")
                let str = String(data: data!, encoding: .utf8)
                print(str ?? "")
            }
        }
        task.resume()
    }
}

