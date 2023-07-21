//
//  ContentView.swift
//  Countdown Timer
//
//  Created by 张豪杰 on 2023/7/14.
//

import SwiftUI

struct ContentView: View {
    private var total: Int = 0
    @State private var isTimeRunning = true
    @State private var seconds = 0
    @State private var timer = createTimerPublisher().autoconnect()
    @State private var inputTime: String = ""
    
    func cancelTimer() -> Void {
        self.timer.upstream.connect().cancel();
        self.seconds = 0
    }
    
    func startTimer() {
        self.timer = createTimerPublisher().autoconnect()
        self.isTimeRunning = true
    }
    
    func timeUp() {
        self.cancelTimer()
        self.isTimeRunning = false
    }
    
    var body: some View {
        VStack {
            Text("\(getTimeText(seconds: self.seconds))")
                .font(.system(size: 100))
                .onReceive(self.timer) { _ in
                    if (self.seconds <= 0) {
                        self.timeUp()
                    } else {
                        self.seconds -= 1
                    }
                }
            
            Button(action: {
                cancelTimer()
            }) {
                Image(systemName: "stop.circle")
                    .resizable()
                    .frame(width: 56, height: 56)
                    .foregroundColor(.red)
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer()
            
            TextField(text: $inputTime) {
                Text("Enter your time")
                    .foregroundColor(.accentColor)
                    .frame(height: 32)
                    .padding()
            }
            .textFieldStyle(.plain)
            .font(.system(size: 24))
            .cornerRadius(12)
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
            .frame(width: 200, height: 100)
            .onSubmit {
                if checkInput(input: inputTime) {
                    self.seconds = inputToSeconds(input: inputTime)
                    self.inputTime = ""
                    self.startTimer()
                } else {
                    print("wrong input \(inputTime)")
                }
            }
        }
        .padding()
        .frame(minWidth: 450)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
