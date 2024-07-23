<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Dashboard extends CI_Controller
{
    var $module_js = [];
    var $app_data = [];

    public function __construct()
    {
        parent::__construct();
        $this->_init();
    }


    private function _init()
    {
        $this->app_data['module_js'] = $this->module_js;
    }

    public function index()
    {
        // Mengambil data user dari session
        $user_email = $this->session->userdata('email');
        $user_role = $this->session->userdata('role');

        // Menyiapkan pesan selamat datang
        $this->app_data['welcome_message'] = "Selamat datang, " . ($user_email ? $user_email : 'Pengguna') . "!";
        $this->app_data['role_message'] = "Anda login sebagai " . ($user_role ? ucfirst($user_role) : 'Pengguna');

        // Load view
        $this->load->view('header');
        $this->load->view('view_dashboard', $this->app_data);
        $this->load->view('footer');
        $this->load->view('js-custom', $this->app_data);
    }
}