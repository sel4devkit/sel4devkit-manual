# SPI Bus BMP280 Pressure Sensor

Having added a Serial Peripheral Interface (SPI) driver, it was tested with a widely available and inexpensive board module that uses the [Bosch BMP280](https://www.bosch-sensortec.com/products/environmental-sensors/pressure-sensors/bmp280/) barometric pressure / temperature sensor. Here is a link for a typical example, but there are many alternative sources: [Amazon link](https://www.amazon.co.uk/AZDelivery-Generic-BMP280-Barometric-Pressure/dp/B07D8TPVVY). You may also need some suitable cabling, such as female-to-female ribbon cable [(example here)](https://www.amazon.co.uk/UMTMedia-Dupont-Cables-Breadboard-Arduino/dp/B09MJZ8D61/ref=sr_1_10?crid=25HYJ98OWY607&dib=eyJ2IjoiMSJ9.dajI1jr1pnKAHRRPg5jVeV16AJBbWbUOkq_1S6o_PISIxSCWvITMRJt_v1RMYUfo1qPpMy4Lz5FpSks35etKTZ0Ex0XrGyDAE1i90x7NK_7r7fM5HWuSjqsOHNTRnHdjgpxGVhbVfDNDapOTnl5ICxALBrXAaHTI2jdZPdaAT7QTIRIc2wLUEc7bxycPMMOzNUl6HyzfwhVv6ghtL3dPNItSiebcLvEKKUc40yu3I-93yKM1sT-i6uv-nJx_ynn1ilCITgq0nuQptgSKYYo-d-JwXcKyXSAg_9m6DBNyGBY.-vOZfJhVxSB99BAiI798WsI_CbM4ryCOFkwabxcYIi4&dib_tag=se&keywords=female+to+female+ribbon+cable&qid=1724337680&sprefix=female+to+female+ribbon+cable%2Caps%2C91&sr=8-10) and a soldering iron to connect the pin header.

If this sensor is connected, the `uboot-driver-example` test application will use it (see [Using the U-Boot Driver Library](../device_drivers/uboot_driver_usage.md)).

The wiring connections using the MaaXBoard's 40-pin GPIO connector are as follows, accompanied by some reference photographs.

| GPIO Pin | Sensor Pin  |
|----------|-------------|
|   17     |  VCC        |
|   19     |  SDA (MOSI) |
|   20     |  GND        |
|   21     |  SDO (MISO) |
|   23     |  SCL        |
|   24     |  CSB (SSO)  |

![SPI GPIO view](../figures/SPI_side_view.png)
![SPI GPIO view](../figures/SPI_top_view.png)
![SPI sensor top view](../figures/SPI_sensor_top.png)
![SPI sensor bottom view](../figures/SPI_sensor_bottom.png)

