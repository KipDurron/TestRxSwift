//
//  ItemsController.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import UIKit
import RxSwift
import RxCocoa

class ItemsController: UITableViewController {
    
    let alertFactory = AlertFactory()
//    public var items = PublishSubject<[Item]>()
    var items = [Item]()
    var itemsViewModel = ItemsViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .yellow
        self.registerCells()
        self.setupBindings()
        self.itemsViewModel.startGetAllItem()
        
    }
    
    
    private func setupBindings() {
        self.itemsViewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (error) in
                switch error {
                case .internetError(let message):
                    self.alertFactory.showErrorAlert(text: message, vc: self)
                case .serverMessage(let message):
                    self.alertFactory.showErrorAlert(text: message, vc: self)
                }
            }).disposed(by: disposeBag)
        
        self.itemsViewModel
            .items
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (newItems) in
                self.items = newItems
                self.updateTable()
            }).disposed(by: disposeBag)

        
        }

    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func registerCells() {
        self.tableView.register(TextCell.self, forCellReuseIdentifier: ReuseIdCellEnum.textReuseId.rawValue)
        self.tableView.register(PictureCell.self, forCellReuseIdentifier: ReuseIdCellEnum.pictureReuseId.rawValue)
        self.tableView.register(SelectorCell.self, forCellReuseIdentifier: ReuseIdCellEnum.selectorReuseId.rawValue)
    }
    
    func updateTable() {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentData = self.items[indexPath.row]
        if currentData.name == CellTypeEnum.text.rawValue {
            
            return self.setupTextCell(tableView, cellForRowAt: indexPath, currentData: currentData)
        }
        if currentData.name == CellTypeEnum.picture.rawValue {
            
            return self.setupPictureCell(tableView, cellForRowAt: indexPath, currentData: currentData)
        }
        if currentData.name == CellTypeEnum.selector.rawValue {

            return self.setupSelectorCell(tableView, cellForRowAt: indexPath, currentData: currentData)
        }
        return UITableViewCell()
    }
    
    func setupSelectorCell(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath,
                       currentData: Item) -> UITableViewCell{
        let cell = tableView
            .dequeueReusableCell(withIdentifier: ReuseIdCellEnum.selectorReuseId.rawValue,
                                 for: indexPath) as! SelectorCell
        guard let selectorData = currentData.data as? SelectorData else {
            return UITableViewCell()
        }
        cell.setupData(pickerData: selectorData.variants, startSelected: selectorData.selectedId)
        return cell
    }
    
    func setupPictureCell(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath,
                       currentData: Item) -> UITableViewCell{
        let cell = tableView
            .dequeueReusableCell(withIdentifier: ReuseIdCellEnum.pictureReuseId.rawValue,
                                 for: indexPath) as! PictureCell
        guard let pictureData = currentData.data as? PictureData else {
            return UITableViewCell()
        }
        cell.setupData(url: pictureData.url, text: pictureData.text)
        return cell
    }
    
    
    func setupTextCell(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath,
                       currentData: Item) -> UITableViewCell{
        let cell = tableView
            .dequeueReusableCell(withIdentifier: ReuseIdCellEnum.textReuseId.rawValue,
                                 for: indexPath) as! TextCell
        
        guard let textData = currentData.data as? TextData else {
            return UITableViewCell()
        }
        cell.setupData(text: textData.text)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentData = self.items[indexPath.row]
        if currentData.name == CellTypeEnum.text.rawValue {
            
            return MarginSettingsEnum.heightTextCell.rawValue
        }
        if currentData.name == CellTypeEnum.picture.rawValue {
            
            return MarginSettingsEnum.heightPictureCell.rawValue
        }
        if currentData.name == CellTypeEnum.selector.rawValue {

            return MarginSettingsEnum.heightSelectorCell.rawValue
        }
        return MarginSettingsEnum.heightCell.rawValue
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentData = self.items[indexPath.row]
        self.alertFactory.showMessageAlert(text: currentData.name, vc: self)
    }

}
