document.addEventListener('DOMContentLoaded', function() {
    var detailButtons = document.querySelectorAll('.details-button');

    detailButtons.forEach(function(button) {
        button.addEventListener('click', function() {
            var productItem = this.closest('.product-item');
            var productDetails = productItem.querySelector('.product-full-details');
            productDetails.style.display = 'block';
        });
    });

    document.addEventListener('click', function(event) {
        var isClickInside = event.target.closest('.product-item');
        if (!isClickInside) {
            var openDetails = document.querySelectorAll('.product-full-details');
            openDetails.forEach(function(details) {
                details.style.display = 'none';
            });
        }
    });

    document.querySelectorAll('.quantity-input').forEach(function(input) {
        input.addEventListener('input', function() {
            var productItem = this.closest('.product-item');
            var hiddenQuantityInput = productItem.querySelector('input[name="quantity"]');
            hiddenQuantityInput.value = this.value;
        });
    });


    
    

});