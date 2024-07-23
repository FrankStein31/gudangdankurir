<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class User_model extends CI_Model {

    public function get_user_by_email($email) {
        return $this->db->where('email', $email)->get('users')->row();
    }

    // Tambahkan metode lain yang Anda perlukan di sini
}