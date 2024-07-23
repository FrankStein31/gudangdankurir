<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Brand_model extends CI_Model
{
    public function get_all_brands()
    {
        return $this->db->get('brands')->result();
    }
}
