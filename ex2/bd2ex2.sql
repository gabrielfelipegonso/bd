-- Criação do Banco de Dados
CREATE DATABASE LojaExemplo;
USE LojaExemplo;

-- Criação das Tabelas
CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20)
);

CREATE TABLE Produtos (
    ProdutoID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    Estoque INT NOT NULL
);

CREATE TABLE Pedidos (
    PedidoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT,
    ProdutoID INT,
    DataPedido DATE,
    Quantidade INT,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Inserção de Dados
INSERT INTO Clientes (Nome, Email, Telefone) VALUES 
('João Silva', 'joao.silva@example.com', '123456789'),
('Maria Oliveira', 'maria.oliveira@example.com', '987654321'),
('Carlos Pereira', 'carlos.pereira@example.com', '555555555');

INSERT INTO Produtos (Nome, Preco, Estoque) VALUES 
('Produto A', 10.00, 100),
('Produto B', 20.00, 50),
('Produto C', 30.00, 75);

-- Criação do Trigger
CREATE TRIGGER atualiza_estoque
AFTER INSERT ON Pedidos
FOR EACH ROW
BEGIN
    UPDATE Produtos
    SET Estoque = Estoque - NEW.Quantidade
    WHERE ProdutoID = NEW.ProdutoID;
END;

-- Consultas Utilizando Joins
SELECT 
    Pedidos.PedidoID,
    Clientes.Nome AS ClienteNome,
    Clientes.Email,
    Pedidos.DataPedido,
    Pedidos.Quantidade
FROM 
    Pedidos
JOIN 
    Clientes ON Pedidos.ClienteID = Clientes.ClienteID;

SELECT 
    Pedidos.PedidoID,
    Produtos.Nome AS ProdutoNome,
    Produtos.Preco,
    Pedidos.DataPedido,
    Pedidos.Quantidade
FROM 
    Pedidos
JOIN 
    Produtos ON Pedidos.ProdutoID = Produtos.ProdutoID;

SELECT 
    Pedidos.PedidoID,
    Clientes.Nome AS ClienteNome,
    Produtos.Nome AS ProdutoNome,
    Produtos.Preco,
    Pedidos.DataPedido,
    Pedidos.Quantidade
FROM 
    Pedidos
JOIN 
    Clientes ON Pedidos.ClienteID = Clientes.ClienteID
JOIN 
    Produtos ON Pedidos.ProdutoID = Produtos.ProdutoID;
