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


document.addEventListener('DOMContentLoaded', function() {
    var searchInput = document.getElementById('searchInput');
    var searchSuggestions = document.getElementById('searchSuggestions');

    searchInput.addEventListener('keyup', function() {
        var keyword = searchInput.value;
        console.log("Keyword entered:", keyword); 

        if (keyword.length > 0) {
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'search.php', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    console.log("Response received:", xhr.responseText); 
                    var results = JSON.parse(xhr.responseText);
                    var suggestions = '';

                    results.forEach(function(result) {
                        suggestions += '<li>' + result.keyword + '</li>';
                    });

                    searchSuggestions.innerHTML = suggestions;
                    searchSuggestions.style.display = 'block';

                    searchSuggestions.querySelectorAll('li').forEach(function(item) {
                        item.addEventListener('click', function() {
                            var selectedKeyword = this.textContent.trim();
                            searchInput.value = selectedKeyword;
                            searchSuggestions.style.display = 'none';
                            window.location.href = '?search=' + encodeURIComponent(selectedKeyword);
                        });
                    });
                } else {
                    console.error("Error: " + xhr.status);
                }
            };
            xhr.send('keyword=' + encodeURIComponent(keyword));
        } else {
            searchSuggestions.style.display = 'none';
        }
    });

    document.addEventListener('click', function(e) {
        if (!searchInput.contains(e.target) && !searchSuggestions.contains(e.target)) {
            searchSuggestions.style.display = 'none';
        }
    });
});


document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.category-toggle').forEach(function(toggle) {
        toggle.addEventListener('click', function(e) {
            e.preventDefault(); 
            const subMenu = this.nextElementSibling;
            if (subMenu) {
                subMenu.style.display = subMenu.style.display === 'block' ? 'none' : 'block';
            }
        });
    });

    document.querySelectorAll('.price-filter').forEach(function(filter) {
        filter.addEventListener('click', function(e) {
            e.preventDefault(); 
            const category = this.dataset.category; 
            const maxPrice = this.dataset.maxPrice; 

            const urlParams = new URLSearchParams(window.location.search);
            urlParams.set('category', category);
            urlParams.set('max_price', maxPrice);
            window.location.search = urlParams.toString(); 
        });
    });
});


function validatePassword() {
    const password = document.getElementById("password").value;
    const confirmPassword = document.getElementById("confirmPassword").value;
    if (password !== confirmPassword) {
        alert("Mật khẩu nhập lại không khớp. Kiểm tra lại.");
        return false;
    }
    return true;
}


document.addEventListener('DOMContentLoaded', function () {
    const searchButton = document.getElementById('searchButton');
    const searchInput = document.getElementById('searchInput');

    function performSearch() {
        const keyword = searchInput.value.trim();
        if (keyword !== '') {
            window.location.href = `?search=${encodeURIComponent(keyword)}`;
        }
    }

    searchButton.addEventListener('click', performSearch);

    searchInput.addEventListener('keypress', function (event) {
        if (event.key === 'Enter') {
            performSearch();
        }
    });
});