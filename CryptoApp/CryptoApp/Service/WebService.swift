//
//  WebService.swift
//  CryptoApp
//
//  Created by Terry Jason on 2023/11/30.
//

import Foundation

// MARK: - Error

enum CryptoError: Error {
    case serverError, parsingError
    
    var rawValue: String {
        switch self {
        case .serverError:
            "Server 發生錯誤"
        case .parsingError:
            "Parsing 過程發生錯誤"
        }
    }
}

// MARK: - WebService

class WebService {
    
    static func downloadCurrencies(url: URL, completion: @escaping (Result<[Crypto], CryptoError>) -> ()) {
        URLSession.shared.dataTask(with: url) { data, res, err in
            if let _ = err {
                completion(.failure(.serverError))
            } else if let data = data {
                guard let cryptos = getData(data) else {  return completion(.failure(.parsingError)) }
                completion(.success(cryptos))
            }
        }.resume()
    }
    
}

// MARK: - Networking

extension WebService {
    
    private static func getData(_ data: Data) -> [Crypto]? {
        return try? JSONDecoder().decode([Crypto].self, from: data)
    }
    
}
