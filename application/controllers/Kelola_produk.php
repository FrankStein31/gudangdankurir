<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Kelola_produk extends CI_Controller
{
    var $module_js = ['kelola-produk'];
    var $app_data = [];

    public function __construct()
    {
        parent::__construct();
        $this->_init();
        $this->load->model('Produk_model', 'products');
        $this->load->model('Brand_model', 'brand');
        $this->load->model('Category_model', 'category');
        $this->load->library('form_validation');
    }

    private function _init()
    {
        $this->app_data['module_js'] = $this->module_js;
    }

    public function index()
    {
        $this->app_data['products'] = $this->products->get_all_produk();
        $this->app_data['brands'] = $this->brand->get_all_brands();
        $this->app_data['categories'] = $this->category->get_all_categories();

        $this->load->view('header');
        $this->load->view('view_produk', $this->app_data);
        $this->load->view('footer');
        $this->load->view('js-custom', $this->app_data);
    }

    public function get_data()
    {
        $result = $this->products->get_all_produk();
        echo json_encode($result);
    }

    public function get_data_id()
    {
        $id = $this->input->post('id');
        $result = $this->products->get_produk_by_id($id);
        echo json_encode($result);
    }

    public function insert_data()
    {
        $this->form_validation->set_rules('title', 'Title', 'required');
        $this->form_validation->set_rules('slug', 'Slug', 'required');
        $this->form_validation->set_rules('price', 'Price', 'required|numeric');

        if ($this->form_validation->run() == FALSE) {
            $response = [
                'error' => validation_errors()
            ];
        } else {
            try {
                $data = $this->input->post();
                $data['is_featured'] = isset($data['is_featured']) ? 1 : 0;
                
                // Handle child_cat_id
                if (empty($data['child_cat_id'])) {
                    unset($data['child_cat_id']); // Remove from data if empty
                } else {
                    $data['child_cat_id'] = intval($data['child_cat_id']); // Ensure it's an integer
                }

                if ($this->products->insert_produk($data)) {
                    $response['success'] = "Data berhasil ditambahkan";
                } else {
                    $response['error'] = "Gagal menambahkan data";
                }
            } catch (Exception $e) {
                log_message('error', 'Error in insert_data: ' . $e->getMessage());
                $response['error'] = "Terjadi kesalahan saat menambahkan data: " . $e->getMessage();
            }
        }
        echo json_encode($response);
    }

    public function update_data()
    {
        $this->form_validation->set_rules('title', 'Title', 'required');
        $this->form_validation->set_rules('slug', 'Slug', 'required');
        $this->form_validation->set_rules('price', 'Price', 'required|numeric');

        if ($this->form_validation->run() == FALSE) {
            $response = [
                'error' => validation_errors()
            ];
        } else {
            try {
                $id = $this->input->post('id');
                $data = $this->input->post();
                $data['is_featured'] = isset($data['is_featured']) ? 1 : 0;
                
                // Handle child_cat_id
                if (empty($data['child_cat_id'])) {
                    unset($data['child_cat_id']); // Remove from data if empty
                } else {
                    $data['child_cat_id'] = intval($data['child_cat_id']); // Ensure it's an integer
                }

                if ($this->products->update_produk($id, $data)) {
                    $response['success'] = "Data berhasil diperbarui";
                } else {
                    $response['error'] = "Gagal memperbarui data";
                }
            } catch (Exception $e) {
                log_message('error', 'Error in update_data: ' . $e->getMessage());
                $response['error'] = "Terjadi kesalahan saat memperbarui data: " . $e->getMessage();
            }
        }
        echo json_encode($response);
    }

    public function delete_data()
    {
        $id = $this->input->post('id');
        try {
            if ($this->products->delete_produk($id)) {
                $response['success'] = "Data berhasil dihapus";
            } else {
                $response['error'] = "Gagal menghapus data";
            }
        } catch (Exception $e) {
            log_message('error', 'Error in delete_data: ' . $e->getMessage());
            $response['error'] = "Terjadi kesalahan saat menghapus data";
        }
        echo json_encode($response);
    }
}
