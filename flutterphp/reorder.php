<?php
    require("connection.php");

    $items = json_decode(file_get_contents('php://input'), true);

    foreach ($items as $item) {
        $index = $item['position'];
        $item = $item['id'];

        $query = "UPDATE items SET position = $index WHERE id = '$item'";
        mysqli_query($conn, $query);
    }

    echo json_encode("success");

    $conn->close();
?>