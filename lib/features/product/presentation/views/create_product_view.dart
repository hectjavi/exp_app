import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreateProductView extends StatefulWidget {
  const CreateProductView({super.key});

  @override
  State<CreateProductView> createState() =>
      _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final brandController = TextEditingController();
  final materialController = TextEditingController();

  final imagesController = TextEditingController();
  final sizesController = TextEditingController();
  final colorsController = TextEditingController();

  bool isLoading = false;

  Future<void> createProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('products').add({
        'name': nameController.text,
        'description': descriptionController.text,
        'price': double.parse(priceController.text),
        'category': categoryController.text,
        'brand': brandController.text,
        'material': materialController.text,

        'images': imagesController.text.split(','),
        'sizes': sizesController.text.split(','),
        'colors': colorsController.text.split(','),

        'rating': 0,
        'reviewCount': 0,
      });

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    }

    setState(() => isLoading = false);
  }

  Widget _input(String label, TextEditingController controller,
      {TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color(0xFFF1F4F9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (v) =>
            v == null || v.isEmpty ? 'Campo requerido' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF4A90E2),
        title: const Text('Crear Producto',
                            style: TextStyle(
                            
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ✅ CARD
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _input('Nombre', nameController),
                    _input('Descripción', descriptionController),
                    _input('Precio', priceController,
                        type: TextInputType.number),
                    _input('Categoría', categoryController),
                    _input('Marca', brandController),
                    _input('Material', materialController),

                    const Divider(height: 30),

                    _input('Imágenes (url1,url2)', imagesController),
                    _input('Tallas (S,M,L)', sizesController),
                    _input('Colores (#fff,#000)', colorsController),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ✅ BOTÓN MODERNO
              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4A90E2),
                        Color(0xFF5DADE2),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: isLoading ? null : createProduct,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Crear Producto',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}