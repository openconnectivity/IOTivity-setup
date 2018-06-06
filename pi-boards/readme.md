# developer-kit

see also:  https://openconnectivity.org/developer-kit

The file input-EnviroPhat.json is the DeviceBuilder input file for the
the enviro-phat board.

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