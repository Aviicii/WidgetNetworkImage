//
//  WidgetImageLoader.swift
//  ShortcutItem
//
//  Created by jekun on 2022/3/7.
//

import Foundation
import SwiftUI

class WidgetImageLoader {
    
    static var shareLoader = WidgetImageLoader()
    
    func getImage(_ imgUrlString:String) -> UIImage {
//        CoreDataStack.shared.deleteAllData()
        if let cacehImage = CoreDataStack.shared.searchData(url: imgUrlString) {
            if cacehImage.isEmpty {
                return UIImage(named: "1")!
            }else{
                return UIImage(data: cacehImage)!
            }
        }
        guard let data = try? Data(contentsOf:URL(string: imgUrlString)!) else {
            print("图片下载失败")
            return UIImage(named: "1")!
        }
        print("图片下载成功")
        CoreDataStack.shared.addData(url: imgUrlString, imageData: data)
        return UIImage(data: data)!
        
    }
    
}
