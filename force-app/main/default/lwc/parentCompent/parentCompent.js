import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
    percentage = 20;
    ChildComponent

    handleChange(event) {
        this.percentage = event.target.value;
    }
}