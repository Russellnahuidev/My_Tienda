import 'package:my_tienda/features/shippin_address/models/address.dart';

class AddressRepository {
  List<Address> getAddresses() {
    return const [
      Address(
        id: '1',
        label: 'Home',
        fullAddress: '123 Main Streed, apt 4B',
        city: 'Ayacucho',
        state: 'AYA',
        zipCode: '5001',
        isDefault: true,
        type: AddressType.home,
      ),
      Address(
        id: '2',
        label: 'Office',
        fullAddress: '456 Busines Av, Suite 200',
        city: 'Ayacucho',
        state: 'AYA',
        zipCode: '5002',
        type: AddressType.office,
      ),
      Address(
        id: '3',
        label: 'Univercity',
        fullAddress: 'Independient Univercity',
        city: 'Ayacucho',
        state: 'AYA',
        zipCode: '5001',
        type: AddressType.other,
      ),
    ];
  }

  Address? getDefaultAddress() {
    return getAddresses().firstWhere(
      (address) => address.isDefault,
      orElse: () => getAddresses().first,
    );
  }
}
