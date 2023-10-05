class ShipModel {
  late var shipmentID;
  late String departure_time;
  late String arrival_time;
  late String status;
  late String from;
  late String fromname;
  late String to;
  late String toname;

  ShipModel({
    required this.shipmentID,
    required this.departure_time,
    required this.arrival_time,
    required this.status,
    required this.from,
    required this.fromname,
    required this.to,
    required this.toname,
  });
}
