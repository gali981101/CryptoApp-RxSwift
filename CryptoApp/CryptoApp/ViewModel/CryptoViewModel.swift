//
//  CryptoViewModel.swift
//  CryptoApp
//
//  Created by Terry Jason on 2023/11/30.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
    
    var cryptos: PublishSubject<[Crypto]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    func fetchData() {
        self.loading.onNext(true)
        
        WebService.downloadCurrencies(url: url) { [self] result in
            loading.onNext(false)
            
            switch result {
            case .success(let success):
                cryptos.onNext(success)
            case .failure(let failure):
                error.onNext(failure.rawValue)
                print(failure.rawValue)
            }
        }
    }
    
}


