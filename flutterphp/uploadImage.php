<?php
    require("connection.php");
    $id = $_POST['id'];
    $file = $_FILES['image']['name'];
    $filepath = "images/" . $file;
    move_uploaded_file($_FILES['image']['tmp_name'],$filepath);
    $sql = "UPDATE users SET image='$file' WHERE id = '$id'";
    $query = mysqli_query($conn,$sql);
?>