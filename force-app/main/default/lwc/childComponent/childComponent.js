import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api percentage;

    get computedClass() {
        return 'background-color:red; min-height:50px; width: ${this.percentage}%;min-width:10px; border:1px solid black';
        //return this.percentage > 50 ? 'high-percentage' : 'low-percentage';
    }
}