//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Huxley McGuffin on 14/7/21.
//

import SwiftUI
import AVFoundation


struct MeetingView: View {
    @Binding var scrum: DailyScrum

    @StateObject var scrumTimer = ScrumTimer()

    var player: AVPlayer { AVPlayer.sharedDingPlayer }


    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, scrumColor: scrum.color)
                MeetingTimerView(speakers: scrumTimer.speakers, scrumColor: scrum.color)
                MeetingFooterView(speakers: $scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.color.accessibleFontColor)
        .onAppear() {
            let _ = print("Appered")
            
            ding()
            
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)

            scrumTimer.speakerChangedAction = {
                ding()
            }
            

            scrumTimer.startScrum()
        }
        .onDisappear() {
            let _ = print("Disappered")
            scrumTimer.stopScrum()
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrumTimer.secondsElapsed / 60)
            
            scrum.history.insert(newHistory, at: 0)
        }
    }
    
    private func ding() {
        player.seek(to: .zero)
        player.play()
    }
}


struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
            .preferredColorScheme(.dark)
    }
}
