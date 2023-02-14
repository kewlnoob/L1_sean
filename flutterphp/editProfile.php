<?php

    require("connection.php");

    $userid = $_POST['userid'];
    $password = $_POST['password'];
    $email = $_POST['email'];
    $username = $_POST['username'];

    $sql = "UPDATE users SET email='$email',password='$password',username='$username' WHERE id='$userid'";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }
    $conn->close();

    ?>
