import 'package:flutter/material.dart';
import 'api_service.dart';
import 'plant.dart';

class AddPlantScreen extends StatefulWidget {
  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _commonNameController = TextEditingController();
  final TextEditingController _botanicalNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _usesController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void _submitPlant() async {
    if (_formKey.currentState!.validate()) {
      final plant = Plant(
        id: '', // MongoDB auto-generates it
        commonName: _commonNameController.text,
        botanicalName: _botanicalNameController.text,
        category: _categoryController.text,
        uses: _usesController.text,
        price: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
      );

      try {
        await ApiService.addPlant(plant);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add plant")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Herbal Plant",style: TextStyle(color: Colors.white),),backgroundColor: Colors.green[900],),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_commonNameController, "Common Name"),
              _buildTextField(_botanicalNameController, "Botanical Name"),
              _buildTextField(_categoryController, "Category"),
              _buildTextField(_usesController, "Uses"),
              _buildTextField(_priceController, "Price", isNumber: true),
              _buildTextField(_imageUrlController, "Image URL"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitPlant,
                child: Text("Add Plant"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
