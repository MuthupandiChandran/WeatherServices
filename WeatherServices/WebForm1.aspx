<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="WeatherServices.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
    <Services>
        <asp:ServiceReference Path="~/WeatherService.asmx" />
    </Services>
</asp:ScriptManager>
       <table style="font-family:Arial;border:1px solid black">
<tbody>
<tr>
<td><b>City</b></td>
<td><input name="txtCity" type="text" id="txtCity"/>
<input id="Button" type="button" value="Get Weather Details" onclick="GetWeatherDetails()" />
</td>
</tr>
<tr>
<td><b>Weather Description:</b></td>
<td><input name="txtDescription" type="text" id="txtDescription" /></td>
</tr>
<tr>
<td><b>Temprature(°C):</b></td>
<td><input name="txtWeather" type="text" id="txtWeather"/></td>
</tr>
</tbody>
</table>
    </form>
</body>
</html>

<script type="text/javascript">
    function GetWeatherDetails()
    {
        var city = document.getElementById("txtCity").value;
        WeatherServices.WeatherService.GetWeatherByCity(city,GetWeatherByCitySuccessCallback,GetWeatherByCityFailedCallback);
    }
    function GetWeatherByCitySuccessCallback(results)
    {
        /*return $"Weather in {city}: {weatherDescription}, Temperature: {temperature}°C";*/
        var weatherinfo = results.split(",");
        var weatherDescription = weatherinfo[0].split(":")[1].trim();
        var temprature = weatherinfo[1].split(":")[1].trim();
        document.getElementById("txtDescription").value = weatherDescription;
        document.getElementById("txtWeather").value = temprature;
    }
    function GetWeatherByCityFailedCallback(error) {
        alert("Error fetching weather details: " + error._message); // Show an error message if the request fails
    }


</script>
