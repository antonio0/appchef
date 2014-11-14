var http = require('http');

var app = http.createServer(function(req,res){
    res.setHeader('Content-Type', 'application/json');

    var myJSON = [
    {
        "sku": "ZI111C0DY-802",
        "name": "Boots - black",
        "color": "Black",
        "detail": "https://secure-i3.ztat.net/detail_hd/ZI/11/1C/0D/Y8/02/ZI111C0DY-802@1.1.jpg",
        "price": "£85",
        "brand": "Zign"
    },
    {
        "sku": "JK223D01M-G11",
        "name": "Print T-shirt - orange",
        "color": "Orange",
        "detail": "https://secure-i4.ztat.net/detail_hd/JK/22/3D/01/MG/11/JK223D01M-G11@4.jpg",
        "price": "£19",
        "brand": "IKKS"
    },
    {
        "sku": "RE323G008-C11",
        "name": "Print T-shirt - grey",
        "color": "Grey",
        "detail": "https://secure-i5.ztat.net/detail_hd/RE/32/3G/00/8C/11/RE323G008-C11@3.jpg",
        "price": "£34",
        "brand": "Replay"
    },
    {
        "sku": "JK223C01B-G11",
        "name": "Summer dress - multicoloured",
        "color": "Multi-coloured",
        "detail": "https://secure-i6.ztat.net/detail_hd/JK/22/3C/01/BG/11/JK223C01B-G11@5.jpg",
        "price": "£49",
        "brand": "IKKS"
    },
    {
        "sku": "MA621A00R-K11",
        "name": "OLIVIA - Straight leg jeans - blue",
        "color": "Blue",
        "detail": "https://secure-i3.ztat.net/detail_hd/MA/62/1A/00/RK/11/MA621A00R-K11@7.jpg",
        "price": "£50",
        "brand": "Mavi"
    },
    {
        "sku": "A2322G00O-K11",
        "name": "PASI - Summer jacket - blue",
        "color": "Blue",
        "detail": "https://secure-i5.ztat.net/detail_hd/A2/32/2G/00/OK/11/A2322G00O-K11@4.jpg",
        "price": "£60",
        "brand": "Anerkjendt"
    },
    {
        "sku": "RO113A000-J00",
        "name": "SORBET - First shoes - pink",
        "color": "Pink",
        "detail": "https://secure-i3.ztat.net/detail_hd/RO/11/3A/00/0J/00/RO113A000-J00@4.jpg",
        "price": "£22",
        "brand": "Robeez"
    },
    {
        "sku": "KU622O00C-A11",
        "name": "ANATOLE - Print T-shirt - white",
        "color": "White",
        "detail": "https://secure-i3.ztat.net/detail_hd/KU/62/2O/00/CA/11/KU622O00C-A11@4.jpg",
        "price": "£17",
        "brand": "Kulte"
    },
    {
        "sku": "SN422O009-A11",
        "name": "MADUSSA - Print T-shirt - white",
        "color": "White",
        "detail": "https://secure-i5.ztat.net/detail_hd/SN/42/2O/00/9A/11/SN422O009-A11@2.jpg",
        "price": "£34",
        "brand": "Sons of Heroes"
    },
    {
        "sku": "VE121B06R-K12",
        "name": "FLASH - Denim skirt - blue",
        "color": "Blue",
        "detail": "https://secure-i6.ztat.net/detail_hd/VE/12/1B/06/RK/12/VE121B06R-K12@1.jpg",
        "price": "£21",
        "brand": "Vero Moda"
    }
];

    res.end(JSON.stringify(myJSON));
});
app.listen(3000);
