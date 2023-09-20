//
//  ContentView.swift
//  Slot Machine
//
//  Created by Zeki Baklan on 18.09.2023.
//

import SwiftUI

struct ContentView: View {
                //    MARK: - PROPERTIES
    
    let symbols = ["gfx-bell","gfx-cherry","gfx-coin","gfx-grape","gfx-strawberry"]
    
    @State private var highScore : Int = 0
    @State private var coins : Int = 100
    @State private var betAmount : Int = 10
    @State private var reels: Array = [0,1,2]
    @State private var showingInfoView : Bool = false
    @State private var isActiveBet10 : Bool = true
    @State private var isActiveBet20 : Bool = false
    @State private var showingModal : Bool = false
    
    
    //    MARK: - FUNCTIONS
    
    //    MARK: - SPIN  THE REELS
    func spinReels() {
//        reels[0] = Int.random(in: 0...symbols.count - 1)
//        reels[1] = Int.random(in: 0...symbols.count - 1)
//        reels[2] = Int.random(in: 0...symbols.count - 1)
        
        reels = reels.map({ _ in
            
            Int.random(in: 0...symbols.count - 1)
        })
    }
  
    //    MARK: - CHECK THE WINNING
    func checkWinning() {
        
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[3] {
            //    MARK: - PLAYER WINS
            playerWins()
            //    MARK: - NEW HIGH SCORE
            if coins > highScore {
                newHightScore()
            }
        }else
        {
            //    MARK: - PLAYER LOSES
            playerLoses()
        }
    }
    func playerWins() {
        coins += betAmount * 10
        
    }
    func newHightScore() {
         highScore = coins
    }
    func playerLoses() {
        coins -= betAmount
    }
    func activateBet20() {
        
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
    
    }
    func activateBet10() {
        betAmount = 10
        isActiveBet20 = false
        isActiveBet10 = true
    }
    func isGameOver() {
        if coins <= 0 {
            // SHOW MODEL WINDOW
            showingModal = true
            
        }
    }
  

    //    MARK: - GAME OVER
    
    
                //    MARK: - BODY
    var body: some View {
        ZStack {
                //    MARK: - BACKGROUND
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"),Color("ColorPurple"),]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                //    MARK: - INTERFACE
            VStack(alignment: .center, spacing: 5) {
            
                //    MARK: - HEADER
             LogoView()
                Spacer()
                //    MARK: - SCORE
                HStack {
                    HStack{
                        
                        Text("Your\nCoins".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                    .modifier(ScoreContainerModifier())
                    Spacer()
                    HStack{
                        Text("\(highScore)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                       
                    }
                    .modifier(ScoreContainerModifier())
                }
                
                //    MARK: - SLOT MACHINE
                VStack(alignment: .center, spacing: 0, content: {
                    //    MARK: - REEL #1
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                    }
                   
                    HStack(alignment: .center, spacing: 0, content: {
                        //    MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        Spacer()
                        
                        //    MARK: - REEL #3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    })
                    .frame(maxWidth: 500)
                    
                    
                    
                    //    MARK: - SPIN BUTTON
                    
                    Button(action: {
                        spinReels()
                        checkWinning()
                        isGameOver()
                      
                    }, label: {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    })
                    
                })
                .layoutPriority(2)
                
                //    MARK: - FOOTER
                
                Spacer()
                
                HStack{
                    //    MARK: - BET 20
                    HStack(alignment: .center,spacing: 10) {
                        Button(action: {
                            activateBet20()
                            print("Bet 20 Coins")
                        }, label: {
                                Text("20")
                                .fontWeight(.heavy)
                                .foregroundStyle(isActiveBet20 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        })
                        .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                    //    MARK: - BET 10
                    HStack(alignment: .center,spacing: 10) {
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        
                        Button(action: {
                            activateBet10()
                            print("Bet 10 Coins")
                        }, label: {
                                Text("10")
                                .fontWeight(.heavy)
                                .foregroundStyle(isActiveBet10 ? .yellow : .white)
                                .modifier(BetNumberModifier())
                        })
                        .modifier(BetCapsuleModifier())
                        
                      
                    }
                }
                
                
            }
                //    MARK: - BUTTONS
            
            
            .overlay(
              // RESET
              Button(action: {
               
              }) {
                Image(systemName: "arrow.2.circlepath.circle")
                  .foregroundColor(.white)
              }
              .modifier(ButtonModifier()),
              alignment: .topLeading
            )
            .overlay(
              // INFO
              Button(action: {
                showingInfoView = true
              }) {
                Image(systemName: "info.circle")
                  .foregroundColor(.white)
              }
              .modifier(ButtonModifier()),
              alignment: .topTrailing
            )
            .padding()
            .frame(maxWidth: 720)
            .blur(radius: $showingModal.wrappedValue ? 5 : 0,opaque: false)
           
                //    MARK: - POPUP
            if $showingModal.wrappedValue {
                ZStack
                {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    VStack(spacing: 0, content: {
                        // TITLE
                        Text("GAME OVER")
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0,maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(.white)
                        Spacer()
                        // MESSAGE
                        VStack(alignment: .center,spacing: 16, content: {
                          Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            Text("Bad luck! You lost all of the coins. \nLet's play again!")
                                .font(.system(.body,design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .layoutPriority(1)
                            Button(action: {
                                showingModal = false
                                coins = 100
                                
                            }, label: {
                                Text("New Game".uppercased())
                                    .font(.system(.body,design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal,12)
                                    .padding(.vertical,8)
                                    .frame(minWidth: 128)
                                    .background(
                                    Capsule()
                                        .strokeBorder(lineWidth: 1.75)
                                        .foregroundColor(Color("ColorPink"))
                                    )
                            })
                        })
                        Spacer()
                        
                    })
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(.white)
                    .cornerRadius(12)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6,x: 0,y: 8)
                    
                    
                }
            }
            
        } //: ZSTACK
       
        .sheet(isPresented: $showingInfoView, content: {
            InfoView()
        })
    }
}

//    MARK: - PREVIEW
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
