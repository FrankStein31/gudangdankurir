<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="page-title-box">
                        <div class="btn-group float-right">
                            <ol class="breadcrumb hide-phone p-0 m-0">
                                <li class="breadcrumb-item"><a href="<?= base_url() ?>">BNSP</a></li>
                                <li class="breadcrumb-item"><a href="<?= base_url('kelola_order') ?>">Kelola Order</a></li>
                                <li class="breadcrumb-item active">Detail Order</li>
                            </ol>
                        </div>
                        <h4 class="page-title">Detail Order</h4>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="content">
        <div class="card">
            <div class="card-body">
                <h5>Order Number: <?= $order['order_number'] ?></h5>
                <table class="table table-bordered">
                    <tr>
                        <th>ID Order</th>
                        <td><?= $order['id'] ?></td>
                    </tr>
                    <tr>
                        <th>Sub Total</th>
                        <td>Rp. <?= $order['sub_total'] ?></td>
                    </tr>
                    <tr>
                        <th>Total Amount</th>
                        <td>Rp. <?= $order['total_amount'] ?></td>
                    </tr>
                    <tr>
                        <th>Status</th>
                        <td><?= $order['status'] ?></td>
                    </tr>
                    <tr>
                        <th>Payment Method</th>
                        <td><?= $order['payment_method'] ?></td>
                    </tr>
                    <tr>
                        <th>Payment Status</th>
                        <td><?= $order['payment_status'] ?></td>
                    </tr>
                    <tr>
                        <th>First Name</th>
                        <td><?= $order['first_name'] ?></td>
                    </tr>
                    <tr>
                        <th>Last Name</th>
                        <td><?= $order['last_name'] ?></td>
                    </tr>
                    <tr>
                        <th>Email</th>
                        <td><?= $order['email'] ?></td>
                    </tr>
                    <tr>
                        <th>Phone</th>
                        <td><?= $order['phone'] ?></td>
                    </tr>
                    <tr>
                        <th>Country</th>
                        <td><?= $order['country'] ?></td>
                    </tr>
                    <tr>
                        <th>Address 1</th>
                        <td><?= $order['address1'] ?></td>
                    </tr>
                    <tr>
                        <th>Address 2</th>
                        <td><?= $order['address2'] ?></td>
                    </tr>
                </table>
                <a href="<?= base_url('kelola_order') ?>" class="btn btn-primary mt-3">Kembali</a>
            </div>
        </div>
    </section>
</div>