import { LightningElement } from 'lwc';

export default class Childcomponentcommunication extends LightningElement {

    
    endValue=5;
    handleButtonClick(){
        // this.dispatchEvent(new CustomEvent("increasecount"));
        const event = new CustomEvent('increasecount',{
            detail:{
                endValue:this.endValue,
                message:'welcome to Parent Child'
            }
        });
        // Dispatch the event
        this.dispatchEvent(event);
    }
}