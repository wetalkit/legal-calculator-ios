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
//    func fetchItems(request: TestModel.Fetch.Request)
}

class MainController: BaseController {
    var output: MainControllerOutput!
    var router: MainRouter!
    
    //MARK: - Private Properties
    @IBOutlet fileprivate weak var mainTableView: UITableView!

    fileprivate let cells: [MainCellType] = [.input, .input, .dropdown, .input, .dropdown, .dropdown, .button]
    
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
}
extension MainController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension MainController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cells[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type.cellType().cellReuseIdentifier()) as! BaseCell
        cell.type = type
        
        if type == .dropdown{
            let c = cell as! DropdownCell
            c.onDropdownBlock = { [weak self] (options) in
                guard let s = self else {return}
                s.showPickerController(pickerOptions: options, selectedIndex: { (index) in
                    let str = options[index]
                    c.setPickedItem(text: str)
                    print(str)
                })
            }
        }else if type == .input{
            let c = cell as! InputCell
            c.textBlock = { (text) in
                print(text)
            }
        }else if type == .button{
            let c = cell as! ButtonCell
            c.onActionBlock = { [weak self] in
                guard let s = self else {return}
                
            }
        }
        return cell
    }
}

private extension MainController{
    func setupUI(){
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.barTintColor = UIColor.white

        title = "Купопродажба на имот"
        registerCells()
    }
    
    func registerCells(){
        for type in cells{
            mainTableView.registerNibForCellClass(type.cellType())
        }
    }
    
}

