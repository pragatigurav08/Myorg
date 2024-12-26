import { LightningElement } from 'lwc';

export default class Parentcommunication extends LightningElement {
  
    count=1;
    endValue=0;
    message='';
    handleEventChange(event)
    {
        this.endValue=event.detail.endValue;
        this.message=event.detail.message;
           if(this.count<this.endValue){
            this.count= this.count+1;
           }
        
    }
}