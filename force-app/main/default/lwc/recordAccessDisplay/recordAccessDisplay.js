import { api, LightningElement } from 'lwc';
import getCurrentUserRecordAccess from "@salesforce/apex/RecordAccessDisplayController.getCurrentUserRecordAccess";
import searchUsers from "@salesforce/apex/RecordAccessDisplayController.searchUsers";
import getUserMaxAccessLevelForRecord from "@salesforce/apex/RecordAccessDisplayController.getUserMaxAccessLevelForRecord";

export default class RecordAccessDisplay extends LightningElement {
    @api recordId
    @api objectApiName

    userAccessInformation
    selectedUser

    handleSearchTermChange(event) {
        if (event && event.target && event.target.value) {
            searchUsers({ searchTerm: event.target.value }).then(res => {
                if (Array.isArray(res) && res.length > 0) {
                    this.selectedUser = res[0]
                }
            }).finally(() => {
                if (this.selectedUser) {
                    getUserMaxAccessLevelForRecord({
                        recordId: this.recordId,
                        userId: this.selectedUser.Id
                    }).then(res => {
                        if (Array.isArray(res) && res.length > 0) {
                            this.userAccessInformation = res[0]
                        }
                    })
                }
            })
        }
    }

    connectedCallback() {
        getCurrentUserRecordAccess({ recordId: this.recordId }).then(res => {
            if (Array.isArray(res) && res.length > 0) {
                this.userAccessInformation = res[0]
            }
        })
    }
}