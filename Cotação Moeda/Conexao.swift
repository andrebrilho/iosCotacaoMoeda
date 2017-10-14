//
//  Conexao.swift
//  Cotação Moeda
//
//  Created by André Brilho on 19/12/16.
//  Copyright © 2016 Andre Brilho. All rights reserved.
//

import Foundation

var RetornoJson:Double = 0.0

public class Json{
    func ConexaoJson(moeda: String, completionHandler: (Double?, NSError?) -> Void) -> NSURLSessionTask {
    
            let urlApi =  "http://api.promasters.net.br/cotacao/v1/valores?moedas="+moeda+"&alt=json"
            let url = NSURL(string: urlApi)
            
            let urlRequest = NSURLRequest(URL: url!)
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: config)
            
            let task = session.dataTaskWithURL(url!) { (data, response, error) in
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                
                    if error != nil {
                        print(error)
                        completionHandler(nil, error)
                        return
                    } else {
                           do {
                            let parsedData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                            let valores = parsedData["valores"] as! NSDictionary
                            print(valores)
                            let moeda = valores[moeda] as! NSDictionary
                            print(moeda)
                            let valor = moeda["valor"] as! Double
                            print(valor)
                            completionHandler(valor, nil)
                            return
                        } catch let error as NSError {
                            print(error)
                        }
                    }

                }
            }
            task.resume()
            return task
    }
    
 }
        