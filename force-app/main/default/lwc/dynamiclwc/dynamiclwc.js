import { LightningElement } from 'lwc';

export default class Dynamiclwc extends LightningElement {
    myval= "Pragati";
    handelchange(event){
        this.myval=event.target.value;
    }
}