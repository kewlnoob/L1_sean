<?php

    require("connection.php");


    $listname = $_POST['listname'];
    $iconid = $_POST['iconid'];
    $colorid = $_POST['colorid'];
    $userid = $_POST['userid'];
    $categoryid = $_POST['categoryid'];

    $sql = "INSERT INTO userslist
    (listname, colorid, iconid, userid,categoryid) VALUES 
    ('$listname','$colorid','$iconid','$userid','$categoryid')";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }

    ?>
