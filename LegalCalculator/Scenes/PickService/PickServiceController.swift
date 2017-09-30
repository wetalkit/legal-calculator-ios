//
//  PickServiceController.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 30/09/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

protocol PickServiceControllerInput
{
}

protocol PickServiceControllerOutput
{
    func fetchServices()
}

class PickServiceController: BaseController {
    //MARK: - Private Properties
    @IBOutlet fileprivate weak var pickServiceTableView: UITableView!
    
    var output: PickServiceControllerOutput!
    var router: PickServiceRouter!
    
    fileprivate var services: [Service] = [Service]()
    
    // MARK: - Object lifecycle
    override func awakeFromNib(){
        super.awakeFromNib()
        PickServiceConfigurator.sharedInstance.configure(viewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        title = "Pick Service"
    }
    
    func successFetchedServices(viewModel: PickServiceModel.Fetch.ViewModel) {
        services = viewModel.services!
        pickServiceTableView.reloadData()
    }
    func errorFetchingServices(viewModel: PickServiceModel.Fetch.ViewModel) {
        print("Error")
    }
}

extension PickServiceController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.showMainVC()
    }
}
extension PickServiceController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let service = services[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        cell.textLabel?.text = "Купопродажба на имот"
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.text = service.title
        return cell
    }
}

private extension PickServiceController{
    func setupUI(){
        output.fetchServices()
        title = "Pick Service"
    }
}

