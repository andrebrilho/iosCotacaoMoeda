//
//  Multiplicacao.swift
//  Cotação Moeda
//
//  Created by André Brilho on 19/12/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import Foundation

var resultadoMultiplica:Double = 0.0

public class Multiplica{
    func multiplicacao(valor1:Double, valor2:Double)->Double {
    
        resultadoMultiplica = valor1 * valor2
        return resultadoMultiplica
    }

}