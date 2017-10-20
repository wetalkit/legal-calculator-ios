//
//  OtherServicesView.swift
//  LegalCalculator
//
//  Created by Dejan Atanasov on 01/10/2017.
//  Copyright © 2017 Dejan Atanasov. All rights reserved.
//

import UIKit

class OtherServicesView: NibView {
    
    //MARK: - Private Properties
    @IBOutlet fileprivate weak var mainTableView: UITableView!

    fileprivate let headerHeight: CGFloat = 40
    
    //MARK: - Internal Properties
    var baseCost: BaseCost?{
        didSet{
            mainTableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainTableView.registerNibForCellClass(CostCell.self)
        mainTableView.registerNibForCellClass(TotalCell.self)
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
    }

}

extension OtherServicesView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
extension OtherServicesView: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return costsCount()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLastIndex(index: section){
            return 1
        }
        guard let costs = baseCost?.costs, let subCosts = costs[section].costs else {return 0}
        return subCosts.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if isLastIndex(index: section){
            return nil
        }
        guard let costs = baseCost?.costs else {return nil}
        let cost = costs[section]

        let v = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.width(), height: headerHeight))
        v.backgroundColor = UIColor.background()
        
        let lbl = UILabel(frame: CGRect.init(x: 20, y: 0, width: tableView.width() - headerHeight, height: v.height()))
        lbl.text = cost.descriptionValue
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        lbl.textColor = UIColor.otherServicesHeader()
        v.addSubview(lbl)
        return v
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isLastIndex(index: section) ? 0 : headerHeight
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isLastIndex(index: indexPath.section){
            let cell = tableView.dequeueReusableCell(withIdentifier: TotalCell.cellReuseIdentifier()) as! TotalCell
            let totalMin = baseCost?.totalMin.stringWithSepator ?? ""
            let totalMax = baseCost?.totalMax.stringWithSepator ?? ""
            let total = baseCost?.total.stringWithSepator ?? ""
            var totalStr = ""

            if totalMin == totalMax{
                totalStr = "\(total) МКД"
            }else{
                totalStr = "\(totalMin) - \(totalMax) МКД"
            }

            cell.updateCellWith(total: totalStr)

            
            return cell
        }
        
        guard let costs = baseCost?.costs, let subCosts = costs[indexPath.section].costs else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: CostCell.cellReuseIdentifier()) as! CostCell
        cell.updateCellWithCost(cost: subCosts[indexPath.row])
        return cell
    }
}

private extension OtherServicesView{
    func isLastIndex(index: Int)-> Bool{
        return costsCount()-1 == index
    }

    func costsCount()-> Int{
        if let count = baseCost?.costs?.count{
            return count + 1
        }
        return 0
    }
}

