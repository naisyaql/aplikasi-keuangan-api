<?php 
    require 'functions.php';
    
    if (empty($_POST['tanggal']) || empty($_POST['keterangan']) || empty($_POST['keperluan']) || empty($_POST['jumlah']) || empty($_POST['username'])) {
        echo '{"status" : "Error", "Message" : "tanggal, keterangan, keperluan, jumlah, and username is required!"}';
        exit();
    }

    // tambah data
    $tanggal = htmlspecialchars($_POST["tanggal"]);
    $keterangan = htmlspecialchars($_POST["keterangan"]);
    $keperluan = htmlspecialchars($_POST["keperluan"]);
    $jumlah = htmlspecialchars(str_replace(".", "",$_POST["jumlah"]));
    $username = $_POST['username'];

    // query insert data
    $query = "INSERT INTO pengeluaran VALUES ('', '$tanggal', '$keterangan', '$keperluan', '$jumlah', '$username')";
    
    if (mysqli_query($koneksi, $query)) {
        echo '{"Status" : "Succes", "Message" : "Data berhasil ditambahkan!"}';
    } else {
        echo '{"Status" : "Error", "Message" : '.mysqli_error($koneksi).'}';
    }
?>