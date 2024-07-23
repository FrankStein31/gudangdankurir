<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Kelola_order extends CI_Controller
{
    var $module_js = ['kelola-kategori'];
    var $app_data = [];

    public function __construct()
    {
        parent::__construct();
        $this->_init();
        $this->load->model('order_model'); // Load model order
    }

    private function _init()
    {
        $this->app_data['module_js'] = $this->module_js;
    }

    public function index()
    {
        $data['orders'] = $this->order_model->get_all_orders(); // Ambil semua data order
        $this->load->view('header');
        $this->load->view('view_order', $data); // Tampilkan view order dengan data orders
        $this->load->view('footer');
        $this->load->view('js-custom', $this->app_data);
    }

    public function edit_payment_status()
    {
        $order_id = $this->input->post('id');
        $status = $this->input->post('status');

        // Pastikan status yang diinputkan adalah valid
        $valid_status = ['paid', 'unpaid'];
        if (!in_array($status, $valid_status)) {
            $response['error'] = "Status pembayaran tidak valid";
            echo json_encode($response);
            return;
        }

        $data = array('payment_status' => $status);
        $where = array('id' => $order_id);

        $updated = $this->order_model->update_order($where, $data);

        if ($updated) {
            $response['success'] = "Status pembayaran berhasil diupdate";
        } else {
            $response['error'] = "Gagal mengupdate status pembayaran";
        }

        echo json_encode($response);
    }

    public function edit_status()
    {
        $order_id = $this->input->post('id');
        $status = $this->input->post('status');

        // Pastikan status yang diinputkan adalah valid
        $valid_status = ['new', 'process', 'delivered', 'cancel'];
        if (!in_array($status, $valid_status)) {
            $response['error'] = "Status tidak valid";
            echo json_encode($response);
            return;
        }

        $data = array('status' => $status);
        $where = array('id' => $order_id);

        $updated = $this->order_model->update_order($where, $data); // Update status order

        if ($updated) {
            $response['success'] = "Status order berhasil diupdate";
        } else {
            $response['error'] = "Gagal mengupdate status order";
        }

        echo json_encode($response);
    }

    public function detail_order($id)
    {
        $data['order'] = $this->order_model->get_order_by_id($id);
        if (!$data['order']) {
            show_404();
        }

        $this->load->view('header');
        $this->load->view('detail_order', $data);
        $this->load->view('footer');
        $this->load->view('js-custom', $this->app_data);
    }

}
?>
