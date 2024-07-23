@RestResource(UrlMapping='/sensorEvents/*')
global with sharing class SensorEventService {

    public class SensorEventRequest {
        public String sensorid;
        public List<Vector> vectors;
    }

    public class Vector {
        public Decimal x;
        public Decimal y;
        public Decimal z;
    }

    @HttpPost
    global static String createSensorEvents() {
        RestRequest req = RestContext.request;
        String inputJson = req.requestBody.toString();

        SensorEventRequest request = (SensorEventRequest) JSON.deserialize(inputJson, SensorEventRequest.class);

        Sensor__c sensor;
        List<Sensor__c> sensors = [SELECT Id, Name FROM Sensor__c WHERE Name = :request.sensorid LIMIT 1];
        if (sensors.isEmpty()) {
            sensor = new Sensor__c(Name = request.sensorid);
            insert sensor;
        } else {
            sensor = sensors[0];
        }

        List<Sensor_Event__c> lastEvents = [SELECT Id, Name__c FROM Sensor_Event__c  ORDER BY Name__c DESC LIMIT 1];
        Id previousEventId;
        if (!lastEvents.isEmpty()) {
            previousEventId = lastEvents[0].Id;
        } else {
            previousEventId = null;
        }

        List<Sensor_Event__c> sensorEvents = new List<Sensor_Event__c>();
        for (Vector vector : request.vectors) {
            Sensor_Event__c event = new Sensor_Event__c(
                    Sensor__c = sensor.Id,
                    x__c = vector.x,
                    y__c = vector.y,
                    z__c = vector.z,
                    Previous_Event__c = previousEventId
            );
            sensorEvents.add(event);
        }

        insert sensorEvents;

        for (Integer i = 1; i < sensorEvents.size(); i++) {
            sensorEvents[i].Previous_Event__c = sensorEvents[i - 1].Id;
        }
        update sensorEvents;

        return 'Sensor Events created successfully';
    }
}
