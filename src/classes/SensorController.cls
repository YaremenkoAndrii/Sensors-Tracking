public with sharing class SensorController {
    @AuraEnabled(Cacheable=true)
    public static List<Sensor__c> getSensors() {
        return [SELECT Id, Name, Max_Vectors_Length__c FROM Sensor__c];
    }

    @AuraEnabled(Cacheable=true)
    public static List<Sensor_Event__c> getSensorEvents(Id sensorId) {
        return [
                SELECT Id, x__c, y__c, z__c, Sensor__r.Max_Vectors_Length__c
                FROM Sensor_Event__c
                WHERE Sensor__c = :sensorId
        ];
    }
}
