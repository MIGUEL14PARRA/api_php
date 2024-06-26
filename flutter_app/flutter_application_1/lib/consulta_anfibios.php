<?php
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "ras";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die(json_encode(array("mensaje" => "Error en la conexión a la base de datos: " . $conn->connect_error)));
}

$sql = "SELECT nombre, nombre_cientifico, veneno, habitos, habitat FROM anfibios";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $registros = array();
    while($row = $result->fetch_assoc()) {
        $registros[] = $row;
    }
    echo json_encode(array("registros" => $registros));
} else {
    echo json_encode(array("mensaje" => "No se encontraron registros"));
}

$conn->close();
?>
