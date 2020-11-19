//
//  ContentView.swift
//  SwiftUI Programming Quotes API
//
//  Created by elhajjaji on 19/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var quoteData : QuotesData?
    
    var body: some View {
            VStack(){
                Spacer()

                Text(quoteData?.quote ?? "There are only two hard things in Computer Science: cache invalidation, naming things and off-by-one errors.")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    
                HStack{
                    Spacer()
                    Text(quoteData?.author ?? "Phil Karlton")
                        .font(.footnote)
                        .fontWeight(.light)
                        .padding(.leading)
                }
                
                Spacer()
                Button(action: loadData) {
                    Image(systemName: "arrow.clockwise")
                }
                .font(.title)
                .padding(.top)
                    
                
                
            }.padding()
            .onAppear(perform: loadData)
        
    }
    
    
    private func loadData() {
        
        guard let url = URL(string: "http://quotes.stormconsultancy.co.uk/random.json") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let  data = data else {return}
            if let decodedData = try? JSONDecoder().decode(QuotesData.self, from: data){
                DispatchQueue.main.async {
                    self.quoteData = decodedData
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct QuotesData : Decodable {
    
    var author : String
    var quote : String
    var id : Int
    var permalink : String
    
}

