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
        if indexPath.row == 0{
            firstRowHeight = cell.height()
        }
    }
}
extension MainController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let inputs = service.inputs{
            return inputs.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let inputs = service.inputs else {return UITableViewCell()}
        
        let input = inputs[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: input.type!.cellType().cellReuseIdentifier()) as! BaseCell
        cell.type = input.type
        cell.updateCellWithInput(input: input)

        if input.type == .dropdown{
            let c = cell as! DropdownCell
            c.onDropdownBlock = { [weak self] (options) in
                guard let s = self else {return}
                s.showPickerController(pickerOptions: options, selectedIndex: { (index) in
                    let str = options[index]
                    c.setPickedItem(text: str)
                    s.params[input.varValue] = str
                })
            }
        }else if input.type == .input{
            let c = cell as! InputCell
            c.textBlock = { [weak self] (text) in
                guard let s = self else {return}
                if text.characters.count == 0{
                    s.params.removeValue(forKey: input.varValue)
                }else{
                    s.params[input.varValue] = text
                }
            }
        }
        return cell
    }
}

private extension MainController{
    func setupUI(){
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.themeBlue()
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white
        ]

        title = service.title
        registerCells()
        params["procedure_id"] = service.id
    }
    
    @IBAction func onCalculateButton(btn: UIButton){
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
        if let inputs = service.inputs{
            for i in inputs{
                if let type = i.type?.cellType(){
                    mainTableView.registerNibForCellClass(type)
                }
            }
        }
        mainTableView.registerNibForCellClass(ButtonCell.self)
    }
}

