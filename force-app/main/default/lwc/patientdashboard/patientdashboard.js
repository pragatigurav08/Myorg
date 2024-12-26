import { LightningElement, track,wire } from 'lwc';
import getDoctors from '@salesforce/apex/DoctorController.getDoctors'; // Import the Apex method

export default class PatientDetails extends LightningElement {
    @track doctors;
    @track showDoctors =true;
    @track showAppointmentForm = false;
    @track error;

   // @track showDoctors = true;
   // @track showAppointmentForm = false;
    @track appointmentName = '';
    @track selectedDoctor = '';
    @track appointmentDate = '';
    @track appointmentTime = '';
    @track doctors = [];
    @track doctorOptions = [];

    @wire(getDoctors)
    wiredDoctors({ error, data }) {
        if (data) {
            this.doctors = data;
            this.doctorOptions = data.map(doctor => {
                return { label: doctor.Name, value: doctor.Id };
            });
        } else if (error) {
            console.error('Error fetching doctors:', error);
        }
    }

    handleCardClick(event) {
        const cardClass = event.currentTarget.classList;

        if (cardClass.contains('card-1')) {
            // Fetch doctors' data if the "Doctors" card is clicked
            getDoctors()
                .then(result => {
                    this.doctors = result;
                    this.showDoctors = true;
                    this.showAppointmentForm = false;
                    this.error = undefined;
                })
                .catch(error => {
                    this.error = error;
                    this.doctors = undefined;
                });
        } else if (cardClass.contains('card-2')) {
            // Show appointment form if the "Slots" card is clicked
            this.showDoctors = false;
            this.showAppointmentForm = true;
        } else {
            // Reset both if any other card is clicked
            this.showDoctors = false;
            this.showAppointmentForm = false;
        }
    }
    handleSlotClick(event) {
        this.selectedDoctor = event.currentTarget.dataset.id;
        this.showAppointmentForm = true;
    }

    handleInputChange(event) {
        const field = event.target.label.toLowerCase().replace(' ', '');
        this[field] = event.target.value;
    }

    handleDoctorChange(event) {
        this.selectedDoctor = event.detail.value;
    }

    handleBookAppointment() {
        // Implement your logic to book an appointment
        console.log('Appointment booked with details:', {
            appointmentName: this.appointmentName,
            selectedDoctor: this.selectedDoctor,
            appointmentDate: this.appointmentDate,
            appointmentTime: this.appointmentTime
        });
    }
}