<script>
$(document).ready(function() {
    $('#example').DataTable();

    // Insert Data
    $('#form-tambah').on('submit', function(e) {
        e.preventDefault();
        $.ajax({
            url: "<?= base_url('kelola_produk/insert_data') ?>",
            type: "POST",
            data: $(this).serialize(),
            dataType: "json",
            success: function(response) {
                if(response.success) {
                    $('#modal-tambah').modal('hide');
                    location.reload();
                } else if (response.error) {
                    alert(response.error);
                }
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                alert("Terjadi kesalahan saat menambah data. Silakan coba lagi.");
            }
        });
    });

    // Get Data for Edit
    $('.btn-edit').on('click', function() {
        var id = $(this).data('id');
        $.ajax({
            url: "<?= base_url('kelola_produk/get_data_id') ?>",
            type: "POST",
            data: {id: id},
            dataType: "json",
            success: function(data) {
                $('#edit-id').val(data.id);
                $('#edit-title').val(data.title);
                $('#edit-slug').val(data.slug);
                $('#edit-summary').val(data.summary);
                $('#edit-description').val(data.description);
                $('#edit-photo').val(data.photo);
                $('#edit-stock').val(data.stock);
                $('#edit-size').val(data.size);
                $('#edit-condition').val(data.condition);
                $('#edit-status').val(data.status);
                $('#edit-price').val(data.price);
                $('#edit-discount').val(data.discount);
                $('#edit-is_featured').prop('checked', data.is_featured == 1);
                $('#edit-cat_id').val(data.cat_id);
                $('#edit-child_cat_id').val(data.child_cat_id);
                $('#edit-brand_id').val(data.brand_id);
                $('#modal-edit').modal('show');
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                alert("Terjadi kesalahan saat mengambil data. Silakan coba lagi.");
            }
        });
    });

    // Update Data
    $('#form-edit').on('submit', function(e) {
        e.preventDefault();
        $.ajax({
            url: "<?= base_url('kelola_produk/update_data') ?>",
            type: "POST",
            data: $(this).serialize(),
            dataType: "json",
            success: function(response) {
                if(response.success) {
                    $('#modal-edit').modal('hide');
                    location.reload();
                } else if (response.error) {
                    alert(response.error);
                }
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                alert("Terjadi kesalahan saat memperbarui data. Silakan coba lagi.");
            }
        });
    });

    // Delete Data
    $('.btn-delete').on('click', function() {
        var id = $(this).data('id');
        if(confirm('Apakah Anda yakin ingin menghapus produk ini?')) {
            $.ajax({
                url: "<?= base_url('kelola_produk/delete_data') ?>",
                type: "POST",
                data: {id: id},
                dataType: "json",
                success: function(response) {
                    if(response.success) {
                        location.reload();
                    } else if (response.error) {
                        alert(response.error);
                    }
                },
                error: function(xhr, status, error) {
                    console.error(xhr.responseText);
                    alert("Terjadi kesalahan saat menghapus data. Silakan coba lagi.");
                }
            });
        }
    });
});
</script>