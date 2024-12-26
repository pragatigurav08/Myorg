import { LightningElement } from 'lwc';

export default class Calculator extends LightningElement {
   
    numberOne="";
    numberTwo="";
    results=0;
    handleChangeOne(event){
        this.numberOne=event.target.value;
    }
    handleChangeTwo(event){
        this.numberTwo=event.target.value;

    }

    handelAdd(){
        this.results=parseInt(this.numberOne) + parseInt(this.numberTwo);
    }
    handelSub(){
        this.results=parseInt(this.numberOne) - parseInt(this.numberTwo);
    }
    handelDiv(){
        this.results=parseInt(this.numberOne) / parseInt(this.numberTwo);
    }
    handelMul(){
        this.results=parseInt(this.numberOne) * parseInt(this.numberTwo);
    }
}