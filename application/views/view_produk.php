<div class="content-wrapper">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="page-title-box">
                        <div class="btn-group float-right">
                            <ol class="breadcrumb hide-phone p-0 m-0">
                                <li class="breadcrumb-item"><a href="<?= base_url() ?>">Home</a></li>
                                <li class="breadcrumb-item active">Kelola Produk</li>
                            </ol>
                        </div>
                        <h4 class="page-title">Kelola Produk</h4>
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
                            <th>ID</th>
                            <th>Title</th>
                            <th>Slug</th>
                            <th>Summary</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($products as $item): ?>
                            <tr>
                                <td><?= $item->id ?></td>
                                <td><?= $item->title ?></td>
                                <td><?= $item->slug ?></td>
                                <td><?= $item->summary ?></td>
                                <td>Rp. <?= $item->price ?></td>
                                <td><?= $item->stock ?></td>
                                <td>
                                    <button class="btn btn-info btn-edit" data-id="<?= $item->id ?>" data-toggle="modal" data-target="#modal-edit">Edit</button>
                                    <button class="btn btn-danger btn-delete" data-id="<?= $item->id ?>">Hapus</button>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#modal-tambah">Tambah Produk</button>
            </div>
        </div>
    </section>
</div>

<!-- Modal Tambah Produk -->
<div class="modal fade" id="modal-tambah" tabindex="-1" role="dialog" aria-labelledby="modalTambahProduk" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTambahProduk">Tambah Produk</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="form-tambah">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control" id="title" name="title" >
                    </div>
                    <div class="form-group">
                        <label for="slug">Slug</label>
                        <input type="text" class="form-control" id="slug" name="slug" >
                    </div>
                    <div class="form-group">
                        <label for="summary">Summary</label>
                        <textarea class="form-control" id="summary" name="summary" ></textarea>
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea class="form-control" id="description" name="description" ></textarea>
                    </div>
                    <div class="form-group">
                        <label for="photo">Photo</label>
                        <input type="text" 
                            class="form-control" 
                            id="photo" 
                            name="photo" 
                            placeholder="Only admins can edit this field"
                            <?php echo ($this->session->userdata('role') !== 'admin') ? 'disabled' : ''; ?>
                            value="<?php echo isset($product->photo) ? $product->photo : ''; ?>"
                        >
                        <?php if ($this->session->userdata('role') !== 'admin'): ?>
                            <small class="form-text text-muted">This field can only be edited by admins.</small>
                        <?php endif; ?>
                    </div>
                    <div class="form-group">
                        <label for="stock">Stock</label>
                        <input type="number" class="form-control" id="stock" name="stock" >
                    </div>
                    <div class="form-group">
                        <label for="size">Size</label>
                        <input type="text" class="form-control" id="size" name="size" >
                    </div>
                    <div class="form-group">
                        <label for="condition">Condition</label>
                        <select class="form-control" id="condition" name="condition" >
                            <option value="new">New</option>
                            <option value="hot">Hot</option>
                            <option value="default">Default</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="status">Status</label>
                        <select class="form-control" id="status" name="status" >
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="price">Price</label>
                        <input type="number" class="form-control" id="price" name="price" >
                    </div>
                    <div class="form-group">
                        <label for="discount">Discount</label>
                        <input type="number" class="form-control" id="discount" name="discount" >
                    </div>
                    <div class="form-group">
                        <label for="is_featured">Is Featured</label>
                        <input type="checkbox" id="is_featured" name="is_featured">
                    </div>
                    <div class="form-group">
                        <label for="cat_id">Category</label>
                        <select class="form-control" id="cat_id" name="cat_id" >
                            <?php foreach ($categories as $category): ?>
                                <option value="<?= $category->id ?>"><?= $category->title ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <!-- <div class="form-group">
                        <label for="child_cat_id">Child Category</label>
                        <input type="number" class="form-control" id="child_cat_id" name="child_cat_id">
                    </div> -->
                    <div class="form-group">
                        <label for="child_cat_id">Child Category</label>
                        <select class="form-control" id="child_cat_id" name="child_cat_id">
                            <option value="">No child category</option>
                            <?php foreach ($child_categories as $child_category): ?>
                                <option value="<?= $child_category->id ?>"><?= $child_category->title ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="brand_id">Brand</label>
                        <select class="form-control" id="brand_id" name="brand_id" >
                            <?php foreach ($brands as $brand): ?>
                                <option value="<?= $brand->id ?>"><?= $brand->title ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Simpan</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Edit Produk -->
