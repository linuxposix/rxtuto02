//
//  ViewController.swift
//  rxtuto02
//
//  Created by USER on 17/01/2020.
//  Copyright © 2020 posixlinux. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var cities: [String] = ["고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "여주시", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시"]
    private var shownCities: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.searchBar.rx.text.orEmpty.debounce(0.5, scheduler: MainScheduler.instance).distinctUntilChanged().subscribe(onNext: { [unowned self] query in
            self.shownCities = self.cities.filter { $0.hasPrefix(query) }
            self.tableView.reloadData()
        }).disposed(by: self.disposeBag)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cityPropertyCell", for: indexPath)
        
        if let cityCell: CityCell = cell as? CityCell,
            indexPath.row < self.shownCities.count {
            cityCell.titleLabel?.text = self.shownCities[indexPath.row]
        }
        
        return cell
    }
}
