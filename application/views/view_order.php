<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="page-title-box">
                        <div class="btn-group float-right">
                            <ol class="breadcrumb hide-phone p-0 m-0">
                                <li class="breadcrumb-item"><a href="<?= base_url() ?>">Order</a></li>
                                <li class="breadcrumb-item active">Kelola Order</li>
                            </ol>
                        </div>
                        <h4 class="page-title">Kelola Order</h4><br>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <div class="card">
            <div class="card-body">
                <table id="example" class="table table-hover table-bordered" style="width:100%">
                    <thead class="table-light">
                        <tr>
                            <th width="10%">ID Order</th>
                            <th width="10%">Nama</th>
                            <th width="15%">Nomor Order</th>
                            <th width="10%">Sub Total</th>
                            <th width="15%">Total Amount</th>
                            <th width="20%">Alamat</th>
                            <th width="10%">Payment</th>
                            <th width="10%">Status</th>
                            <th width="20%">Aksi</th>
                            <th width="20%">Detail</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($orders as $order) : ?>
                            <tr>
                                <td><?= $order['id'] ?></td>
                                <td><?= $order['first_name'] ?> <?= $order['last_name'] ?></td>
                                <td><?= $order['order_number'] ?></td>
                                <td>Rp. <?= $order['sub_total'] ?></td>
                                <td>Rp. <?= $order['total_amount'] ?></td>
                                <td><?= $order['address1'] ?></td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn <?= $order['payment_status'] == 'paid' ? 'btn-success' : 'btn-danger' ?> btn-sm" onclick="editPaymentStatus(<?= $order['id'] ?>, '<?= $order['payment_status'] == 'paid' ? 'unpaid' : 'paid' ?>')">
                                            <?= ucfirst($order['payment_status']) ?>
                                        </button>
                                    </div>
                                </td>
                                <td><?= $order['status'] ?></td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-info btn-sm" onclick="editStatus(<?= $order['id'] ?>, 'new')">New</button>
                                        <button type="button" class="btn btn-warning btn-sm" onclick="editStatus(<?= $order['id'] ?>, 'process')">Process</button>
                                        <button type="button" class="btn btn-success btn-sm" onclick="editStatus(<?= $order['id'] ?>, 'delivered')">Delivered</button>
                                        <button type="button" class="btn btn-danger btn-sm" onclick="editStatus(<?= $order['id'] ?>, 'cancel')">Cancel</button>
                                    </div>
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-primary btn-sm" onclick="showOrderDetail(<?= $order['id'] ?>)">Detail</button>
                                    </div>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
</div>

<script>
    var base_url = '<?php echo base_url() ?>';
    var _controller = '<?= $this->router->fetch_class() ?>';

    function showOrderDetail(id) {
        window.location.href = base_url + _controller + '/detail_order/' + id;
    }

    function editPaymentStatus(id, status) {
        $.ajax({
            url: base_url + _controller + '/edit_payment_status',
            type: 'POST',
            dataType: 'json',
            data: {
                id: id,
                status: status
            },
            success: function(response) {
                if (response.success) {
                    alert(response.success);
                    location.reload();
                } else if (response.error) {
                    alert(response.error);
                }
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                alert('Terjadi kesalahan saat menghubungi server.');
            }
        });
    }

    function editStatus(id, status) {
        $.ajax({
            url: base_url + _controller + '/edit_status',
            type: 'POST',
            dataType: 'json',
            data: {
                id: id,
                status: status
            },
            success: function(response) {
                if (response.success) {
                    alert(response.success);
                    // Refresh halaman atau update tabel jika perlu
                    location.reload();
                } else if (response.error) {
                    alert(response.error);
                }
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
                alert('Terjadi kesalahan saat menghubungi server.');
            }
        });
    }
</script>
