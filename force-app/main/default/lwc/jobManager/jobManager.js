import { LightningElement, track } from 'lwc';
import getJobs from '@salesforce/apex/RecruitmentController.getJobs';
import addJob from '@salesforce/apex/RecruitmentController.addJob';

export default class JobManager extends LightningElement {

    @track jobs = [];

    title;
    department;
    skills;
    exp;

    connectedCallback() {
        this.loadJobs();
    }

    loadJobs() {
        getJobs()
            .then(result => {
                this.jobs = result;
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleTitle(event) {
        this.title = event.target.value;
    }

    handleDepartment(event) {
        this.department = event.target.value;
    }

    handleSkills(event) {
        this.skills = event.target.value;
    }

    handleExp(event) {
        this.exp = event.target.value;
    }

    addJob() {
        addJob({
            title: this.title,
            department: this.department,
            skills: this.skills,
            exp: this.exp
        })
        .then(() => {
            this.loadJobs();
        })
        .catch(error => {
            console.error(error);
        });
    }
}
