---
title: "Change is the enemy of perfect design"
date: 2023-05-28T16:00:03+10:00
tags: ["design", "development"]
---

When I was working as an infrastructure architect, I regularly had interesting discussions with stakeholders related to change. 

To start off, change is something that is different from flexibility when it comes to designs. With change, I refer to changes in requirements or goals during a project. 

With this explanation, it is probably clear that change is an enemy of a perfect design, simply because project timelines usually don’t change, even while changes are imposed on a project. This discrepancy between changes during the project and project timelines, will result in the fact that there will be less and less time available to handle the change. Which basically means that whatever change is introduced, there will be less time to incorporate it in the design. 

Change is also clearly different from flexibility. With flexibility the design will anticipate a certain (subset) of changes. Changes like how something is used, technology upgrades. And when talking about infrastructure, think of the eternal increase of network performance. Taking network speed increases for example, usually doesn’t mean a change in a design. Just replacing the current network cards for a model with more performance and that’s all. 

With change we talk about disruptive changes like, a design where ssd’s are combined with the once available [Intel Optane memory](https://en.wikipedia.org/wiki/3D_XPoint). Using the Optane memory as a write back cache, allowing verry fast writes and IO control return to the application, while in the background data is written to the ssd for a more permanent storage. And then a change comes around to replace the ssd’s with rotating disks. Such a change normally would mean that one would replace the Optane modules with something slower (and thus more affordable) like SLC-ssd's. As it doesn’t make much economic sense to put those fast expensive models in front of slow disks, which are better suited for ssd cache. And as one can see, depending on the moment the change in the project, there might not be any time left to handle this change. 

Since this article talks about ‘perfect design’, and yes, I know, such a design doesn’t exist. At least I don’t believe in a perfect design. A design should attempt to meet all the known requirements and add some of the implied ones as well (which are usually based on the organisations culture, but almost always include that it should cost a reasonable amount of money.) 