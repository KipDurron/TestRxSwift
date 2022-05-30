import UIKit

class SelectorCell: UITableViewCell {
    
    let viewModel = SelectorViewModel()
    var pickerData = [Variant]()
    var startSelected: Int?

    lazy var pickerView: BasePickerView = {
        pickerView = BasePickerView()
        return pickerView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configView()
    }
    
    private func configView() {
        self.contentView.addSubview(self.pickerView)
        pickerView.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            pickerView.topAnchor.constraint(equalTo: self.contentView.topAnchor,
                                               constant:MarginSettingsEnum.baseTopAnchor.rawValue),
            pickerView.widthAnchor.constraint(equalTo: self.contentView.safeAreaLayoutGuide.widthAnchor, constant: -MarginSettingsEnum.forSpaceWidthBorder.rawValue),
            pickerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -MarginSettingsEnum.baseBottomAnchor.rawValue)
        ])
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }
    
    func setupData(pickerData: [Variant], startSelected: Int) {
        self.pickerData = pickerData
        self.startSelected = startSelected        
        let pikerIndex = startSelected == 0 ? 0 : (startSelected - 1)
                                           
        updatePicker()
        self.pickerView.selectRow(pikerIndex, inComponent: 0, animated: true)
    }
    
    func updatePicker() {
        self.pickerView.reloadAllComponents()
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

extension SelectorCell: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.pickerData[row].text
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.selectedVariant.onNext(self.pickerData[row])
    }
    
}
