settings =
    meetings: [
        { name: "RAL2025", time: "2025-03-31T00:00:00" },
        { name: "CoRL2025", time: "2025-04-23T00:00:00" },
    ]

refreshFrequency: 1000  # 每秒更新

style: """
  color: #fff
  font-family: 'Arial', sans-serif
  font-size: 20px
  text-align: left
  position: absolute
  top: 80%
  left: 10%
  transform: translate(0, 0)
  background: rgba(0, 0, 0, 0.5)
  padding: 10px
  border-radius: 10px
"""

render: () -> """
  <div class='countdown-container'>
  </div>
"""

update: (output, domEl) ->
  countdownHtml = ""
  now = new Date()
  for meeting in settings.meetings
    timeRemaining = @getTimeRemaining(meeting.time)
    countdownHtml += "<div><strong>#{meeting.name}:</strong> #{timeRemaining}</div>"
  $(domEl).find('.countdown-container').html(countdownHtml)

getTimeRemaining: (meetingTimeStr) ->
  now = new Date()
  meetingTime = new Date(meetingTimeStr)
  diff = meetingTime - now

  if diff <= 0
    return "Meeting Started!"

  seconds = Math.floor((diff / 1000) % 60)
  minutes = Math.floor((diff / 1000 / 60) % 60)
  hours = Math.floor((diff / (1000 * 60 * 60)) % 24)
  days = Math.floor(diff / (1000 * 60 * 60 * 24))

  countdownText = ""
  countdownText += "#{days}d " if days >= 0
  countdownText += "#{hours}h " if hours >= 0
  countdownText += "#{minutes}m " if minutes >= 0
  countdownText += "#{seconds}s"

  return countdownText