import { LightningElement,track } from 'lwc';

export default class DMSDashboard extends LightningElement {

    sideMenu = [
        { iconName: `${Home}`, name: 'Home', subMenu: [], isExpanded: false },
        { 
          iconName: `${Items}`, 
          name: 'Items', 
          iconNaame: 'utility:right', 
          subMenu: [
            { name: 'Items' },
            { name: 'Price lists' },
            { name: 'Inventory Adjustments' }
          ], 
          isExpanded: false 
        },
        { iconName: `${Banking}`, name: 'Banking', subMenu: [], isExpanded: false },
        
        { 
          iconName: `${sales}`, 
          name: 'Sales', 
          iconNaame: 'utility:right', 
          subMenu: [
            { name: 'Customers' },
            { name: 'Estimates' },
            { name: 'Retainer Invoices' },
            { name: 'Sales Orders' },
            { name: 'Delivery Chllans ' },
            { name: 'Invoices' },
            { name: 'Payments Received' },
            { name: 'Recurring Invoices' },
            { name: 'Credit Notes' }
          ], 
          isExpanded: false 
        },
        { iconName: `${purchases}`, name: 'Purchases', iconNaame: 'utility:right', 
        subMenu: [
          { name: 'Vendors' },
          { name: 'Expenses' },
          { name: 'Recurring Expenses' },
          { name: 'Purchase Orders' },
          { name: 'Bills' },
          { name: 'Payemnts Made' },
          { name: 'Recurring Bills ' },
          { name: 'Vendor Credits' },
    
        ], isExpanded: false },
        { iconName: `${timetracking}`, name: 'Time Tracking', iconNaame: 'utility:right', 
        subMenu: [
           { name: 'Projects' },
            { name: 'Timesheet' }
        ], isExpanded: false },
        { iconName: `${eway}`, name: 'e-way Bills', subMenu: [], isExpanded: false },
        { iconName: `${Accountant}`, name: 'Accountant', iconNaame: 'utility:right', 
          subMenu: [
            { name: 'Manual Journals' },
            { name: 'Bulk Update' },
            { name: 'Currency Adjustments' },
            { name: 'Chart of Accounts' },
            { name: 'Transaction Locking' }
          ], isExpanded: false },
        { iconName: `${Reports}`, name: 'Reports', subMenu: [], isExpanded: false },
        { iconName: `${Documents}`, name: 'Documents', subMenu: [], isExpanded: false },
        { iconName: `${ConfigIcon}`, name: 'Configure Feature List', subMenu: [], isExpanded: false },
      ];
    // sideMenu = [
    //     { iconName: `${Home}`, name: 'Home', subMenu: [], isExpanded: false, hasSubMenu: false },
    //     { 
    //       iconName: `${Items}`, 
    //       name: 'Items', 
    //       iconNaame: 'utility:right', 
    //       subMenu: [
    //         { name: 'Items' },
    //         { name: 'Price lists' },
    //         { name: 'Inventory Adjustments' }
    //       ], 
    //       isExpanded: false, 
    //       hasSubMenu: true 
    //     },
    //     { iconName: `${Banking}`, name: 'Banking', subMenu: [], isExpanded: false, hasSubMenu: false },
    //     { 
    //       iconName: `${sales}`, 
    //       name: 'Sales', 
    //       iconNaame: 'utility:right', 
    //       subMenu: [
    //         { name: 'Customers' },
    //         { name: 'Estimates' },
    //         { name: 'Retainer Invoices' },
    //         { name: 'Sales Orders' },
    //         { name: 'Delivery Challans' },
    //         { name: 'Invoices' },
    //         { name: 'Payments Received' },
    //         { name: 'Recurring Invoices' },
    //         { name: 'Credit Notes' }
    //       ], 
    //       isExpanded: false, 
    //       hasSubMenu: true 
    //     },
    //     { 
    //       iconName: `${purchases}`, 
    //       name: 'Purchases', 
    //       iconNaame: 'utility:right', 
    //       subMenu: [
    //         { name: 'Vendors' },
    //         { name: 'Expenses' },
    //         { name: 'Recurring Expenses' },
    //         { name: 'Purchase Orders' },
    //         { name: 'Bills' },
    //         { name: 'Payments Made' },
    //         { name: 'Recurring Bills' },
    //         { name: 'Vendor Credits' },
    //       ], 
    //       isExpanded: false, 
    //       hasSubMenu: true 
    //     },
    //     { 
    //       iconName: `${timetracking}`, 
    //       name: 'Time Tracking', 
    //       iconNaame: 'utility:right', 
    //       subMenu: [
    //         { name: 'Projects' },
    //         { name: 'Timesheet' }
    //       ], 
    //       isExpanded: false, 
    //       hasSubMenu: true 
    //     },
    //     { iconName: `${eway}`, name: 'e-way Bills', subMenu: [], isExpanded: false, hasSubMenu: false },
    //     { 
    //       iconName: `${Accountant}`, 
    //       name: 'Accountant', 
    //       iconNaame: 'utility:right', 
    //       subMenu: [
    //         { name: 'Manual Journals' },
    //         { name: 'Bulk Update' },
    //         { name: 'Currency Adjustments' },
    //         { name: 'Chart of Accounts' },
    //         { name: 'Transaction Locking' }
    //       ], 
    //       isExpanded: false, 
    //       hasSubMenu: true 
    //     },
    //     { iconName: `${Reports}`, name: 'Reports', subMenu: [], isExpanded: false, hasSubMenu: false },
    //     { iconName: `${Documents}`, name: 'Documents', subMenu: [], isExpanded: false, hasSubMenu: false },
    //     { iconName: `${ConfigIcon}`, name: 'Configure Feature List', subMenu: [], isExpanded: false, hasSubMenu: false },
    //   ];
    //   getMenuClass(task) {
    //     return `slds-m-bottom_small menu-item ${!task.hasSubMenu ? 'hover-effect' : ''}`.trim();
    // }
      
      
    handleMenuClick(event) {
        const selectedItem = event.currentTarget;
        const allMenuItems = this.template.querySelectorAll('.menu-item');
    
        // Remove active class from all items
        allMenuItems.forEach((item) => item.classList.remove('active'));
    
        // Add active class to the clicked item
        selectedItem.classList.add('active');
      }
    
      handleToggle(event) {
        const itemName = event.currentTarget.dataset.name; // Get the clicked item's name
        this.sideMenu = this.sideMenu.map((item) => {
          if (item.name === itemName) {
            return { ...item, isExpanded: !item.isExpanded }; // Toggle expansion state
          }
          return item;
        });
      }
      @track isCollapsed = false;

    // Get the class for the side menu
    get sideMenuClass() {
        return this.isCollapsed ? 'slds-m-around_medium tab-column-collapsed' : 'slds-m-around_medium';
    }

    // Toggle the sidebar width
    toggleSidebarWidth() {
        this.isCollapsed = !this.isCollapsed;
    }
}