//
//  ModelView.swift
//  Hackpuc-New
//
//  Created by Tauan Flores on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation

class SetupView: UIView {
    
    var label: UILabel?
    var delegate: SetupViewProtocol?
    
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
        
        // Units
        let yOffset:        CGFloat = 50
        let mW:      CGFloat = FP.mW()
        let mH:     CGFloat = FP.mH() - yOffset
        let eleW:  CGFloat = FP.round(382 * FP.wP())
        let eleBor: CGFloat = FP.round((mW - eleW)/2)
        
        //Aqui se definem as medidas e as posições dos componentes (Note que os nomes dos componentes são bem pequenos, abreviados)
        
        let lPar1Tx:String = "Bem vindo ao Feather.\n\nEste aplicativo utiliza sua localização GPS em situações de risco. Por favor, permita a utilização do GPS para prosseguir.\n\n(O GPS só será utilizado quando o aplicativo estiver ativado em segundo plano, minimizado)."
        
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
        
        //Label Parte 1
        let lP1W: CGFloat = FP.round(eleW - 2*eleBor)
        let lP1H: CGFloat = 350 * FP.hP()
        let lP1X: CGFloat = 2*eleBor
        let lP1Y: CGFloat = penaY + penaH + 10
        
        //Aqui se criam os componentes **************************************
        
        //Label Parte 1
        label = UILabel(frame: CGRectMake(lP1X,lP1Y,lP1W,lP1H))
        label?.text = lPar1Tx
        label?.font = UIFont(name: "GeosansLight", size: FP.normalFS())
        label?.textColor = FPColor.wColor()
        label?.textAlignment = NSTextAlignment.Center
        label?.highlighted = true
        label?.numberOfLines = 99
        
        //Continue Button
        let bCon = UIButton(frame: CGRectMake(bConX, bConY, bConW, bConH))
        bCon.backgroundColor = FPColor.bColor()
        bCon.setTitle("Entendi", forState: UIControlState.Normal)
        bCon.addTarget(self, action: Selector("buttonPress"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //Pena
        let pena = UIImageView(image: UIImage(named: "Pena.png"))
        pena.frame = CGRectMake(penaX, penaY, penaW, penaH)
        
        //Aqui se adicionam os componentes
        
        self.addSubview(bgView)
        self.addSubview(label!)
        self.addSubview(bCon)
        self.addSubview(pena)
    }
    
    func buttonPress() {
        
        delegate?.didPressNext()
    }
}
