//
//  PictureCell.swift
//  TestRxSwift
//
//  Created by Илья Кадыров on 04.08.2021.
//

import UIKit

class PictureCell: UITableViewCell {
    
    lazy var stackContent: BaseHorizontalStackView = {
        let stackContent = BaseHorizontalStackView()
        return stackContent
    }()
    
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
        self.contentView.addSubview(self.stackContent)
        stackContent.addArrangedSubview(self.pictureImageView)
        stackContent.addArrangedSubview(self.textLabelArea)
        NSLayoutConstraint.activate([
            stackContent.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            stackContent.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                         constant:MarginSettingsEnum.baseTopAnchor.rawValue),
            stackContent.widthAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.widthAnchor, constant: -MarginSettingsEnum.forSpaceWidthBorder.rawValue),
            pictureImageView.widthAnchor.constraint(equalToConstant: 50),
            pictureImageView.heightAnchor.constraint(equalToConstant: 50),
            stackContent.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -MarginSettingsEnum.baseBottomAnchor.rawValue)
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
