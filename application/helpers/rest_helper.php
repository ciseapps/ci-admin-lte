<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

function response($data,  $code = 200, $message = "Success")
{
    header('Content-Type: application/json');
    $response = new stdClass();
    if ($data) {
        $response->code = $code;
        $response->message = $message;
        $response->result = $data;
    } else {
        $response->code = $code;
        $response->message = $message;
        $response->result = null;
    }
    echo json_encode($response);
}

function responseJSON($data)
{
    header('Content-Type: application/json');
    echo json_encode($data);
}

?>