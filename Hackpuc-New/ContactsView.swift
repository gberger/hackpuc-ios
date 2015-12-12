//
//  ModelView.swift
//  Hackpuc-New
//
//  Created by Tauan Flores on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation
import UIKit

class ContactsView: UIView {
    
    var cTable: UITableView = UITableView()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setup()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        //declarações
        var lTit: UILabel?
        var lTitTx:String = "Quem deseja contactar?"
        
        //Background
        let bgView = UIImageView(image: UIImage(named: "Background.png"))
        bgView.frame = CGRectMake(0, 0, FP.mW(), FP.mH())
        
        // Units
        let yOffset:        CGFloat = 50
        let mW:      CGFloat = FP.mW()
        let mH:     CGFloat = FP.mH() - yOffset
        let cRa:   CGFloat = FP.cRa()
        let eleW:  CGFloat = FP.round(382 * FP.wP())
        let eleBor: CGFloat = FP.round((mW - eleW)/2)
        
        //Botao de Continuar
        let bConW: CGFloat = FP.wP() * 281
        let bConH: CGFloat = FP.hP() * 69
        let bConX: CGFloat = (FP.mW() - bConW)/2
        let bConY: CGFloat = FP.mH() - bConH - 60
        
        //Label Titulo tamanhos
        let lTitW: CGFloat = FP.round(eleW - 2*eleBor)
        let lTitH: CGFloat = FP.round(mH - mW - 6*eleBor)
        let lTitX: CGFloat = 2*eleBor
        let lTitY: CGFloat = 2*eleBor
        
        //Tamanhos tableview
        let cTW: CGFloat = FP.wP() * 281
        let cTH: CGFloat = FP.hP() * 362
        let cTX: CGFloat = (FP.mW() - cTW)/2
        let cTY: CGFloat = FP.mH() - cTH - 180
        
        
        //Creation Part --------------------------*
        
        //Continue Button
        let bCon = UIButton(frame: CGRectMake(bConX, bConY, bConW, bConH))
        bCon.backgroundColor = FPColor.bColor()
        bCon.setTitle("Continuar", forState: UIControlState.Normal)
        
        //titulo Label
        lTit = UILabel(frame: CGRectMake(lTitX,lTitY,lTitW,lTitH))
        lTit?.text = lTitTx
        lTit?.font = UIFont(name: "GeosansLight", size: FP.titFS())
        lTit?.textColor = FPColor.wColor()
        lTit?.textAlignment = NSTextAlignment.Center
        lTit?.highlighted = true
        lTit?.numberOfLines = 99
        
        //Creation tableView
        cTable.frame = CGRectMake(cTX, cTY, cTW, cTH)
//      cTable.delegate = self
//      cTable.dataSource = self
        cTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        //adding
        self.addSubview(bgView)
        self.addSubview(lTit!)
        self.addSubview(cTable)
        self.addSubview(bCon)
        
        
    }
}
