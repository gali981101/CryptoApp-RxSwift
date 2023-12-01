//
//  ViewController.swift
//  CryptoApp
//
//  Created by Terry Jason on 2023/11/30.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var cryptoList: [Crypto] = []
    let cryptoViewModel = CryptoViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
}

// MARK: - Setting

extension ViewController {
    
    private func setUp() {
        tableViewSetUp()
        setUpBindings()
        cryptoViewModel.fetchData()
    }
    
    private func tableViewSetUp() {
        // tableView.delegate = self
        // tableView.dataSource = self
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
}

// MARK: - Binding

extension ViewController {
    
    private func setUpBindings() {
        cryptosBinding()
        errorBinding()
        loadBinding()
    }
    
    private func cryptosBinding() {
        //        cryptoViewModel
        //            .cryptos
        //            .observe(on: MainScheduler.asyncInstance)
        //            .subscribe { [self] in
        //                cryptoList = $0
        //                tableView.reloadData()
        //            }
        //            .disposed(by: disposeBag)
        
        cryptoViewModel
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(cellIdentifier: "CryptoCell", cellType: CryptoTableViewCell.self)) {_,item,cell in
                cell.item = item
            }
            .disposed(by: disposeBag)
    }
    
    private func errorBinding() {
        cryptoViewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func loadBinding() {
        cryptoViewModel
            .loading
            .bind(to: indicatorView.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
}

// MARK: - UITableViewDataSource

/*
 extension ViewController: UITableViewDataSource {
 
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return cryptoList.count
 }
 
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 let cell = UITableViewCell()
 
 var content = cell.defaultContentConfiguration()
 
 content.text = cryptoList[indexPath.row].currency
 content.secondaryText = cryptoList[indexPath.row].price
 
 cell.contentConfiguration = content
 
 return cell
 }
 
 }
 */

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}


