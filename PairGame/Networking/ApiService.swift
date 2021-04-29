//
//  ApiService.swift
//  Movee
//
//  Created by jjurlits on 10/27/20.
//

import Foundation
import UIKit


class ApiService {
    enum NetworkError: Error {
        case badResponse(Int)
        case emptyResponse
        case noData
        case badUrl
        case badRequest
    }
    
    @discardableResult
    func fetch<T: Decodable>(
        url: URL?,
        completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask? {
        guard let url = url else { return nil }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.emptyResponse))
                }
                return
            }
            
            if response.statusCode != 200 {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.badResponse(response.statusCode)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.emptyResponse))
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let object = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()

        return task
    }

    
    @discardableResult
    func fetch<T: Decodable>(urlString: String,
                            completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask? {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.badUrl))
            return nil
        }
        
       return fetch(url: url, completion: completion)
    }
    
}
