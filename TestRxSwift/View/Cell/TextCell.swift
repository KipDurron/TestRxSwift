//
//  TextCell.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import UIKit

class TextCell: UITableViewCell {
    

    
    lazy var textLabelArea: BaseLabelArea = {
        textLabelArea = BaseLabelArea()
        return textLabelArea
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configView()
    }
    
    private func configView() {
        self.contentView.addSubview(self.textLabelArea)
        NSLayoutConstraint.activate([
            textLabelArea.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            textLabelArea.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                               constant:MarginSettingsEnum.baseTopAnchor.rawValue),
            textLabelArea.widthAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.widthAnchor, constant: -MarginSettingsEnum.forSpaceWidthBorder.rawValue),
            textLabelArea.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -MarginSettingsEnum.baseBottomAnchor.rawValue)
        ])
    }
    
    func setupData(text: String) {
        self.textLabelArea.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

