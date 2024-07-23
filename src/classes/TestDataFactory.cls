@IsTest
public class TestDataFactory {
    public static List<Sensor__c> createSensors(Integer numberOfSensors) {
        List<Sensor__c> sensors = new List<Sensor__c>();
        for (Integer i = 0; i < numberOfSensors; i++) {
            sensors.add(new Sensor__c(Name = 'Sensor ' + i));
        }
        insert sensors;
        return sensors;
    }

    public static List<Sensor_Event__c> createSensorEvents(Id sensorId, Integer numberOfEvents) {
        List<Sensor_Event__c> events = new List<Sensor_Event__c>();
        for (Integer i = 0; i < numberOfEvents; i++) {
            events.add(new Sensor_Event__c(
                    Sensor__c = sensorId,
                    x__c = i,
                    y__c = i * 2,
                    z__c = i * 3
            ));
        }
        insert events;
        return events;
    }

    public static RestRequest createRestRequest(String jsonInput) {
        RestRequest req = new RestRequest();
        req.requestBody = Blob.valueOf(jsonInput);
        req.requestURI = '/services/apexrest/sensorEvents/';
        req.httpMethod = 'POST';
        return req;
    }
}