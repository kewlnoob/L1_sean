<?php

    require("connection.php");
    
    $userid = $_GET['userid'];
    $show = $_GET['show'];

    $sql = "SELECT * FROM userslist WHERE userid='$userid' order by id";

    $list = array();
    $result = mysqli_query($conn,$sql);
    while($row = mysqli_fetch_assoc($result)){
        $listid = $row['id'];
        $listname = $row['listname'];
        $item = mysqli_query($conn,"SELECT * FROM items WHERE listid='$listid' order by iscompleted asc");
        $items = array();
        while($item_row = mysqli_fetch_assoc($item)){
            if($item_row['iscompleted'] == 0){
                $item_row['iscompleted'] = false;
            }else{
                $item_row['iscompleted'] = true;
            }
            
            if($item_row['isfavourite'] == 0){
                $item_row['isfavourite'] = false;
            }else{
                $item_row['isfavourite'] = true;
            }

            if($item_row['isarchive'] == 0){
                $item_row['isarchive'] = false;
            }else{
                $item_row['isarchive'] = true;
            }

            
            if($show == 'show'){
                $items[] = $item_row;
            }
            else if (!$item_row['iscompleted'] && $show =='hide'){
                $items[] = $item_row;
            }
        }
        $list[] = array('name' => $listname, 'items' => $items);
    }

    echo json_encode($list);

    $conn->close();
?>