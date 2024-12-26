import { LightningElement, wire } from 'lwc';
import { loadScript } from 'lightning/platformResourceLoader';
import ChartJS from '@salesforce/resourceUrl/ChartJs';
import getAccountCreationData from '@salesforce/apex/OpportunityChartCntrl.getAccountCreationData';

export default class GraphComp extends LightningElement {
    chart;
    chartjsInitialized = false;
    accountData = [];

    @wire(getAccountCreationData)
    wiredAccountData({ error, data }) {
        if (data) {
            console.log('inside wire');
            this.accountData = data;
            console.log('accountRec:::'+JSON.stringify(this.accountData));
            if (this.chartjsInitialized) {
                this.initializeChart();
            }
        } else if (error) {
            console.error('Error retrieving account data:', error);
        }
    }

    renderedCallback() {
        if (this.chartjsInitialized) {
            return;
        }

        // Try loading Chart.js
        loadScript(this, ChartJS+'/apexcharts.js')
            .then(() => {
                // Check if Chart.js is loaded
                this.chartjsInitialized = true;
                console.log('Chart.js loaded successfully.');

                // Initialize chart only if data is available
                if (this.accountData.length > 0) {
                    this.initializeChart();
                }
               
            })
            .catch(error => {
                console.error('Error loading Chart.js:', error);
            });
    }

    initializeChart() {
        try {
            const ctx = this.template.querySelector('canvas').getContext('2d');
            const labels = this.accountData.map(record => record.day);
            const chartdata = this.accountData.map(record => record.count);
            console.log('labels::'+labels +'::'+data);

            // // Destroy any existing chart instance
            // if (this.chart) {
            //     this.chart.destroy();
            // }

            this.chart = {
                type: 'bar',
                data: {
                 labels: labels,
                 datasets: [
                  {
                   label: 'Count',
                   barPercentage: 0.5,
                   barThickness: 6,
                   maxBarThickness: 8,
                   minBarLength: 2,
                   backgroundColor: "green",
                   data: chartdata,
                  },
                 ],
                },
                options: {
                },
               };
               console.log('data => ', data);
               this.error = undefined;
              
             



            
            // this.chart = new ChartJS(ctx, {
            //     type: 'bar',
            //     data: {
            //         labels: labels,
            //         datasets: [
            //             {
            //                 label: 'Accounts Created',
            //                 data: data,
            //                 backgroundColor: 'rgba(75, 192, 192, 0.6)'
            //             }
            //         ]
            //     },
            //     options: {
            //         scales: {
            //             x: {
            //                 ticks: {
            //                     maxRotation: 90,
            //                     minRotation: 45
            //                 }
            //             },
            //             y: {
            //                 beginAtZero: true
            //             }
            //         },
            //         responsive: true,
            //         plugins: {
            //             tooltip: {
            //                 mode: 'index',
            //                 intersect: false
            //             },
            //             legend: {
            //                 position: 'top'
            //             }
            //         }
            //     }
            // });
            // console.log('chart::'+JSON.stringify(this.chart));
        } catch (error) {
            console.error('Error initializing chart:', error);
       }
    }
}