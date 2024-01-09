import 'package:dsi32_flutter_project/features/products/domain/entities/product.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/addUpdateDeleteBloc/add_update_delete_product_bloc.dart';
import 'package:dsi32_flutter_project/features/products/presentation/blocs/landingPageBloc/landing_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductForm extends StatefulWidget {
  final bool isUpdateProduct;
  final Product? myProduct;
  const AddProductForm({
    Key? key,
    this.myProduct,
    required this.isUpdateProduct,
  }) : super(key: key);

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _discountController = TextEditingController();
  String? productId = "";
  // File? _ProductImage;

  @override
  void initState() {
    if (widget.isUpdateProduct) {
      _titleController.text = widget.myProduct!.title;
      _descriptionController.text = widget.myProduct!.description;
      _priceController.text = widget.myProduct!.price.toString();
      _discountController.text =
          widget.myProduct!.discountPercentage.toString();
      productId = widget.myProduct!.id;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: _discountController,
              decoration:
                  const InputDecoration(labelText: 'Discount Percentage'),
              keyboardType: TextInputType.number,
            ),
          ),
          //_buildImagePickerField(),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              _validateFormThenUpdateOrAddPost();
              context.read<LandingPageBloc>().add(TabChange(tabIndex: 0));
            },
            child:
                Text(widget.isUpdateProduct ? "Update Product" : "Add Product"),
          ),
        ],
      ),
    );
  }

  /* Widget _buildImagePickerField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Choose an Image'),
        ElevatedButton(
          onPressed: _pickImage,
          child: const Text('Pick Your Product Image'),
        ),
        _ProductImage != null
            ? Image.file(_ProductImage!)
            : const Text('No image selected'),
      ],
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _ProductImage = File(pickedFile.path);
      });
    }
  }*/

  void _validateFormThenUpdateOrAddPost() {
    if (_formKey.currentState!.validate()) {
      if (widget.isUpdateProduct) {
        Product updatedProduct = Product(
          id: productId,
          title: _titleController.text,
          description: _descriptionController.text,
          price: double.parse(_priceController.text),
          discountPercentage: double.parse(_discountController.text),
          //image: _ProductImage
        );
        BlocProvider.of<AddUpdateDeleteProductBloc>(context)
            .add(UpdateProductEvent(product: updatedProduct));
      } else {
        Product product = Product(
          title: _titleController.text,
          description: _descriptionController.text,
          price: double.parse(_priceController.text),
          discountPercentage: double.parse(_discountController.text),
          //image: _ProductImage
        );
        BlocProvider.of<AddUpdateDeleteProductBloc>(context)
            .add(AddProductEvent(product: product));
      }
    }
  }
}
