import { LightningElement } from 'lwc';

import { loadScript } from 'lightning/platformResourceLoader';

export default class BarCode extends LightningElement {

    patientId = '';
    jsBarcodeLoaded = false;

    connectedCallback() {
        loadScript(this, JsBarcode)
            .then(() => {
                this.jsBarcodeLoaded = true;
            })
            .catch(error => {
                console.error('Error loading JsBarcode:', error);
            });
    }

    handleInputChange(event) {
        this.patientId = event.target.value;
    }

    generateBarcode() {
        if (!this.jsBarcodeLoaded) {
            console.error('JsBarcode is not loaded yet');
            return;
        }

        if (this.patientId) {
            const canvas = this.template.querySelector('.barcode');
            JsBarcode(canvas, this.patientId, {
                format: 'CODE128', // Barcode format
                width: 2,
                height: 100,
                displayValue: true, // Show the text below the barcode
            });
        } else {
            console.error('Please enter a valid Patient ID');
        }
    }
}