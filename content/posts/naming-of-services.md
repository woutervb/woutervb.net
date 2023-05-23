---
title: "Naming of Services"
date: 2023-05-23T16:43:07+10:00
draft: false
tags: ["naming", "software development", "software", "development"]
---

This is the eternal discussion, should services be functionally named, or given abstract, possible descriptive, names? 

Personally, I think that (micro)services should be given abstract names. From experience I do see that it has quite some advantages, which I will try to illustrate with simple examples. 

1. It frees one's mind of unconscious biases. What I mean with this, is that if you call a service to its initial functionality, my mind tends to limit the functionality to something that is part of the domain the service is named after. 
Someone will (should) never think of adding other types of dates to this service, as it would violate the functional naming. And this will happen as time goes on and the project grows in functionality. 

2. It prevents confusion. When at the start of a project services are named to what it initially does seems fine. I.e., calling a service, car-auditservice is fine. But what if after some time, this service not only handles audit things for cars, but also for trucks? The service will be adapted, but the name won’t. The name is already embedded in things like deployment tooling. So, changing the name is hard. 

3. Enrolling new team-members. When a new member joins the team, it can be an overwhelming experience, suddenly someone must learn about a dozen services and how they interact. And on top of that, the new member must learn that bike-index, isn’t an index for bikes, this server only keeps tracks of bike models, the index is stored at a service called workshop-inventory. 

In the above points, some of the examples might look ridiculous, and there is indeed some (functional) exaggeration to make a point. 

Naming is more important than people realise, and at the same time, it's probably one of the hardest things to do right. What I have found that works under most circumstances, is to at least try to find an abstract name, so, going back to the examples: dateservice, or auditservice would have been better. 

And what works even better is to use totally non-functional names, call the services after the planets of Jupiter, planets in our solar system, words from the star trek universe, or names of galaxies. It really doesn’t matter, consistency is nice, but not even needed. And what it will do, is free up a lot of flexibility. 
 

Take IO as an example. Initially it will be something abstract, and when the project progresses, it will gain functionality. And by the time it lands on production, everybody involved will know its function. And the best thing is, if it evolves over time to gain more functionality, or lose some, the team (and organisation) will grow with it. For new members, it's also great. As there is no assumption on what IO will do, it can be anything. Making it easy to have the service being responsible for anything that is relevant at a specific moment in time. 