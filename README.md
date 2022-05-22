# WeatherApp
Weather app using openweathermap api, and show 5 days weather forecast data with 3-hour step.

<img src="/Screenshots/1.png" alt="" width="256" height="554" hspace="10"/> <img src="/Screenshots/2.png" alt="" width="256" height="554" hspace="10"/>
<img src="/Screenshots/3.png" alt="" width="256" height="554" hspace="10"/> <img src="/Screenshots/4.png" alt="" width="256" height="554" hspace="10"/> 
<img src="/Screenshots/5.png" alt="" width="256" height="554" hspace="10"/> 

----------------------
** OpenWeather Documentation**: https://openweathermap.org/forecast5 
 
- **Used OpenWeather API:** "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(long)&appid=553626bed26b25f56af0d6fa3890d1c5&units=Metric"
        
        - lat: latitute
        - long: longitute
        - appid: {API key}
        - units: Units for temperature measurement(standard, metric, and imperial).

- Fetch 5 days weather information from api. (Default used **Belgrade, Serbia** location)

- In the app Present information from api is the **Date, Time, weather icon, and temperature**.

- Fetch **weather icon** using https://openweathermap.org/img/wn/\(imgName)@2x.png API. Just pass weather icon name in imgName from api value.

- Using CollectionView for Horizontal scroll with pagination for lock per section(Column).

- Inside the collectionView, using TableView for per day weather list present.

- From api, getting list of weather in array, so filter and group by day using heigherOrder function.

- In the top of the page add SegmentControl(Switch) for switch between Live and fixed(Offline) weather data.

- Show **city name** from weather api **city** parameter. So if we change the location in code, we will get updated city name according to the location.

- Added JSON file in project for fixed data.

- **Used 3rd party frameworks**
    - **Alamofire**: For APIs call
    - **SDWebImage**: Fetch images from api
    - **SwiftLint**: For Code Structure setup

- Used **MVVM** Design Pattern

--------------------------------------------
