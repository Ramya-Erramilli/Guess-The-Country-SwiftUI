//
//  ContentView.swift
//  GuessTheCountry
//
//  Created by Ramya Seshagiri on 09/05/20.
//  Copyright © 2020 Ramya Seshagiri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var  userScore = 0
    
    var body: some View {
        ZStack{
            //            Color.blue.edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing : 30){
                VStack{
                    Text("Tap the flag of: ")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        //                    .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    
                }
                ForEach(0..<3){ number in
                    
                    Button(action: {
                        //                    Text("tap")
                        self.flagTapped(number)
                        
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Text("      Score :  \(userScore)       ")
                    .fontWeight(.semibold)
//                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(scoreMessage), dismissButton: .default(Text("Continue")){
                self.askQuestion()
                })
        }
    }    
    func flagTapped(_ number:Int){
        
        if(number==correctAnswer){
            scoreTitle = "Correct"
            userScore += 1
            scoreMessage = "Yaay! You got it right 🥳"
        }else{
            scoreTitle = "Wrong"
            scoreMessage = "Oops! You choose \(countries[number]) flag! 🥺"
        }
        showingScore = true
        
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
