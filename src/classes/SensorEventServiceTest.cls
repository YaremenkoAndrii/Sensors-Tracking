@IsTest
private class SensorEventServiceTest {
    @IsTest
    static void testCreateSensorEvents() {
        Test.startTest();

        String NewSensorId = '1';

        String jsonInput = '{"sensorid":"' + NewSensorId + '","vectors":[{"x":22,"y":17,"z":197},{"x":23,"y":45,"z":14},{"x":22,"y":43,"z":196},{"x":24,"y":42,"z":198}]}';

        RestRequest req = TestDataFactory.createRestRequest(jsonInput);
        RestContext.request = req;

        String response = SensorEventService.createSensorEvents();
        String response1 = SensorEventService.createSensorEvents();

        List<Sensor__c> sensors = [SELECT Id, Name FROM Sensor__c WHERE Name = :NewSensorId];
        System.assertEquals(1, sensors.size(), 'Sensor should be created');

        List<Sensor_Event__c> sensorEvents = [SELECT Id, x__c, y__c, z__c FROM Sensor_Event__c WHERE Sensor__c = :sensors[0].Id];
        Test.stopTest();
        System.assertEquals(8, sensorEvents.size(), 'There should be 8 sensor events created');


    }
}