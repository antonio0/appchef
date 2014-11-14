<?php

// app metadata from get params
$appname = $_GET["appname"];
$author = $_GET["author"];

$userpath = '/Applications/XAMPP/htdocs/projects/user-'.$author;
$apppath = $userpath.'/app-'.$appname;
exec("cd $apppath && zip -r app.zip $appname");

//header("Content-disposition: attachment; filename=app.zip");
//header('Content-type: application/zip');
//readfile("app.zip");
chdir($apppath);
$file = "app.zip";
if (headers_sent()) {
    echo 'HTTP header already sent';
} else {
    if (!is_file($file)) {
        header($_SERVER['SERVER_PROTOCOL'].' 404 Not Found');
        echo 'File not found';
    } else if (!is_readable($file)) {
        header($_SERVER['SERVER_PROTOCOL'].' 403 Forbidden');
        echo 'File not readable';
    } else {
        header($_SERVER['SERVER_PROTOCOL'].' 200 OK');
        header("Content-Type: application/zip");
        header("Content-Transfer-Encoding: Binary");
        header("Content-Length: ".filesize($file));
        header("Content-Disposition: attachment; filename=\"".basename($file)."\"");
        readfile($file);
        exit;
    }
}
?>
