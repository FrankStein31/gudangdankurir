<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Order_model extends CI_Model
{
    public function __construct()
    {
        parent::__construct();
        $this->load->database(); // Load database
    }

    // Mendapatkan semua data order
    public function get_all_orders()
    {
        return $this->db->get('orders')->result_array();
    }

    // Mengupdate status order berdasarkan id
    public function update_order($where, $data)
    {
        $this->db->where($where);
        return $this->db->update('orders', $data);
    }
    public function get_order_by_id($id)
    {
        return $this->db->get_where('orders', array('id' => $id))->row_array();
    }

}
?>
