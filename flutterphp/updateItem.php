<?php

    require("connection.php");


    $name = $_POST['name'];
    $description = $_POST['description'];
    $url = $_POST['url'];
    $favorite = $_POST['favorite'];
    $id = $_POST['id'];
    $priorityid = $_POST['priorityid'];
    $sql = "UPDATE items SET name = '$name',description = '$description',url = '$url',
    isfavourite='$favorite', priorityid='$priorityid' WHERE id = '$id'";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }
?>
