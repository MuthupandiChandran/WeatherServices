using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Services;

namespace WeatherServices
{
    /// <summary>
    /// Summary description for WeatherService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WeatherService : System.Web.Services.WebService
    {
        private static readonly string apiKey = "611cf6224ebc8cafd76070bcbb2c2f83"; //GET API from Open Weather website Profile

        [WebMethod]
        public string GetWeatherByCity(string city)
        {
            try
            {
                string apiUrl = $"http://api.openweathermap.org/data/2.5/weather?q={city}&appid={apiKey}&units=metric";

                // Create a WebRequest and use GetResponse() to retrieve weather data
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(apiUrl);
                request.Method = "GET";
                using (HttpWebResponse response = (HttpWebResponse)request.GetResponse())
                {
                    using (StreamReader reader = new StreamReader(response.GetResponseStream()))
                    {
                        string jsonData = reader.ReadToEnd();
                        var weatherData = JObject.Parse(jsonData);

                        string weatherDescription = weatherData["weather"][0]["description"].ToString();
                        string temperature = weatherData["main"]["temp"].ToString();

                        return $"Weather in {city}: {weatherDescription}, Temperature: {temperature}°C";
                    }
                }
            }
            catch (Exception ex)
            {
                return $"Error: {ex.Message}";
            }
        }
    }
}
