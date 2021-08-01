//
//  ApiClieent.swift
//  Good Game
//
//  Created by oratakashi on 14/07/21.
//

import Foundation

struct ApiClient {
    func getRequest(endpoint: ApiEndpoint, query: [URLQueryItem] = [],  pageSize: String = Config().pageSize) -> URLRequest {
        var components = URLComponents(string: Config().baseUrl + endpoint.values())!
        var tmpQuery = query
        if query.count == 0 {
            components.queryItems = [
                URLQueryItem(name: "key", value: Config().apiKey),
                URLQueryItem(name: "platforms", value: "4")
            ]
            
            if pageSize == Config().pageSize {
                components.queryItems?.append(URLQueryItem(name: "page_size", value: Config().pageSize))
            }else if pageSize != "0"{
                components.queryItems?.append(URLQueryItem(name: "page_size", value: pageSize))
            }
        } else {
            tmpQuery.append(URLQueryItem(name: "key", value: Config().apiKey))
            tmpQuery.append(URLQueryItem(name: "platforms", value: "4"))
            print(tmpQuery)
            components.queryItems = tmpQuery
            if pageSize == Config().pageSize {
                components.queryItems?.append(URLQueryItem(name: "page_size", value: Config().pageSize))
            }else if pageSize != "0"{
                components.queryItems?.append(URLQueryItem(name: "page_size", value: pageSize))
            }
        }
        
        return URLRequest(url: components.url!)
    }
}
