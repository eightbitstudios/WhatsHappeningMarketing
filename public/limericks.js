var limericks = [
"If you happen to be looking here,<br>\
And pictures don’t appear,<br>\
Pull out your phone,<br>\
Enter the code,<br>\
Post a pic and let out a cheer!"
,
"When this slideshow does arise,<br>\
But no photos you see with thine eyes,<br>\
Open the mobile app,<br>\
Give that camera a snap-<br>\
Watch as your photo flies!"
,
"You made it but alas,<br>\
There are no photos on the glass,<br>\
Now it’s your turn,<br>\
For your photos we yearn,<br>\
Don’t let the moment pass!"
,
"So you’ve planned this big event,<br>\
All the time and effort spent,<br>\
One thing left to do,<br>\
Only question is who,<br>\
Has the first picture to present!"
,
"Now, before we proceed,<br>\
There is something we will need,<br>\
I’ll give you a clue,<br>\
It’s all about you…<br>\
…add your photos to the feed!"
];

function addLimerick() {
  if (document.getElementById('limerick')) {
    document.getElementById("limerick").innerHTML =  limericks[Math.floor(Math.random() * limericks.length)];
  }
}