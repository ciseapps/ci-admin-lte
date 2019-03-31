<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

function param_input()
{
    $ci =& get_instance();
    $param = $ci->input->post(NULL, TRUE);
    if (!$param) {
        $param = json_decode(file_get_contents('php://input'), true);;
    }
    return $param;
}

function upload_wrapper($input_name)
{
    $CI = &get_instance();
    $temp_array = array();
    foreach ($_FILES[$input_name] as $key => $val) {
        $i = 0;
        foreach ($val as $new_key) {
            $temp_array[$i][$key] = $new_key;
            $i++;
        }
    }
    $i = 0;
    foreach ($temp_array as $key => $val) {
        $_FILES['file' . $i] = $val;
        $i++;
    }
    #clear the original array;
    unset($_FILES[$input_name]);
    // return $temp_array;
    $config = array(
        'upload_path' => dirname($_SERVER["SCRIPT_FILENAME"]) . "/uploads/",
        'upload_url' => base_url() . "uploads/",
        'allowed_types' => "gif|jpg|png|jpeg|pdf|doc|docx|xml",
        'overwrite' => TRUE,
        'max_size' => "10000KB",
        'max_height' => "768",
        'max_width' => "1024"
    );
    $CI->load->library('upload', $config);
    foreach ($_FILES as $key => $value) {
        if (!empty($value['name'])) {
            if ($CI->upload->do_upload($key)) {
                $CI->upload->data();
            }
        }
    }
}

?>