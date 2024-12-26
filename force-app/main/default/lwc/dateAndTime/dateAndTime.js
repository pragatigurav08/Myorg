import { LightningElement } from 'lwc';

export default class DateAndTime extends LightningElement {

    currentDateTime;
    greetingMessage;

    updateDateTime() {
        const now = new Date();
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        this.currentDateTime = now.toLocaleString(undefined, options);
        const hours = now.getHours();

        if (hours >= 5 && hours < 12) {
            this.greetingMessage = 'Good Morning!';
        } else if (hours >= 12 && hours < 17) {
            this.greetingMessage = 'Good Afternoon!';
        } else {
            this.greetingMessage = 'Good Evening!';
        }
    }

    handleClick() {
        this.updateDateTime();
    }
}