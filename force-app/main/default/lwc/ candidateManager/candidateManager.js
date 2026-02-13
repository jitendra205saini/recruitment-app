import { LightningElement, track } from 'lwc';
import getCandidates from '@salesforce/apex/RecruitmentController.getCandidates';
import addCandidate from '@salesforce/apex/RecruitmentController.addCandidate';

export default class CandidateManager extends LightningElement {

    @track candidates = [];
    name; email; phone; skills; exp;

    connectedCallback() {
        this.loadData();
    }

    loadData() {
        getCandidates().then(result => {
            this.candidates = result;
        });
    }

    handleName(e){ this.name = e.target.value; }
    handleEmail(e){ this.email = e.target.value; }
    handlePhone(e){ this.phone = e.target.value; }
    handleSkills(e){ this.skills = e.target.value; }
    handleExp(e){ this.exp = e.target.value; }

    addCandidate() {
        addCandidate({
            name: this.name,
            email: this.email,
            phone: this.phone,
            skills: this.skills,
            exp: this.exp
        }).then(() => {
            this.loadData();
        });
    }
}