<div class="modal fade" id="modal-edit" tabindex="-1" role="dialog" aria-labelledby="modalEditProduk" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalEditProduk">Edit Produk</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="form-edit">
                    <input type="hidden" id="edit-id" name="id">
                    <div class="form-group">
                        <label for="edit-title">Title</label>
                        <input type="text" class="form-control" id="edit-title" name="title">
                    </div>
                    <div class="form-group">
                        <label for="edit-slug">Slug</label>
                        <input type="text" class="form-control" id="edit-slug" name="slug" >
                    </div>
                    <div class="form-group">
                        <label for="edit-summary">Summary</label>
                        <textarea class="form-control" id="edit-summary" name="summary" ></textarea>
                    </div>
                    <div class="form-group">
                        <label for="edit-description">Description</label>
                        <textarea class="form-control" id="edit-description" name="description" ></textarea>
                    </div>
                    <div class="form-group">
                        <label for="photo">Photo</label>
                        <input type="text" 
                            class="form-control" 
                            id="photo" 
                            name="photo" 
                            placeholder="Only admins can edit this field"
                            <?php echo ($this->session->userdata('role') !== 'admin') ? 'disabled' : ''; ?>
                            value="<?php echo isset($product->photo) ? $product->photo : ''; ?>"
                        >
                        <?php if ($this->session->userdata('role') !== 'admin'): ?>
                            <small class="form-text text-muted">This field can only be edited by admins.</small>
                        <?php endif; ?>
                    </div>
                    <div class="form-group">
                        <label for="edit-stock">Stock</label>
                        <input type="number" class="form-control" id="edit-stock" name="stock" >
                    </div>
                    <div class="form-group">
                        <label for="edit-size">Size</label>
                        <input type="text" class="form-control" id="edit-size" name="size" >
                    </div>
                    <div class="form-group">
                        <label for="edit-condition">Condition</label>
                        <select class="form-control" id="edit-condition" name="condition" >
                            <option value="new">New</option>
                            <option value="hot">Hot</option>
                            <option value="default">Default</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="edit-status">Status</label>
                        <select class="form-control" id="edit-status" name="status" >
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="edit-price">Price</label>
                        <input type="number" class="form-control" id="edit-price" name="price" >
                    </div>
                    <div class="form-group">
                        <label for="edit-discount">Discount</label>
                        <input type="number" class="form-control" id="edit-discount" name="discount" >
                    </div>
                    <div class="form-group">
                        <label for="edit-is_featured">Is Featured</label>
                        <input type="checkbox" id="edit-is_featured" name="is_featured">
                    </div>
                    <div class="form-group">
                        <label for="edit-cat_id">Category</label>
                        <select class="form-control" id="edit-cat_id" name="cat_id" >
                            <?php foreach ($categories as $category): ?>
                                <option value="<?= $category->id ?>"><?= $category->title ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <!-- <div class="form-group">
                        <label for="edit-child_cat_id">Child Category</label>
                        <input type="number" class="form-control" id="edit-child_cat_id" name="child_cat_id">
                    </div> -->
                    <div class="form-group">
                        <label for="edit-child_cat_id">Child Category</label>
                        <select class="form-control" id="edit-child_cat_id" name="child_cat_id">
                            <option value="">No child category</option>
                            <?php foreach ($child_categories as $child_category): ?>
                                <option value="<?= $child_category->id ?>"><?= $child_category->title ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="edit-brand_id">Brand</label>
                        <select class="form-control" id="edit-brand_id" name="brand_id">
                            <?php foreach ($brands as $brand): ?>
                                <option value="<?= $brand->id ?>"><?= $brand->title ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Simpan</button>
                </form>
            </div>
        </div>
    </div>
</div>
