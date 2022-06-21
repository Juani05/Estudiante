// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;
contract Estuiante {
    // declaro variables
    string private _name;
    string private _apellido;
    string private _curso;
    address private _docente;
    string [] private _materias;
    mapping (string => uint) private _notas_materias;

    //creo el constructor con las features del contrato
    constructor (string memory name_, string memory apellido_, string memory curso_) {
        _name= name_;
        _apellido= apellido_;
        _curso= curso_;
        _docente= msg.sender;
    }
    //función que me devuelve el apellido del alumno
    function name () public view returns (string memory) {
        return _name;
    }

    //funcion que me devuelve el nombre completo del alumno
    function nombre_completo () public view returns (string memory) {
         return string.concat(_name," ",_apellido);
    }

    //funcion que me devuelve el curso del alumno
    function curso () public view returns (string memory) {
         return _curso;
    }

    //funcion que checkea que seas el profesor, y si es asi, asigna una nota a una materia
    function set_nota_materia (string memory materia, uint valor) public {
        require (_docente == msg.sender, "No sos el docente de esta clase");
        _notas_materias[materia] = valor;
        _materias.push (materia);
    } 

    //funcion que me devuelve la nota de una materia
    function get_nota_materia(string memory materia) public view returns (uint) {
        return _notas_materias[materia];
    }

    //funcion que checkea si el alumno aprobo o no una cierta materia
    function aprobo(string memory materia) public view returns (bool) {
        if (_notas_materias[materia] >= 6 ) {
            return true;
        }

        else {
            return false;
        }
    }

    //funcion que suma todas las notas del alumno y las divide por la cantidad de materias (Promedio)
    function promedio () public view returns (uint) {
        uint promedio_ = 0;
        for (uint i= 0; i < _materias.length; i++) {
            promedio_ += _notas_materias [_materias [i]];
        }
        promedio_ = promedio_/_materias.length;

        return promedio_; 
    }
}
