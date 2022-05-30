//
//  PictureCell.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import UIKit

class PictureCell: UITableViewCell {
    
    lazy var pictureImageView: BaseUIImageView = {
        pictureImageView = BaseUIImageView()
        return pictureImageView
    }()
    
    lazy var textLabelArea: BaseLabelArea = {
        textLabelArea = BaseLabelArea()
        return textLabelArea
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configView()
    }
    
    private func configView() {
        self.contentView.addSubview(self.pictureImageView)
        self.contentView.addSubview(self.textLabelArea)
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                         constant:MarginSettingsEnum.baseTopAnchor.rawValue),
            pictureImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: MarginSettingsEnum.forSpaceWidthBorder.rawValue),
            pictureImageView.widthAnchor.constraint(equalToConstant: 50),
            pictureImageView.heightAnchor.constraint(equalToConstant: 50),
            pictureImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -MarginSettingsEnum.baseBottomAnchor.rawValue),
            
            textLabelArea.leadingAnchor.constraint(greaterThanOrEqualTo: pictureImageView.trailingAnchor, constant: MarginSettingsEnum.forSpaceWidthBorder.rawValue),
            textLabelArea.topAnchor.constraint(equalTo: pictureImageView.topAnchor),
            textLabelArea.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -MarginSettingsEnum.baseBottomAnchor.rawValue),
            textLabelArea.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor, constant: -MarginSettingsEnum.baseBottomAnchor.rawValue)

        ])
    }
    
    func setupData(url: String, text: String) {
        UIImage.load(from: url) {image in
            self.pictureImageView.image = image
        }
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
