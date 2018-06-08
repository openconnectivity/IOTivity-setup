# developer-kit


see also:  https://openconnectivity.org/developer-kit

## enviro phat board

The file input-EnviroPhat.json is the DeviceBuilder input file for the
the enviro-phat board.

Description (from the website):

Enviro pHAT packs 4 different sensors, letting you measure temperature, pressure, light level, colour, 3-axis motion, compass heading, and analog inputs.

https://shop.pimoroni.com/products/enviro-phat


| path  |  rt | sensor/actuator |
| ----- | ----- | -------|
| /binaryswitch |  "oic.r.switch.binary"  |  actuator |
| /brightness |  "oic.r.light.brightness"  | sensor |
| /colourRGB |  "oic.r.colour.rgb"  | sensor  |
| /temperature  | "oic.r.temperature"  | sensor |
| /pressure          |  "oic.r.sensor.atmosphericpressure"    | sensor |
| /xmotion  |  "oic.r.sensor.acceleration"  | sensor |
| /ymotion  |  "oic.r.sensor.acceleration"  | sensor |
| /zmotion  |  "oic.r.sensor.acceleration"  | sensor |
| /heading          |  "oic.r.sensor.magneticfielddirection"  | sensor |
| /voltage0          |  "oic.r.energy.electrical"  | sensor |
| /voltage1          |  "oic.r.energy.electrical"  |sensor |
| /voltage2          |  "oic.r.energy.electrical"  | sensor |
| /voltage3          |  "oic.r.energy.electrical"  | sensor |

note that the implementation needs to make the connection from the resource to the actual hardware.



## automation phat board


The file input-AutomationPhat.json is the DeviceBuilder input file for the
the automation phat board.

description (from the website):

We've pulled together a great set of features into this home monitoring and automation controller. 
With a relay, analog channels, powered outputs, and buffered inputs (all 24V tolerant) you can now hook up a plethora of goodies to your Raspberry Pi all at once.

https://shop.pimoroni.com/products/automation-phat


| path  |  rt | sensor/actuator |
| ----- | ----- | -------|
| /ADC1 |  "oic.r.energy.electrical"  |  sensor |
| /ADC2 |  "oic.r.energy.electrical"  |  sensor |
| /ADC3 |  "oic.r.energy.electrical"  |  sensor |
| /ADC4 |  "oic.r.energy.electrical"  |  sensor |
| /output1 |  "oic.r.switch.binary"  |  actuator |
| /output2 |  "oic.r.switch.binary"  |  actuator |
| /output3 |  "oic.r.switch.binary"  |  actuator |
| /input1 |  "oic.r.switch.binary"  |  sensor |
| /input2 |  "oic.r.switch.binary"  |  sensor |
| /input3 |  "oic.r.switch.binary"  |  sensor |
| /relay |  "oic.r.switch.binary"  |  actuator |
| /PowerLight |  "oic.r.switch.binary"  |  actuator |
| /CommsLight |  "oic.r.switch.binary"  |  actuator |
| /WarnLight |  "oic.r.switch.binary"  |  actuator |


note that the implementation needs to make the connection from the resource to the actual hardware.