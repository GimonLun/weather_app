# Teleport Weather App

Flutter home assessment submission

```zsh
Flutter 2.8.0 • channel stable • https://github.com/flutter/flutter.git
Framework • revision cf44000065 (7 weeks ago) • 2021-12-08 14:06:50 -0800
Engine • revision 40a99c5951
Tools • Dart 2.15.0
```

---

## App Features

1. Multi-language support (Zh & En)
2. Dark & light mode support
3. View weather details by City
4. View hourly weather of a day by city
5. 7 days weather forecast for the selected city
6. Get current location weather to display in carousel
7. Add more city to the home page carousel
8. Delete city from the home page carousel
9. Persist language selection after app kills
10. Persist theme selection after app kills
11. Persist theme selection after app kills
12. Persist action history log after app kils
13. Persist added city in carousel after app kills

---

## Technique

1. Singleton Management:
   1. [get_it](https://pub.dev/packages/get_it)

2. Modeling:
   1. [json_serializable](https://pub.dev/packages/json_serializable)

3. Storage:
   1. [hive](https://pub.dev/packages/hive)
   1. [hive_flutter](https://pub.dev/packages/hive_flutter)

4. Location:
   1. [location](https://pub.dev/packages/location)

5. State Management:
   1. [bloc/cubit](https://pub.dev/packages/flutter_bloc)

6. State Management:
   1. [dio](https://pub.dev/packages/dio)
   1. [retrofit](https://pub.dev/packages/retrofit)

7. Multi-language:
   1. [flutter_i18n](https://pub.dev/packages?q=flutter_i18n)

---

## Side Noted

1. **OpenWeatherApi Library**
    Actually it is already have an library for easy integration for open weather api, refer [weather](https://pub.dev/packages/weather). However, I try to complete this test from scratch without using it so you can have more understand on my code.
    <br/>

2. **Display 30 City, I only have 26 in listing**
    App will load the cities list from `assets/cities.json` file which download from [here](https://simplemaps.com/data/my-cities). However, the file only contains 26 city for now. Due to time pressure, I not really go add in more.
    <br/>

3. **Test Case**
    Due to time pressure, I only do few test for you refer. Those test already convert `unit test`, `widget test`, `cubit test`, sufficient for proof the concept.
    <br/>

4. **Using one call Api**
   I found out another api provided by getWeather is not suitable for my case therefore I switch from [current-api](https://openweathermap.org/current) & [forecast-api](https://openweathermap.org/forecast5) to [onecall-api](https://api.openweathermap.org/data/2.5/onecall).
    <br/>

5. **User action log**
    Since not accurate requirement about what to store, I just store some simple data to indicate the actions.
    <br/>

6. **Minor problem**
    Due to the time pressure, so I won't able to fineture everything. Eg.
    1. Some UI maybe can be more dynamic
    2. Api Key should not commit into git
    3. Global error handler

---

## Output

1. [Video Preview](https://drive.google.com/file/d/1-f2pd5xWHRxvlbur7OeWeb4ED8-cBVKQ/view?usp=sharing)
2. [Apk Location]()