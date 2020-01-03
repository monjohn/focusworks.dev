---
title: 'How to Send Data in Push Notification to Expo Using 3rd Party Service'
tags: Expo, React Native
date: 2019-09-06
---

Admittedly, the title of this blog post is a mouthful. But I wanted to share a solution to a specific problem that I ran into in hopes that others may find it helpful.

At [work](https://www.first.io), we build our mobile app using [Expo](https://www.expo.io), and we love it! It makes developing, updating, and testing React Native apps so much easier. One of the service that Expo provides is an interface to sending push notifications. Again, it is quite simple to get up and running with them. This worked great. But we also do a lot of communicating with our customers using Customer.io, and our marketing people wanted to consolidate everything there.

So we set everything up, and send our first push notifications. This is when we encountered the problem, while the messages were being delivered, no additional data was being received by our app. When sending a push using Expo's service, you can include any additional information that you want by including it under a "data" key. But no matter what we tried no data was getting through. I was about to give up when my co-worker found [this issue](https://forums.expo.io/t/push-notification-empty-data/25447) in the forum. **The key is to include additional data under a top-level key named "body"**, and Expo will include it in the data.

      {
        "body": {
          "alert-id": "a53fyy"
        },
        "aps": {
          "badge": 0,
          "alert": {
            "title": "OMG",
            "body": "I can't believe it's working!",
          }
        }
      }

Hope this helps the next person.
