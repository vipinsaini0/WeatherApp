# WeatherApp
Weather app using openweathermap api, show 5 days data.

- Used OpenWeather API: https://openweathermap.org/forecast5 

- Fetch 5 days weather information from api. (Default used **Belgrade, Serbia** location)

- In the app Present information from api is the Date, Time, weather icon, and temperature.

- Fetch weather icon using https://openweathermap.org/img/wn/\(imgName)@2x.png API. just pass image name in imgName from api value.

- Use CollectionView for Horizontal scroll with pagination for lock per section(Column).

- Inside the collection use TableView for per day weather list present.

- From api, getting list of weather array so filter and group by day using heigherOrder function.

- In the top of the page add SegmentControl for swift between Live and fixed(Offline) weather data.

- Show city name from weather api **city** parameter.

- Added JSON file in project for fixed data.

- Used 3rd party frameworks
    - Alamofire: For APIs call
    - SDWebImage: Fetch images from api
    - SwiftLint: For Code Structure setup

