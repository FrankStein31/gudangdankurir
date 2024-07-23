$(document).ready(function() {
    // DataTable initialization
    $('#example').DataTable();

    // Add Product
    $('#form-tambah').submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: baseUrl + 'kelola_produk/insert_data',
            type: 'POST',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(response) {
                if(response.success) {
                    alert(response.success);
                    location.reload();
                } else {
                    alert(response.error);
                }
            }
        });
    });

    // Update Product
    $('#form-edit').submit(function(e) {
        e.preventDefault();
        $.ajax({
            url: baseUrl + 'kelola_produk/update_data',
            type: 'POST',
            data: $(this).serialize(),
            dataType: 'json',
            success: function(response) {
                if(response.success) {
                    alert(response.success);
                    location.reload();
                } else {
                    alert(response.error);
                }
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                alert("Terjadi kesalahan saat memperbarui data. Silakan coba lagi.");
            }
        });
    });

    // Delete Product
    $('.btn-delete').click(function() {
        if(confirm('Are you sure you want to delete this product?')) {
            var id = $(this).data('id');
            $.ajax({
                url: baseUrl + 'kelola_produk/delete_data',
                type: 'POST',
                data: {id: id},
                dataType: 'json',
                success: function(response) {
                    if(response.success) {
                        alert(response.success);
                        location.reload();
                    } else {
                        alert(response.error);
                    }
                }
            });
        }
    });
});