//
//  ContentView.swift
//  Dice game
//
//  Created by Mac11 on 2025/5/1.
//

import SwiftUI

struct ContentView: View {
    @State private var diceNumber = 0
    @State private var sum01 = 0
    @State private var sum02 = 0
    @State private var player1win = true
    @State private var rollscore = 0
    @State private var taketurn = true
    @State private var gameover = false
    @State private var player1Wins = 0
    @State private var player2Wins = 0

    private func resetGame() {
        diceNumber = 0
        rollscore = 0
        sum01 = 0
        sum02 = 0
        rollscore = 0
        taketurn = true
        gameover = false
        // 沒有重置勝利次數
    }
    
    private func resetAll() {
        diceNumber = 0
        sum01 = 0
        sum02 = 0
        rollscore = 0
        taketurn = true
        gameover = false
        player1Wins = 0    // 重置player1勝利次數
        player2Wins = 0    // 重置player2勝利次數
    }

    var body: some View {
        ZStack {
            if taketurn {
                Rectangle()
                    .frame(width: 180, height: 50)
                    .foregroundStyle(.orange)
                    .offset(x:-255, y:170)
            }else{
                Rectangle()
                    .frame(width: 180, height: 50)
                    .foregroundStyle(.orange)
                    .offset(x:255, y:170)
            }
            HStack {
                VStack(spacing: 0) {
                    Text("PLAYER 1")
                        .offset(x: -50, y: -20)
                    Text("WIN : \(player1Wins) LOSE : \(player2Wins)")
                        .offset(x: -50, y: -20)
                    Text("Score : \(sum01)")
                        .offset(x: -50, y: -20)
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 80)
                            .foregroundStyle(.orange)
                            .frame(width: 30, height: CGFloat(sum01)*2)//這個CGFloat是什麼呀？！
                            .offset(x: -50, y: 0)
                        RoundedRectangle(cornerRadius: 80)
                            .stroke(.black, lineWidth: 5)
                            .frame(width: 30, height: 200)
                            .offset(x: -50, y: 0)
                    }
                    
                }
                VStack {
                    if diceNumber > 0 {
                        Image(systemName: "die.face.\(diceNumber).fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundStyle(.orange)
                    }else{
                        Text("Let's PLAY!!!")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                    }
                    Button("Roll"){
                        diceNumber = .random(in: 1...6)
                        if diceNumber==1{
                            rollscore = 0
                            taketurn.toggle()
                        }else{
                            rollscore += diceNumber
                        }
                    }.font(.largeTitle)
                    
                    Button("Hold") {
                        if taketurn {
                            sum01 = sum01 + rollscore
                            rollscore = 0
                        } else {
                            sum02 = sum02 + rollscore
                            rollscore = 0
                        }
                        if sum01 >= 100 || sum02 >= 100 {
                            if sum01 > sum02 {
                                player1win = true
                                player1Wins += 1  // 勝利次數+1
                            } else {
                                player1win = false
                                player2Wins += 1  // 勝利次數+1
                            }
                            gameover = true
                        }
                        taketurn.toggle()
                    }.font(.title)
                    if player1Wins != 0 || player2Wins != 0 {
                        Button(action: resetGame) {
                            Text("Again")
                                .font(.title)
                        }
                    }
                    Button(action: resetAll) {
                        Text("Reset All")
                            .font(.title)
                    }
                    Text("\(rollscore)")
                        .font(.system(size: 35, weight: .bold, design: .rounded))
                        .offset(y: 30)
                }
                .padding()
                
                VStack {
                    Text("PLAYER 2")
                        .offset(x: 50, y: -15)
                    Text("WIN : \(player2Wins) LOSE : \(player1Wins)")
                        .offset(x: 50, y: -15)
                    Text("Score : \(sum02)")
                        .offset(x: 50, y: -15)
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: 80)
                            .foregroundStyle(.orange)
                            .frame(width: 30, height: CGFloat(sum02)*2)
                            .offset(x:50, y: -10)
                        RoundedRectangle(cornerRadius: 80)
                            .stroke(.black, lineWidth: 5)
                            .frame(width: 30, height: 200)
                            .offset(x:50, y: -10)
                    }
                }
            }
            
            if gameover {
                ZStack {
                    Color.black.opacity(0.7)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack() {
                        Text(player1win ? "PLAYER 1 WINS!" : "PLAYER 2 WINS!")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        
                        Text("Final Score")
                            .foregroundColor(.white)
                        
                        Text("Player 1: \(sum01)  Player 2: \(sum02)")
                            .foregroundColor(.white)
                        
                        Text("Player 1: \(player1Wins)  Player 2: \(player2Wins)")
                            .foregroundColor(.white)
                        
                        Button(action: resetGame) {
                            Text("Play Again")
                                .font(.title)
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Button(action: resetAll) {
                            Text("Reset All")
                                .font(.title)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.top, 10)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
