// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract HelloWorld {

    // Variable para almacenar el mensaje de saludo
    string public greeting;

    // Constructor que inicializa el mensaje de saludo
    constructor() {
        greeting = "Hola, Mundo desde Avalanche!";
    }

    // Función para obtener el mensaje de saludo
    function getGreeting() public view returns (string memory) {
        return greeting;
    }
}
