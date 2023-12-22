//
//  ContentView.swift
//  Rock_Paper_Scissors
//
//  Created by Dylan Silva on 12/19/23.
//

import SwiftUI


struct RockImage : ViewModifier {
    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 50)
            .clipShape(Capsule())
            .shadow(color: .cyan, radius: 5)
    }
}

extension View {
    func rockImage() -> some View {
        modifier(RockImage())
    }
}

struct ContentView: View {
    @State private var appChoice : Bool = Bool.random()
    @State private var score : Int = 0
    @State private var highScore : Int = 0
    @State private var playerChoice = false
    @State private var counter = 1
    @State private var appSelection : String = "Unknown"
    @State private var winOrLose : Bool = true
    
    var options = ["rock", "paper", "scissors"]
    var strengthArray = ["rock", "scissors", "paper"]
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                Gradient.Stop(color: .indigo, location: 0.45),
                Gradient.Stop(color: .cyan, location: 0.60),
            ], startPoint: .top, endPoint: .bottom)
            VStack() {
                Spacer()
                Spacer()
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
                VStack {
                    Text("Choose your Item")
                        .font(.largeTitle.bold())
                        .foregroundColor(.primary)
                    ForEach(0..<3) { num in
                        Button {
                            buttonPress(num)
                        }label: {
                            VStack {
                                Image(options[num])
                                    .resizable()
                                    .rockImage()
                                Text(options[num])
                                    .font(.largeTitle.weight(.semibold))
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    //.padding()
                    Text("Machine Chose: \(appSelection)")
                        .font(.title2.bold())
                        .foregroundColor(.indigo)
                    Text("\(winOrLose ? "Winner" : "Loss")")
                                .font(.title.bold())
                                .foregroundColor(winOrLose ? .green : .red)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                //glassy background
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Text("Max Score: \(highScore)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
    func buttonPress (_ num : Int) {
        pickWinner()
        if appChoice == true {
            // winner will be the player
            // options num is the same as the strength array
            switch options[num] {
            case "rock":
                appSelection = "Scissors"
            case "paper":
                appSelection = "Rock"
            case "scissors":
                appSelection = "Paper"
            default:
                print("Unknown")
            }
            score += 1
            winOrLose = true
        } else {
            // winner will be the machine
            switch options[num] {
            case "rock":
                appSelection = "Paper"
            case "paper":
                appSelection = "Scissors"
            case "scissors":
                appSelection = "Rock"
            default:
                print("Unknown")
            }
            winOrLose = false
        }
        counter += 1
        if score > highScore {
            highScore = score
        }
        if (counter > 10) {
            score = 0
            counter = 1
        }
    }
    func pickWinner () {
        appChoice = Bool.random()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// try ranage from 0 to 2
