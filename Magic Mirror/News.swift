//
//  News.swift
//  Magic Mirror
//

import Foundation
import Alamofire
import SwiftyJSON

class News {
    
    let newsApiKey = "abc"
    let newsCountry = "us"
    func getNews(newsCountry:String) {
        // Get latest headlines from News API
        Alamofire.request("https://newsapi.org/v2/top-headlines?country=\(newsCountry)&pageSize=3&apiKey=\(newsApiKey)").responseJSON {
            response in
            if let responseStr = response.result.value {
                let jsonResponse = JSON(responseStr)
                for item in jsonResponse["articles"].arrayValue {
                    print(item["title"].stringValue)
                }
            }
        }
    }

}
