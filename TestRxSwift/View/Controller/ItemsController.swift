//
//  ItemsController.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import UIKit

class ItemsController: UITableViewController {
    
    private let presenter: AllItemsViewToPresenter
    
    var itemsResponse: GetItemsResponse?
    let itemService = ItemService()
    let alertFactory = AlertFactory()
    var orderItems = [String]()
    var sortedItems = [Item]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .yellow
        self.registerCells()
        self.presenter.startGetAllItem()
        
    }
    init(presenter: AllItemsViewToPresenter) {
        self.presenter = presenter
        super.init(style: .grouped)
       
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
        return self.sortedItems.count
    }

    func sortItemByOrder() -> [Item] {
        var sortedItems = [Item]()
        for orderItem in self.orderItems {
            if let indexArr = self.itemsResponse?.data.firstIndex(where: { $0.name == orderItem }) {
                if let sortedData = self.itemsResponse?.data[indexArr] {
                    sortedItems.append(sortedData)
                }
            }
        }
        return sortedItems
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentData = self.sortedItems[indexPath.row]
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
        let currentData = self.sortedItems[indexPath.row]
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
        let currentData = self.sortedItems[indexPath.row]
        let alert = self.alertFactory.makeMessageAlert(text: currentData.name)
        self.present(alert, animated: true, completion: nil)
        
    }

}

extension ItemsController: AllItemsPresenterToView {
    func getAllItem(response: GetItemsResponse) {
        self.itemsResponse = response
        self.orderItems = self.itemsResponse?.view ?? []
        self.sortedItems = self.sortItemByOrder()
        self.updateTable()
    }
    
    func showMessage(text: String, messageType: MessageTypeEnum) {
        let message: UIAlertController
        switch messageType {
        case .message:
            message = alertFactory.makeMessageAlert(text: text)
        case .error:
            message = alertFactory.makeErrorAlert(text: text)
        }
        self.present(message, animated: true, completion: nil)
    }
    
    
}
