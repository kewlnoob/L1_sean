<?php

    require("connection.php");


    $name = $_POST['name'];
    $description = $_POST['description'];
    $url = $_POST['url'];
    $favourite = $_POST['favourite'];
    $listid = $_POST['listid'];
    $priorityid = $_POST['priorityid'];
    $sql = "INSERT INTO items (name,description,url,isfavourite,listid,priorityid) 
    VALUES('$name','$description','$url','$favourite','$listid','$priorityid')";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }
?>
