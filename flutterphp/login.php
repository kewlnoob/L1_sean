<?php
require("connection.php");
$uname = $_POST["email"];
$pword = $_POST["password"];

$sql = "SELECT * from users WHERE email = '$uname' and password = '$pword'";

$results = mysqli_query($conn, $sql);

$userfound = mysqli_num_rows($results);

if ($userfound >= 1) {
    $user = mysqli_fetch_assoc($results);
    echo json_encode(array(
        'userid' => $user["id"],
        'username' => $user["username"], 
        'email' => $user["email"], 
        'password' => $user["password"],
        'image' => $user["image"]
    ));
} else {
    echo json_encode("error");
}
$conn->close();
