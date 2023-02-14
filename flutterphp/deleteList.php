<?php

    require("connection.php");

    $id = $_POST['id'];

    $sql = "DELETE FROM userslist WHERE id = '$id'";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        $sql2 = "DELETE FROM items WHERE listid = '$id'";
        $query2 = mysqli_query($conn,$sql2);
        if($query2){
            echo json_encode("success");
        }else{
            echo json_encode("error");
        }
    }else{
        echo json_encode("error");
    }
    $conn->close();
    ?>
