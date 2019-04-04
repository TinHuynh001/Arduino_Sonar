# Arduino_Sonar
Based on a known Arduino sonar project, modified to work with two sensors in an attempt to create two overlapping radar coverage areas, and thus increase the sonar resolution.

The original project can be found here: https://howtomechatronics.com/projects/arduino-radar-project/

The basic idea behind this project is that, as shown by the original video demo, a "detection" by the sonar leaves, behind the object it detected, a sufficient "shadow" in the coverage area that cannot be reached by the sonar to know if the shadow is part of the detected object, or just empty space. By introducing a second sensor at a different angle sharing a similar coverage with the first, it is hoped that this second sonar can "peaks" over the object into the lost coverage area and scan it, thus correcting the displayed result (and vice versa).


The components for this project remain the same as the original, an Arduino board, a servomotor, Arduino and Processing IDEs, however, with 2 ultrasonic sensors instead of 1.


Things to do:
+ Figure out a good angle/spacing combination for the overlapping corrections to take effect. (Hell, probably get another servo and separate the two sensors into two sonars, make a multistatic radar system instead.)
+ Modify the radar base again, now with precise measurements of sensor angles, sensor spacing, etc,... to provide a correct display.
+ Modify Display to fade only after the sonar has made a full pass over the coverage area.
