//
//  ModelView.swift
//  Hackpuc-New
//
//  Created by Tauan Flores on 12/12/15.
//  Copyright © 2015 Grupo13. All rights reserved.
//

import Foundation

class MyoConnectView: UIView {
    
    var delegate: MyoViewProtocol?
    var cInfo: UILabel?
    var myo: UIImageView?
    
    var tapGesture = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        tapGesture.addTarget(self, action: Selector("tap:"))
        
        //Background
        let bgView = UIImageView(image: UIImage(named: "Background.png"))
        bgView.frame = CGRectMake(0, 0, FP.mW(), FP.mH())
        
        let lPar1Tx:String = "Conecte seu dispositivo e você estará pronto."
        
        // Units
        let yOffset:        CGFloat = 50
        let mW:      CGFloat = FP.mW()
        let mH:     CGFloat = FP.mH() - yOffset
        //let cRa:   CGFloat = FP.cRa()
        let eleW:  CGFloat = FP.round(382 * FP.wP())
        let eleBor: CGFloat = FP.round((mW - eleW)/2)
        
        //Medidas

        //Label Parte 1
        let lP1W: CGFloat = FP.round(eleW - 2*eleBor)
        let lP1H: CGFloat = FP.round(mH - mW - 6*eleBor)
        let lP1X: CGFloat = 2*eleBor
        let lP1Y: CGFloat = 10*eleBor
        
        //Botao de Continuar
        let cInfoW: CGFloat = FP.wP() * 281
        let cInfoH: CGFloat = FP.hP() * 69
        let cInfoX: CGFloat = (FP.mW() - cInfoW)/2
        let cInfoY: CGFloat = FP.mH() - cInfoH - 60
        
        //Imagem da Pena
        let penaW: CGFloat = FP.wP() * 86
        let penaH: CGFloat = FP.hP() * 119
        let penaX: CGFloat = (FP.mW() - penaW)/2
        let penaY: CGFloat = 60
        
        //Imagem do Myo
        let myoW: CGFloat = FP.mW() / 2.3
        let myoH: CGFloat = myoW
        let myoX: CGFloat = (FP.mW() - myoW)/2
        let myoY: CGFloat = lP1Y + lP1H + 20
        
        //Declarações
        
        //Label Parte 1
        let lPar1 = UILabel(frame: CGRectMake(lP1X,lP1Y,lP1W,lP1H))
        lPar1.text = lPar1Tx
        lPar1.font = UIFont(name: "GeosansLight", size: FP.normalFS())
        lPar1.textColor = FPColor.wColor()
        lPar1.textAlignment = NSTextAlignment.Center
        lPar1.numberOfLines = 99
        
        //Continue Button
        cInfo = UILabel(frame: CGRectMake(cInfoX, cInfoY, cInfoW, cInfoH))
        cInfo?.text = "Não Conectado"
        cInfo?.font = UIFont(name: "GeosansLight", size: FP.normalFS())
        cInfo?.textColor = FPColor.rColor()
        cInfo?.textAlignment = NSTextAlignment.Center
        cInfo?.numberOfLines = 99
        
        //Pena
        let pena = UIImageView(image: UIImage(named: "Pena.png"))
        pena.frame = CGRectMake(penaX, penaY, penaW, penaH)
        
        //Myo
        myo = UIImageView(image: UIImage(named: "MyoOff.png"))
        myo?.frame = CGRectMake(myoX, myoY, myoW, myoH)
        myo?.addGestureRecognizer(tapGesture)
        myo?.userInteractionEnabled = true
        
        //Acrescentar views
        self.addSubview(bgView)
        self.addSubview(lPar1)
        self.addSubview(pena)
        self.addSubview(cInfo!)
        self.addSubview(myo!)
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        
        self.delegate?.connectMyo()
    }
}
