import { LightningElement, track } from 'lwc';
import startRequestImperative from '@salesforce/apexContinuation/ExchangeContinuationController.startRequest';

export default class ExchangeAppComponent extends LightningElement {

    @track imperativeContinuation;
    @track isLoading = false;
    @track amount;

    callContinuation() {
        this.isLoading = true;
        //this.imperativeContinuation = [];
        startRequestImperative({value: '$amount'})
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