//
//  ItemsController.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import UIKit

class ItemsController: UITableViewController {
    
    var itemsResponse: GetItemsResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        self.tableView.register(TextCell.self, forCellReuseIdentifier: ReuseIdCellEnum.textReuseId.rawValue)
        self.tableView.register(PictureCell.self, forCellReuseIdentifier: ReuseIdCellEnum.pictureReuseId.rawValue)
        self.tableView.register(SelectorCell.self, forCellReuseIdentifier: ReuseIdCellEnum.selectorReuseId.rawValue)
        
        let service = ItemService()
        service.loadAllItemData { [weak self] itemsResponse in
            self?.itemsResponse = itemsResponse
            self?.updateTable()
        }

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
        return self.itemsResponse?.data.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentData = itemsResponse?.data[indexPath.row]
        guard (currentData != nil) else {
            return UITableViewCell()
        }
        if currentData?.name == CellTypeEnum.text.rawValue {
            
            return self.setupTextCell(tableView, cellForRowAt: indexPath, currentData: currentData!)
        }
        if currentData?.name == CellTypeEnum.picture.rawValue {
            
            return self.setupPictureCell(tableView, cellForRowAt: indexPath, currentData: currentData!)
        }
        if currentData?.name == CellTypeEnum.selector.rawValue {

            return self.setupSelectorCell(tableView, cellForRowAt: indexPath, currentData: currentData!)
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
        let currentData = itemsResponse?.data[indexPath.row]
        if currentData?.name == CellTypeEnum.text.rawValue {
            
            return MarginSettingsEnum.heightTextCell.rawValue
        }
        if currentData?.name == CellTypeEnum.picture.rawValue {
            
            return MarginSettingsEnum.heightPictureCell.rawValue
        }
        if currentData?.name == CellTypeEnum.selector.rawValue {

            return MarginSettingsEnum.heightSelectorCell.rawValue
        }
        return self.view.bounds.size.width / 2
    }



}
