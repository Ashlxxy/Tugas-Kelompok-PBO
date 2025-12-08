/**
 * Toast Notification Utility
 * Requires Bootstrap 5 JS and CSS
 */
const Toast = {
    containerId: 'toast-container',

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

        const colorMap = {
            success: 'text-success',
            error: 'text-danger',
            warning: 'text-warning',
            info: 'text-info'
        };

        const bgMap = {
            success: 'border-success',
            error: 'border-danger',
            warning: 'border-warning',
            info: 'border-info'
        };

        const icon = iconMap[type] || iconMap.info;
        const color = colorMap[type] || colorMap.info;
        const borderColor = bgMap[type] || 'border-dark-700';

        const toastId = 'toast-' + Date.now();
        const html = `
            <div id="${toastId}" class="toast align-items-center text-white bg-dark-900 border ${borderColor} mb-3" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="d-flex">
                    <div class="toast-body d-flex align-items-center gap-3">
                        <i class="bi ${icon} ${color} fs-5"></i>
                        <div>${message}</div>
                    </div>
                    <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
            </div>
        `;

        const container = document.getElementById(this.containerId);
        container.insertAdjacentHTML('beforeend', html);

        const toastElement = document.getElementById(toastId);
        const bsToast = new bootstrap.Toast(toastElement, { delay: 4000 });
        bsToast.show();

        // Cleanup DOM after hidden
        toastElement.addEventListener('hidden.bs.toast', () => {
            toastElement.remove();
        });
    },

    ensureContainer: function () {
        if (!document.getElementById(this.containerId)) {
            const container = document.createElement('div');
            container.id = this.containerId;
            container.className = 'toast-container position-fixed top-0 end-0 p-3';
            container.style.zIndex = '1055';
            document.body.appendChild(container);
        }
    }
};
