<?php

    require("connection.php");

    $id = $_POST['id'];
    $listname = $_POST['listname'];
    $iconid = $_POST['iconid'];
    $colorid = $_POST['colorid'];
    $categoryid = $_POST['categoryid'];

    $sql = "UPDATE userslist SET
    listname='$listname',colorid='$colorid',
    iconid='$iconid',categoryid='$categoryid' WHERE id='$id'";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }
    $conn->close();

    ?>
