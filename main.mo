import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Array "mo:base/Array";

actor WeatherDApp {

    // A record type to store weather data
    type WeatherReport = {
        location: Text;
        temperature: Int;
        description: Text;
        timestamp: Time.Time;
    };

    // Mutable array to store weather reports
    var reports: [WeatherReport] = [];

    // Function to submit a weather report
    public func submitWeather(location: Text, temperature: Int, description: Text): async () {
        let newReport = {
            location = location;
            temperature = temperature;
            description = description;
            timestamp = Time.now();  // Get the current time
        };
        reports := Array.append(reports, [newReport]);
    };

    // Function to get the latest weather report for a specific location
    public query func getLatestWeather(location: Text): async ?WeatherReport {
        // Filter the reports to find the latest for the given location
        let filteredReports = Array.filter<WeatherReport>(reports, func(r: WeatherReport): Bool {
            r.location == location
        });

        if (Array.size(filteredReports) > 0) {
            return ?filteredReports[Array.size(filteredReports) - 1];  // Return the most recent report
        } else {
            return null;  // No reports found for the location
        }
    };

    // Function to get all weather reports
    public query func getAllReports(): async [WeatherReport] {
        return reports;
    };
}
