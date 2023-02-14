<?php

require("connection.php");

$userid = $_POST['userid'];

$sql = "SELECT * FROM userslist WHERE userid = '$userid'";
$query = mysqli_query($conn, $sql);

while ($row = mysqli_fetch_assoc($query)) {
    $listid = $row['id'];
    mysqli_query($conn, "DELETE FROM items where listid = '$listid'");
}
$sql2 = "DELETE FROM userslist WHERE userid = '$userid'";

$query2 = mysqli_query($conn, $sql2);

if ($query) {
    echo json_encode("success");
} else {
    echo json_encode("error");
}
$conn->close();
?>