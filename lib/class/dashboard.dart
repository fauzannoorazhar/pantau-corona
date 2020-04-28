class Dashboard {
    String nama;
    String updateTerakhir;
    String sembuh;
    String positif;
    String meninggal;

    String total;

    Dashboard({
        this.nama,
        this.updateTerakhir,
        this.sembuh,
        this.positif,
        this.meninggal,
        this.total
    });

    factory Dashboard.fetchData(Map<String, dynamic> json) {
        return Dashboard(
            nama: json['nama'],
            updateTerakhir: json['updateTerakhir'],
            sembuh: json['sembuh'],
            positif: json['positif'],
            meninggal: json['meninggal'],
            total: json['total']
        );
    }
}