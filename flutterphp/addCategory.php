<?php

    require("connection.php");


    $name = $_POST['name'];
    $id = $_POST['userid'];
    
    $sql = "INSERT INTO category(categoryName, userId) VALUES ('$name','$id')";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }

    ?>
