/**
 * Custom Centered Dialog/Modal Utility
 * Requires Bootstrap 5 JS and CSS
 */
const Dialog = {
    /**
     * Show a confirmation modal
     * @param {string} title - Modal title
     * @param {string} message - Modal body text
     * @param {string} confirmText - Text for confirm button
     * @param {string} cancelText - Text for cancel button
     * @param {Function} onConfirm - Callback when confirmed
     */
    confirm: function (title, message, confirmText = 'Ya', cancelText = 'Batal', onConfirm) {
        const modalId = 'dialog-' + Date.now();
        const html = `
            <div class="modal fade" id="${modalId}" tabindex="-1" aria-labelledby="${modalId}Label" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content card-dark border-dark-700">
                        <div class="modal-header border-dark-700">
                            <h5 class="modal-title" id="${modalId}Label">${title}</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body text-dark-200">
                            ${message}
                        </div>
                        <div class="modal-footer border-dark-700">
                            <button type="button" class="btn btn-outline-light" data-bs-dismiss="modal">${cancelText}</button>
                            <button type="button" class="btn btn-danger" id="${modalId}-confirm">${confirmText}</button>
                        </div>
                    </div>
                </div>
            </div>
        `;

        document.body.insertAdjacentHTML('beforeend', html);
        const modalEl = document.getElementById(modalId);
        const modal = new bootstrap.Modal(modalEl);

        modal.show();

        const confirmBtn = document.getElementById(`${modalId}-confirm`);
        confirmBtn.onclick = () => {
            modal.hide();
            if (typeof onConfirm === 'function') {
                onConfirm();
            }
        };

        modalEl.addEventListener('hidden.bs.modal', () => {
            modalEl.remove();
        });
    }
};
