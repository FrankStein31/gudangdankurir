<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Category_model extends CI_Model
{
    public function get_all_categories()
    {
        return $this->db->get('categories')->result();
    }
}
