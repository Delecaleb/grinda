
class CompletedOrdersModel{
  String serviceProvider, serviceRendered, dateCompleted, amountCharged;
  CompletedOrdersModel({required this.serviceProvider, required this.serviceRendered, required this.dateCompleted, required this.amountCharged});

  factory CompletedOrdersModel.fromJson(Map<String, dynamic> mapdata){
    return CompletedOrdersModel(serviceProvider: mapdata['first_name'], serviceRendered: mapdata['service_rendered'], dateCompleted: mapdata['date_created'], amountCharged: mapdata['amount_charged']);
  } 
}