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
        
//Aqui se definem as medidas e as posições dos componentes (Note que os nomes dos componentes são bem pequenos)
        
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
        
        let bCon = UIButton(frame: CGRectMake(bConX, bConY, bConW, bConH))
        bCon.backgroundColor = UIColor.blueColor()
        bCon.setTitle("Continuar", forState: .Normal)
        
        let pena = UIImageView(image: UIImage(named: "Pena.png"))
        pena.frame = CGRectMake(penaX, penaY, penaW, penaH)
        
        //Aqui se adicionam os componentes
        
        self.addSubview(bgView)
        self.addSubview(bCon)
        self.addSubview(pena)
        
    }
}
