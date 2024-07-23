<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Produk_model extends CI_Model
{
    public function get_all_produk()
    {
        return $this->db->get('products')->result();
    }

    public function get_produk_by_id($id)
    {
        return $this->db->get_where('products', ['id' => $id])->row();
    }

    public function insert_produk($data)
    {
        return $this->db->insert('products', $data);
    }

    // public function update_produk($id, $data)
    // {
    //     return $this->db->where('id', $id)->update('products', $data);
    // }
    public function update_produk($id, $data)
    {
        // If child_cat_id is null, use NULL in the query
        if (array_key_exists('child_cat_id', $data) && $data['child_cat_id'] === null) {
            $this->db->set('child_cat_id', NULL, FALSE);
            unset($data['child_cat_id']);
        }

        $this->db->where('id', $id);
        return $this->db->update('products', $data);
    }

    public function delete_produk($id)
    {
        return $this->db->delete('products', ['id' => $id]);
    }
}
