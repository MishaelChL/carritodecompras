class Galeria {
    Galeria({
        this.foto,
        this.precio,
    });

    String foto;
    String precio;

    factory Galeria.fromJson(Map<String, dynamic> json) => Galeria(
        foto: json["foto"],
        precio: json["precio"],
    );

    Map<String, dynamic> toJson() => {
        "foto": foto,
        "precio": precio,
    };
}



