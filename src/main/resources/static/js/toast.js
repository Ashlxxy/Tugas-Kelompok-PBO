/**
 * Global Toast Notification Utility
 * Uses custom floating alert-toast styles from style.css
 */
const Toast = {
    containerId: 'global-toast-container',

    /**
     * Show a toast notification
     * @param {string} message - The message to display
     * @param {string} type - 'success', 'error', 'info', 'warning'
     */
    show: function (message, type = 'info') {
        this.ensureContainer();

        const iconMap = {
            success: 'bi-check-circle-fill',
            error: 'bi-exclamation-circle-fill',
            warning: 'bi-exclamation-triangle-fill',
            info: 'bi-info-circle-fill'
        };

        const textClassMap = {
            success: 'text-success',
            error: 'text-danger',
            warning: 'text-warning',
            info: 'text-info'
        };

        const iconClass = iconMap[type] || iconMap.info;
        const textClass = textClassMap[type] || 'text-white';

        // Create the toast element
        const toastEl = document.createElement('div');
        toastEl.className = `alert-toast ${type}`;

        toastEl.innerHTML = `
            <div class="d-flex align-items-center">
                <i class="bi ${iconClass} me-2 ${textClass}"></i> 
                <span>${message}</span>
            </div>
            <button type="button" class="btn-close" aria-label="Close"></button>
        `;

        // Add close behavior
        const btnClose = toastEl.querySelector('.btn-close');
        btnClose.addEventListener('click', () => {
            this.hide(toastEl);
        });

        // Append to container
        const container = document.getElementById(this.containerId);
        container.appendChild(toastEl);

        // Auto hide after 4 seconds
        setTimeout(() => {
            this.hide(toastEl);
        }, 4000);
    },

    hide: function (toastEl) {
        if (toastEl.classList.contains('hiding')) return;

        toastEl.classList.add('hiding');
        toastEl.addEventListener('animationend', () => {
            if (toastEl.parentElement) {
                toastEl.remove();
            }
        });
    },

    ensureContainer: function () {
        let container = document.getElementById(this.containerId);
        if (!container) {
            container = document.createElement('div');
            container.id = this.containerId;
            container.className = 'toast-container'; // style.css handles the positioning
            document.body.appendChild(container); // Append to body
        }
    }
};
