import 'package:flutter/material.dart';

void main() {
  runApp(VerificarIMC());
}

class VerificarIMC extends StatefulWidget {
  @override
  _VerificarIMCState createState() => _VerificarIMCState();
}

class _VerificarIMCState extends State<VerificarIMC> {
  final _form = GlobalKey<FormState>();
  final _valorPeso = TextEditingController();
  final _valorAltura = TextEditingController();
  String _resultado = "Resultado";
  String _classificacao = "";
  bool _showClearButton = false;

  void _calcularIMC() {
    double? peso = double.tryParse(_valorPeso.text);
    double? altura = double.tryParse(_valorAltura.text);

    if (peso != null && altura != null) {
      double imc = peso / (altura * altura);
      setState(() {
        _resultado = "Seu IMC é: ${imc.toStringAsFixed(2)}";

        if (imc <= 18.5) {
          _classificacao = "Classificação: Abaixo do peso";
        } else if (imc >= 18.6 && imc <= 24.9) {
          _classificacao = "Classificação: Peso normal";
        } else if (imc >= 25 && imc <= 29.9) {
          _classificacao = "Classificação: Acima do peso";
        } else if (imc >= 30 && imc <= 39.9) {
          _classificacao = "Obesidade grau 1";
        } else if (imc >= 40) {
          _classificacao = "Obesidade grau 2";
        }

        _showClearButton = true;
      });
    } else {
      setState(() {
        _resultado = "Informe peso e altura válidos.";
      });
    }
  }

  void _limparCampos() {
    _valorPeso.text = "";
    _valorAltura.text = "";
    // Oculta o botão de limpar
    _showClearButton = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 23.0),
            child: Column(
              children: [
                Image(
                  image: AssetImage('assets/gif_01.gif'),
                ),
                Text('Verifique seu IMC',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      Container(
                        width: 320,
                        child: TextFormField(
                          controller: _valorPeso,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Insira o seu peso',
                            labelStyle: TextStyle(
                              color: Color(0xFF9400d3),
                              fontSize: 20,
                            ),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF9400d3),
                              ),
                            ),
                            prefixIcon:
                                Icon(Icons.balance, color: Color(0xFF9400d3)),
                            suffix: Text(
                              'Kg',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          cursorColor: Color(0xFF9400d3),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o peso';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 320,
                        child: TextFormField(
                          controller: _valorAltura,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Insira a sua altura',
                            labelStyle: TextStyle(
                                color: Color(0xFF9400d3), fontSize: 20),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF9400d3),
                              ),
                            ),
                            prefixIcon:
                                Icon(Icons.height, color: Color(0xFF9400d3)),
                            suffix: Text(
                              'm',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          cursorColor: Color(0xFF9400d3),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Insira a sua altura';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 320,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_form.currentState!.validate()) {
                              _calcularIMC();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF9400d3),
                          ),
                          child: Text(
                            'Calcular IMC',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(_resultado, style: TextStyle(fontSize: 20)),
                      Text(_classificacao,
                          style: TextStyle(fontSize: 20, color: Colors.red)),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _resultado = "Resultado";
                              _classificacao = "";
                            });
                            _limparCampos();
                          },
                          child: _showClearButton
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 95.0, left: 284.0),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/borracha.png'),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(), // Se _showClearButton for falso, não exibe nada
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
