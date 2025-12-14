class VehicleModel {
  final String id;
  final String make;
  final String model;
  final String licensePlate;
  final String status;

  VehicleModel({
    required this.id,
    required this.make,
    required this.model,
    required this.licensePlate,
    this.status = 'unknown',
  });
}
