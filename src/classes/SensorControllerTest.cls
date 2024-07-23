@IsTest
private class SensorControllerTest {
    @IsTest
    static void testGetSensors() {
        Test.startTest();
        TestDataFactory.createSensors(5);
        List<Sensor__c> sensors = SensorController.getSensors();
        Test.stopTest();
        System.assertEquals(5, sensors.size(), 'Expected to retrieve 5 sensors.');
    }

    @IsTest
    static void testGetSensorEvents() {
        Test.startTest();
        Sensor__c sensor = TestDataFactory.createSensors(1)[0];
        TestDataFactory.createSensorEvents(sensor.Id, 3);
        List<Sensor_Event__c> events = SensorController.getSensorEvents(sensor.Id);
        Test.stopTest();
        System.assertEquals(3, events.size(), 'Expected to retrieve 3 sensor events.');
    }

    @IsTest
    static void testGetSensorEvents_NoEvents() {
        Test.startTest();
        Sensor__c sensor = TestDataFactory.createSensors(1)[0];
        List<Sensor_Event__c> events = SensorController.getSensorEvents(sensor.Id);
        Test.stopTest();
        System.assertEquals(0, events.size(), 'Expected to retrieve 0 sensor events.');
    }
}