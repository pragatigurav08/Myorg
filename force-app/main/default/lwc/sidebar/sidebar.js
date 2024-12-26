import { LightningElement,track } from 'lwc';
export default class Sidebar extends LightningElement {
@track sideMenu = [
        { iconName: '/assets/home.svg', name: 'Home', subMenu: [], isExpanded: false },
        { 
            iconName: '/assets/items.svg', 
            name: 'Items', 
            iconNaame: 'utility:chevronright', 
            subMenu: [
                { name: 'Items' },
                { name: 'Price lists' },
                { name: 'Inventory Adjustments' }
            ], 
            isExpanded: false 
        },
        { iconName: '/assets/banking.svg', name: 'Banking', subMenu: [], isExpanded: false },
        { 
            iconName: '/assets/sales.svg', 
            name: 'Sales', 
            iconNaame: 'utility:chevronright', 
            subMenu: [
                { name: 'Customers' },
                { name: 'Estimates' },
                { name: 'Sales Orders' },
                { name: 'Invoices' },
                { name: 'Payments Received' }
            ], 
            isExpanded: false 
        },
        // Add more menu items as needed...
    ];

    sideMenuClass = 'sidebar-menu'; // Add dynamic class logic if needed

    handleMenuClick(event) {
        const name = event.currentTarget.dataset.name;
        const menuItem = this.sideMenu.find(item => item.name === name);
        if (menuItem) {
            menuItem.isExpanded = !menuItem.isExpanded;
            this.sideMenu = [...this.sideMenu]; // Trigger reactivity
        }
    }

    handleHover(event) {
        event.currentTarget.classList.add('hover');
    }

    handleHoverOut(event) {
        event.currentTarget.classList.remove('hover');
    }

    toggleSidebarWidth() {
        this.sideMenuClass = this.sideMenuClass === 'sidebar-menu' ? 'sidebar-menu-collapsed' : 'sidebar-menu';
    }

}