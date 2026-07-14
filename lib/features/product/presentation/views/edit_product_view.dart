import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../shared/models/product_model.dart';

class EditProductView extends StatefulWidget {
  final ProductModel product;

  const EditProductView({super.key, required this.product});

  @override
  State<EditProductView> createState() => _EditProductViewState();
}

class _EditProductViewState extends State<EditProductView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;
  late TextEditingController categoryController;
  late TextEditingController brandController;
  late TextEditingController materialController;

  late TextEditingController imageController;
  late TextEditingController sizesController;
  late TextEditingController colorsController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    final p = widget.product;

    nameController = TextEditingController(text: p.name);
    descriptionController = TextEditingController(text: p.description);
    priceController = TextEditingController(text: p.price.toString());
    categoryController = TextEditingController(text: p.category);
    brandController = TextEditingController(text: p.brand ?? '');
    materialController = TextEditingController(text: p.material ?? '');

    imageController = TextEditingController(text: p.images.join(','));
    sizesController = TextEditingController(text: p.sizes.join(','));
    colorsController = TextEditingController(text: p.colors.join(','));
  }

  Future<void> updateProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.product.id)
          .update({
        'name': nameController.text,
        'description': descriptionController.text,
        'price': double.parse(priceController.text),
        'category': categoryController.text,
        'brand': brandController.text,
        'material': materialController.text,
        'images': imageController.text.split(','),
        'sizes': sizesController.text.split(','),
        'colors': colorsController.text.split(','),
        'rating': widget.product.rating,
        'reviewCount': widget.product.reviewCount,
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
        title: const Text('Editar Producto',
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
              // ✅ CARD GENERAL
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

                    _input(
                        'Imágenes (url1,url2)', imageController),
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
                    onPressed: isLoading ? null : updateProduct,
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Actualizar Producto',
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
