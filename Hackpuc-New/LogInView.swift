//
//  ModelView.swift
//  Hackpuc-New
//
//  Created by Tauan Flores on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation

class LogInView: UIView {
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        //Background
        let bgView = UIImageView(image: UIImage(named: "Background.png"))
        bgView.frame = CGRectMake(0, 0, FP.mW(), FP.mH())
        
        //Delcarações
        var lPar1: UILabel?
        
        // Units
        let yOffset:        CGFloat = 50
        let mW:      CGFloat = FP.mW()
        let mH:     CGFloat = FP.mH() - yOffset
        let cRa:   CGFloat = FP.cRa()
        let eleW:  CGFloat = FP.round(382 * FP.wP())
        let eleBor: CGFloat = FP.round((mW - eleW)/2)
        
        
        //Aqui se definem as medidas e as posições dos componentes (Note que os nomes dos componentes são bem pequenos, abreviados)
        
        let lPar1Tx:String = "Olá , antes de fazer a conecao com seu dispositivo vamos configurar os alertas.."
        
        
        //Label Parte 1
        
        let lP1W: CGFloat = FP.round(eleW - 2*eleBor)
        let lP1H: CGFloat = FP.round(mH - mW - 6*eleBor)
        let lP1X: CGFloat = 2*eleBor
        let lP1Y: CGFloat = 10*eleBor
        
        //Botao de Continuar
        let bConW: CGFloat = FP.wP() * 281
        let bConH: CGFloat = FP.hP() * 69
        let bConX: CGFloat = (FP.mW() - bConW)/2
        let bConY: CGFloat = FP.mH() - bConH - 60
        
        //Imagem da Pena
        let penaW: CGFloat = FP.wP() * 86
        let penaH: CGFloat = FP.hP() * 119
        let penaX: CGFloat = (FP.mW() - penaW)/2
        let penaY: CGFloat = 60
        
        //Aqui se criam os componentes
        
        //Label Parte 1
        lPar1 = UILabel(frame: CGRectMake(lP1X,lP1Y,lP1W,lP1H))
        lPar1?.text = lPar1Tx
        lPar1?.font = UIFont(name: FP.fontName(), size: FP.normalFS())
        lPar1?.textColor = FPColor.wColor()
        lPar1?.textAlignment = .Natural
        lPar1?.numberOfLines = 99
        
        //Continue Button
        let bCon = UIButton(frame: CGRectMake(bConX, bConY, bConW, bConH))
        bCon.backgroundColor = FPColor.bColor()
        bCon.setTitle("Continuar", forState: .Normal)
        
        
        //Pena
        let pena = UIImageView(image: UIImage(named: "Pena.png"))
        pena.frame = CGRectMake(penaX, penaY, penaW, penaH)
        //pena.layer.cornerRadius = metadetamanho
        
        
        //Aqui se adicionam os componentes
        
        self.addSubview(bgView)
        self.addSubview(bCon)
        self.addSubview(pena)
        self.addSubview(lPar1!)
        
    }
}
