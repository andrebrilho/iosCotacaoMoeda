//
//  ViewController.swift
//  Cotação Moeda
//
//  Created by André Brilho on 19/12/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var lblValorDefault: UILabel!
    @IBOutlet weak var txtvalor: UITextField!
    @IBOutlet weak var lblValorCalculado: UILabel!
    @IBOutlet weak var lblNomeMoeda: UILabel!
    @IBOutlet weak var segControll: UISegmentedControl!
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    @IBOutlet weak var segControll2: SegmentedControll!
    @IBOutlet weak var imgLogo: UIImageView!
    
    var valorMoeda:String = ""
    
    var respostaJson:Double = 0.0
    let conexao = Json()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgLogo.image = UIImage(named: "dolar")
        
        segControll.layer.cornerRadius = CGRectGetHeight(segControll.bounds) / 2
        segControll.layer.masksToBounds = true
        segControll.layer.borderWidth = 1
        segControll.layer.borderColor = UIColor.whiteColor().CGColor
        segControll2.itens = ["Dolar","Euro","Libra"]
        lblNomeMoeda.text = "DOLAR"
       //txtvalor.attributedPlaceholder = NSAttributedString(string: "Digite o valor em Reais", attributes: [NSForegroundColorAttributeName : whiteColor])
        txtvalor.attributedPlaceholder = NSAttributedString(string: "Digite o valor em Reais", attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        
        
        conexao.ConexaoJson("USD") { (valor, error) in
            dispatch_async(dispatch_get_main_queue()) {
                if let valor = valor{
                    print("View Controller Valor ->", valor)
                    
                    
                    self.lblValorDefault.text = String(valor)
                    self.respostaJson = valor
                    self.activityLoading.stopAnimating()
                    

                    
                }else{
                    print(error)
                    self.lblValorDefault.text = "Erro"
                }
                
                self.activityLoading.stopAnimating()
            }
        }

        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        moveTextField(txtvalor, moveDistance: -200, up: true)
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        moveTextField(txtvalor, moveDistance: -200, up: false)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        txtvalor.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func segControll2(sender: UISegmentedControl) {
        
        
        switch  segControll2.selectedIndex {
        case 0:
            removeValores()
            valorMoeda = "USD"
            print(valorMoeda)
            imgLogo.image = UIImage(named: "dolar")
            lblNomeMoeda.text = "DOLAR"
            
        case 1:
            removeValores()
            valorMoeda = "EUR"
            print(valorMoeda)
            imgLogo.image = UIImage(named: "euro")
            lblNomeMoeda.text = "EURO"
        case 2:
            removeValores()
            valorMoeda = "GBP"
            print(valorMoeda)
            imgLogo.image = UIImage(named: "libra")
            lblNomeMoeda.text = "LIBRA"
        default:
            lblValorDefault.text = ""
            txtvalor.text = ""
            lblValorCalculado.text = ""
            valorMoeda = "USD"
        }
        
        activityLoading.startAnimating()
        
        
        
        conexao.ConexaoJson(valorMoeda) { (valor, error) in
            dispatch_async(dispatch_get_main_queue()) {
                if let valor = valor{
                    print("View Controller Valor ->", valor)
                    
                    
                    self.lblValorDefault.text = String(valor)
                    self.respostaJson = valor
                    self.activityLoading.stopAnimating()
                    
                    
                }else{
                    print(error)
                    self.lblValorDefault.text = "Erro"
                }
                
                self.activityLoading.stopAnimating()
            }
        }

        
    }
    

    
//    @IBAction func segControllAction(sender: UISegmentedControl) {
//        
//        switch segControll.selectedSegmentIndex {
//        case 0:
//            valorMoeda = "USD"
//            print(valorMoeda)
//            imgLogo.image = UIImage(named: "dolar")
//            
//        case 1:
//            valorMoeda = "EUR"
//            print(valorMoeda)
//            imgLogo.image = UIImage(named: "euro")
//        case 2: //ARS
//            valorMoeda = "GBP"
//            print(valorMoeda)
//            imgLogo.image = UIImage(named: "libra")
//        default:
//            valorMoeda = "USD"
//        }
//        
//        activityLoading.startAnimating()
//
//        
//        
//        conexao.ConexaoJson(valorMoeda) { (valor, error) in
//            dispatch_async(dispatch_get_main_queue()) {
//            if let valor = valor{
//            print("View Controller Valor ->", valor)
//                
//                
//                    self.lblValorDefault.text = String(valor)
//                    self.respostaJson = valor
//                    self.activityLoading.stopAnimating()
//                
//                
//            }else{
//            print(error)
//                self.lblValorDefault.text = "Erro"
//            }
//            
//                    self.activityLoading.stopAnimating()
//                }
//        }
//        
//    }
    
    
    
    @IBAction func btnCalcular(sender: AnyObject) {
        
        if txtvalor.text == "" {

            let alert = UIAlertController(title: "Alerta", message: "Digite Algum Valor antes de Calcular", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        } else if self.lblValorDefault.text == "Erro"{
            let alert = UIAlertController(title: "Alerta", message: "Verifique sua conexão antes de fazer o calculo", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return
        
        }

        let converteValor = Multiplica()
        let txtvalorDouble = Double(txtvalor.text!)
        print(respostaJson)
        let valorFinal = converteValor.multiplicacao(respostaJson, valor2: txtvalorDouble!)
        lblValorCalculado.text = String(valorFinal)
        
        view.endEditing(true)
        
    }
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool){
        
        let moveDuration = 0.3
        let movement:CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        UIView.commitAnimations()
        
    }
    
    func dismissKeyboard() {
       
        view.endEditing(true)
    }
    
    func removeValores(){
        lblValorDefault.text = ""
        txtvalor.text = ""
        lblValorCalculado.text = ""
    }
    
}
