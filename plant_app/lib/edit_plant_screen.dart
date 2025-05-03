import 'package:flutter/material.dart';
import 'plant.dart';
import 'api_service.dart';

class EditPlantScreen extends StatefulWidget {
  final Plant plant;

  const EditPlantScreen({super.key, required this.plant});

  @override
  State<EditPlantScreen> createState() => _EditPlantScreenState();
}

class _EditPlantScreenState extends State<EditPlantScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController commonNameController;
  late TextEditingController botanicalNameController;
  late TextEditingController categoryController;
  late TextEditingController usesController;
  late TextEditingController priceController;
  late TextEditingController imageUrlController;

  @override
  void initState() {
    super.initState();
    commonNameController = TextEditingController(text: widget.plant.commonName);
    botanicalNameController = TextEditingController(text: widget.plant.botanicalName);
    categoryController = TextEditingController(text: widget.plant.category);
    usesController = TextEditingController(text: widget.plant.uses);
    priceController = TextEditingController(text: widget.plant.price.toString());
    imageUrlController = TextEditingController(text: widget.plant.imageUrl);
  }

  @override
  void dispose() {
    commonNameController.dispose();
    botanicalNameController.dispose();
    categoryController.dispose();
    usesController.dispose();
    priceController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  void _updatePlant() async {
    if (_formKey.currentState!.validate()) {
      final updatedPlant = Plant(
        id: widget.plant.id,
        commonName: commonNameController.text,
        botanicalName: botanicalNameController.text,
        category: categoryController.text,
        uses: usesController.text,
        price: double.parse(priceController.text),
        imageUrl: imageUrlController.text,
      );

      bool success = await ApiService.updatePlant(widget.plant.id!, updatedPlant);
      if (success) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update plant')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Plant')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: commonNameController,
                decoration: const InputDecoration(labelText: 'Common Name'),
                validator: (value) => value!.isEmpty ? 'Enter common name' : null,
              ),
              TextFormField(
                controller: botanicalNameController,
                decoration: const InputDecoration(labelText: 'Botanical Name'),
                validator: (value) => value!.isEmpty ? 'Enter botanical name' : null,
              ),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) => value!.isEmpty ? 'Enter category' : null,
              ),
              TextFormField(
                controller: usesController,
                decoration: const InputDecoration(labelText: 'Uses'),
                validator: (value) => value!.isEmpty ? 'Enter uses' : null,
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                controller: imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) => value!.isEmpty ? 'Enter image URL' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updatePlant,
                child: const Text('Update Plant'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
