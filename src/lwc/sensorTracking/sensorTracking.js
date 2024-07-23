import { LightningElement, wire, track } from 'lwc';
import getSensors from '@salesforce/apex/SensorController.getSensors';
import getSensorEvents from '@salesforce/apex/SensorController.getSensorEvents';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SensorTracking extends LightningElement {
    @track selectedSensorId;
    @track sensorOptions = [];
    @track sensorEvents = [];
    @track columns = [
        { label: 'x', fieldName: 'x__c', type: 'number', editable: true },
        { label: 'y', fieldName: 'y__c', type: 'number', editable: true },
        { label: 'z', fieldName: 'z__c', type: 'number', editable: true },
        { label: 'Max Vector Length', fieldName: 'Max_Vectors_Length__c', type: 'number' }
    ];
    @track draftValues = [];

    @wire(getSensors)
    wiredSensors({ error, data }) {
        if (data) {
            this.sensorOptions = data.map(sensor => ({
                label: sensor.Name,
                value: sensor.Id
            }));
        } else if (error) {
            console.error('Error fetching sensors', error);
        }
    }

    handleSensorChange(event) {
        this.selectedSensorId = event.detail.value;
        this.fetchSensorEvents();
    }

    fetchSensorEvents() {
        getSensorEvents({ sensorId: this.selectedSensorId })
            .then(result => {
                this.sensorEvents = result.map(event => ({
                    ...event,
                    Max_Vectors_Length__c: event.Sensor__r.Max_Vectors_Length__c
                }));
                this.draftValues = [];
                console.log('events: ' + JSON.stringify(this.sensorEvents));
            })
            .catch(error => {
                console.error('Error fetching sensor events', error);
            });
    }

    handleCellChange(event) {
        this.draftValues = event.detail.draftValues;
    }

    handleSave(event) {
        const updatedFields = event.detail.draftValues.map(draft => ({
            fields: draft
        }));

        const promises = updatedFields.map(recordInput => updateRecord(recordInput));

        Promise.all(promises)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Records updated successfully',
                        variant: 'success'
                    })
                );
                event.detail.draftValues.forEach(draft => {
                    const index = this.sensorEvents.findIndex(event => event.Id === draft.Id);
                    if (index !== -1) {
                        this.sensorEvents[index] = { ...this.sensorEvents[index], ...draft };
                    }
                });
                this.draftValues = [];
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating records',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}