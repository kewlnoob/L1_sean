<?php

    require("connection.php");

    $listid = $_POST['listid'];
    $sql = "DELETE FROM items WHERE listid='$listid'";
    $query = mysqli_query($conn, $sql);

    if ($query) {
        echo json_encode("success");
    } else {
        echo json_encode("error");
    }
    $conn->close();
?>