//
//  ViewController.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

protocol MainControllerInput
{
    
}

protocol MainControllerOutput
{
    func calculate(request: MainModel.Calculate.Request)
}

class MainController: BaseController {
    var output: MainControllerOutput!
    var router: MainRouter!
    var service: Service!
    
    //MARK: - Private Properties
    @IBOutlet fileprivate weak var mainTableView: UITableView!
    @IBOutlet fileprivate weak var moreOptionsBtn: UIButton!
    @IBOutlet fileprivate weak var moreOptionsHeight: NSLayoutConstraint!
    @IBOutlet fileprivate weak var otherServicesView: OtherServicesView!

    fileprivate var firstRowHeight: CGFloat = 0
    fileprivate var params: [String : Any] = [String : Any]()
    fileprivate let headerHeight: CGFloat = 40
    
    // MARK: - Object lifecycle
    override func awakeFromNib(){
        super.awakeFromNib()
        MainConfigurator.sharedInstance.configure(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func keyboardOpened(height: CGFloat) {
        mainTableView.keyboardRaised(height: height)
    }
    override func keyboardHidden() {
        mainTableView.keyboardClosed()
    }
    
    func successCalculation(viewModel: MainModel.Calculate.ViewModel) {
        otherServicesView.baseCost = viewModel.baseCost
        onMoreOptionsButton(btn: moreOptionsBtn)
    }
    func errorCalculation(viewModel: MainModel.Calculate.ViewModel) {
        
    }
}
extension MainController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == service.inputs[indexPath.section].inputs.count-1 && indexPath.section == 0{
            firstRowHeight = cell.height() + cell.y() + 20
        }
    }
}
extension MainController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return service.inputs.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = service.inputs[section].type.rawValue
        let v = UIView(frame: CGRect(x: 0, y: 0, width: tableView.width(), height: headerHeight))
        let lbl = UILabel(frame: CGRect(x: 16, y: headerHeight/2, width: view.width() - 16, height: headerHeight/2))
        lbl.text = title
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = UIColor.darkGray
        v.addSubview(lbl)
        return v
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return service.inputs[section].inputs.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let input = service.inputs[indexPath.section].inputs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: input.type!.cellType().cellReuseIdentifier()) as! BaseCell
        cell.type = input.type
        cell.updateCellWithInput(input: input)

        if input.type == .dropdown{
            let c = cell as! DropdownCell
            
            if let o = input.attributes?.options{
                if let i = params[input.varValue] as? Int{
                    cell.setValue(value: o[i])
                }else{
                    cell.setValue(value: o[0])
                }
            }
            
            c.onDropdownBlock = { [weak self] (options) in
                guard let s = self else {return}
                s.showPickerController(pickerOptions: options, selectedIndex: { (index) in
                    let str = options[index]
                    c.setPickedItem(text: str)
                    s.params[input.varValue] = index
                })
            }
        }else if input.type == .input{
            let c = cell as! InputCell
            cell.setValue(value: params[input.varValue] ?? "")

            c.textBlock = { [unowned self] (text) in
                if text.characters.count == 0{
                    self.params.removeValue(forKey: input.varValue)
                }else{
                    self.params[input.varValue] = text
                }
            }
        }
        return cell
    }
}

private extension MainController{
    func setupUI(){
        navigationController?.navigationBar.topItem?.title = ""
        title = service.title
        registerCells()
        defaultParams()
    }
    
    func defaultParams(){
        params["procedure_id"] = service.id
        if let opt = service.inputs.filter({$0.type == .optional}).first{
            for i in opt.inputs{
                params[i.varValue] = i.attributes?.placeholder ?? ""
            }
        }
    }
    func canProceed() -> Bool{
        var canProceed = true
        if let opt = service.inputs.filter({$0.type == .mandatory}).first{
            for i in opt.inputs{
                if params[i.varValue] == nil{
                    canProceed = false
                    break
                }
            }
        }
        return canProceed
    }
    
    @IBAction func onCalculateButton(btn: UIButton){
        if !canProceed(){
            AlertHelper.showAlertWithType(.ok, title: "", message: "Пополнете ги сите задолжителни полиња.", presenter: self)
            return
        }
        output.calculate(request: MainModel.Calculate.Request(params: params))
    }

    @IBAction func onMoreOptionsButton(btn: UIButton){
        btn.isSelected = !btn.isSelected
        
        if btn.isSelected{
            moreOptionsHeight.constant =  view.frame.height - (mainTableView.y() + firstRowHeight)
        }else{
            moreOptionsHeight.constant = 90
        }
        
        otherServicesView.alpha = btn.isSelected ? 0 : 1
        
        UIView.animate(withDuration: 0.3, animations: ({
            self.otherServicesView.alpha = btn.isSelected ? 1 : 0
            self.moreOptionsBtn.transform = self.moreOptionsBtn.transform.rotated(by: CGFloat(Double.pi))
            self.view.layoutSubviews()
        }))
    }
    
    func registerCells(){
        mainTableView.registerNibForCellClass(ButtonCell.self)
        mainTableView.registerNibForCellClass(DropdownCell.self)
        mainTableView.registerNibForCellClass(InputCell.self)
    }
}

