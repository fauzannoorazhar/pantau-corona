class Provinsi {
    int fid;
    int kodeProvinsi;
    String namaProvinsi;
    int totalSembuh;
    int totalPositif;
    int totalMeninggal;

    Provinsi({
        this.fid,
        this.kodeProvinsi,
        this.namaProvinsi,
        this.totalSembuh,
        this.totalPositif,
        this.totalMeninggal,
    });

    factory Provinsi.fetchData(Map<String, dynamic> json) {
        return Provinsi(
            fid: json['FID'],
            kodeProvinsi: json['Kode_Provi'],
            namaProvinsi: json['Provinsi'],
            totalPositif: json['Kasus_Posi'],
            totalSembuh: json['Kasus_Semb'],
            totalMeninggal: json['Kasus_Meni'],
        );
    }
}