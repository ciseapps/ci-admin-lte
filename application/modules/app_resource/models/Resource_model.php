<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Resource_model extends CI_Model
{

    public function create($data)
    {
        $id = IDGenerator::getInstance()->nextID('app_resource');
        if (!empty($id)) {
            $data['resource_id'] = $id;
        }
        return $this->db->insert('app_resource', $data);
    }

    public function update($data)
    {
        $this->db->where('resource_id', $data['resource_id']);
        return $this->db->update('app_resource', $data);
    }

    public function delete($data)
    {
        $this->db->where('resource_id', $data['resource_id']);
        return $this->db->delete('app_resource');
    }

    public function load($data)
    {
        $field = "a.*, b.role_name ";
        $table = 'app_resource a';
        $joins = ' left join app_role b on a.role_id = b.role_id';
        return easy_pagging($data, $field, $table.$joins);
    }

}
