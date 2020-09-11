#!usr/bin/env python3
import pyowm
from pyowm import OWM
from datetime import datetime
import requests
import json





owm = pyowm.OWM('') #votre_api_open_weather_map
ba = owm.three_hours_forecast ('Bayeux, fr')
weather = ba.get_weather()
print(weather.get_temperature('celsius')['temp'])