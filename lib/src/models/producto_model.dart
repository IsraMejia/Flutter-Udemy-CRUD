// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);
/**La siguiente pagina web te lo genera en automatico, solo se tiene que meter el json deseado
 * https://app.quicktype.io/?share=4Ik8Upww0mN33e2CBVmq
 */
import 'dart:convert'; 

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
    ProductoModel({
        this.id,
        this.titulo ='',
        this.valor=0.0,
        this.disponible=true,
        this.fotoUrl,
    });

    String id;
    String titulo;
    double valor;
    bool disponible;
    String fotoUrl;

    factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
    //Que resa un factory permite retornar una nueva instancia del ProductoModel recibiendo un mapa
    //Esto permite asignar los valores a cada uno de sus propiedades
        id         : json["id"],
        titulo     : json["titulo"],
        valor      : json["valor"],
        disponible : json["disponible"],
        fotoUrl    : json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
    //Mapa lo pasa a JSON, toma el mapa y lo pasa a JSON
        // "id"        : id, //No se manda porque al editar los items se duplica
        "titulo"    : titulo,
        "valor"     : valor,
        "disponible": disponible,
        "fotoUrl"   : fotoUrl,
    };
}
