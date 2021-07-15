import { LightningElement, track } from 'lwc';
import startRequestImperative from '@salesforce/apexContinuation/ExchangeContinuationController.startRequest';

export default class ExchangeAppComponent extends LightningElement {

    @track imperativeContinuation;
    @track isLoading = false;
    @track amount;

    handleNameChange(event) {
        this.amount=event.target.value;
        console.log('The Amount is changed to: ' + this.amount);
    }

    callContinuation() {
        this.isLoading = true;
        //this.imperativeContinuation = [];
        console.log('Calling Continuation for this amount: ' + this.amount);
        startRequestImperative({value: this.amount})
        .then(result => {
            this.imperativeContinuation = result;
            this.isLoading = false;
            console.log(this.imperativeContinuation);
        })
        .catch(error => {
            this.imperativeContinuation = error;
            this.isLoading = false;
        }
        );
    }
    get formatedImperativeResult() {
        return JSON.stringify(this.imperativeContinuation);
    }

}