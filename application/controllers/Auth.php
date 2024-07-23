<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Auth extends CI_Controller {
    public function __construct() {
        parent::__construct();
        $this->load->model('User_model');
        $this->load->library('form_validation');
    }

    public function login() {
        if ($this->session->userdata('user_id')) {
            redirect('produk'); // Redirect to home page if already logged in
        }
        $this->load->view('login');
    }

    public function authenticate() {
        $this->form_validation->set_rules('email', 'Email', 'required|valid_email');
        $this->form_validation->set_rules('password', 'Password', 'required');
    
        if ($this->form_validation->run() == FALSE) {
            $this->load->view('login');
        } else {
            $email = $this->input->post('email');
            $password = $this->input->post('password');
    
            $user = $this->User_model->get_user_by_email($email);
    
            if ($user && password_verify($password, $user->password)) {
                // Cek apakah peran pengguna adalah kurir atau gudang
                if ($user->role == 'gudang') {
                    $user_data = [
                        'user_id' => $user->id,
                        'email' => $user->email,
                        'role' => $user->role
                    ];
                    $this->session->set_userdata($user_data);
                    redirect('produk');
                } elseif ($user->role == 'kurir') {
                    $user_data = [
                        'user_id' => $user->id,
                        'email' => $user->email,
                        'role' => $user->role
                    ];
                    $this->session->set_userdata($user_data);
                    redirect('order');
                }
                else {
                    $this->session->set_flashdata('error', 'Anda tidak memiliki izin untuk mengakses sistem ini.');
                    redirect('auth/login');
                }
            } else {
                $this->session->set_flashdata('error', 'Email atau password tidak valid');
                redirect('auth/login');
            }
        }
    }

    public function logout() {
        $this->session->sess_destroy();
        redirect('auth/login');
    }

    // Add this method to check if user is logged in
    public function check_login() {
        if (!$this->session->userdata('user_id')) {
            redirect('auth/login');
        }
    }
}