<?php

require("connection.php");

$userid = $_POST['userid'];


$sql = "SELECT * FROM userslist WHERE userid = '$userid'";

$query = mysqli_query($conn, $sql);

while ($row = mysqli_fetch_assoc($query)) {
    $listid = $row['id'];
    mysqli_query($conn, "DELETE FROM items where listid = '$listid' and isarchive='1'");
}

echo json_encode("success");

$conn->close();
?>