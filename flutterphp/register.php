<?php
    require("connection.php");

    $username = $_POST['username'];
    $password = $_POST['password'];
    $email = $_POST['email'];

    $sql1 = "SELECT email FROM users WHERE email='$email'";
    $result = mysqli_query($conn,$sql1);
    $count = mysqli_num_rows($result);
    if($count == 1){
        echo json_encode("duplicate");
    }
    else{
        $sql = "INSERT INTO users (email,username,password) VALUES ('$email','$username','$password')";
        $query = mysqli_query($conn,$sql);
        if($query){
            echo json_encode("success");
        }else{
            echo json_encode("error");
        }
    }
    $conn->close();


?>