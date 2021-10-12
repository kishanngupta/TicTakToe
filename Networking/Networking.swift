//
//  Network.swift
//  TicTakToe
//
//  Created by mac on 12/10/21.
//

import Foundation

enum NetworkError:Error{
    case noDataAvailable
    case canNotProcessData
    case inValidReponse
}

class RequestMaker {
    func postRequest(url: String, parameters: Dictionary<String, Any>) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        return request
    }
    
    func getRequest(url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        return request
    }
}

struct Networking {
    static let sharedInstance = Networking()
    let session = URLSession.shared
    
    func getData<T: Decodable>(request: URLRequest, returningClass: T.Type ,completion: @escaping(Result<T, NetworkError>)->Void) {
        
        let dataTask = session.dataTask(with: request) {data,response,error in
            guard let jsonData = data,
                  let response = response as? HTTPURLResponse else {
                completion(.failure(.noDataAvailable))
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                completion(.failure(.inValidReponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self,from:jsonData)
                completion(.success(response))
            }
            catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
}


