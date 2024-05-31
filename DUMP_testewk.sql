-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 01-Jun-2024 às 01:07
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `testewk`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `codigo` int(11) NOT NULL,
  `nome` varchar(150) DEFAULT NULL,
  `cidade` varchar(150) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`codigo`, `nome`, `cidade`, `uf`) VALUES
(1, 'João das Couves (1)', 'São Paulo', 'SP'),
(2, 'João das Neves (2)', 'São Paulo', 'SP'),
(3, 'José de Arimatéia (3)', 'São Paulo', 'SP'),
(4, 'Paulo das Couves (4)', 'São Paulo', 'SP'),
(5, 'Rodrigo Joaquim (5)', 'São Vicente', 'SP'),
(6, 'Henrique Silva (6)', 'Meridiano', 'SP'),
(7, 'Valdirene Couves (7)', 'Sorocaba', 'SP'),
(8, 'Mariana Couves (8)', 'Sorocaba', 'SP'),
(9, 'Maria Silva (9)', 'Belo Horizonte', 'MG'),
(10, 'Joaquina Alvares (10)', 'Ipatinga', 'MG'),
(11, 'Valkiria Couves(11)', 'Ipatinga', 'MG'),
(12, 'João das Marias (12)', 'Blumenau', 'SC'),
(13, 'Berta Bens (13)', 'Blumenau', 'SC'),
(14, 'Aldeide Pinto (14)', 'São Paulo', 'SP'),
(15, 'Joaquina Valeris (15)', 'São Paulo', 'SP'),
(16, 'Paulo Virtuoso (16)', 'São Paulo', 'SP'),
(17, 'Vigário da Silva (17)', 'São Paulo', 'SP'),
(18, 'João das Ovelhas (18)', 'Porto Alegre', 'RS'),
(19, 'Nardini (19)', 'Porto Alegre', 'RS'),
(20, 'Cristiane (20)', 'Porto Alegre', 'RS');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos`
--

CREATE TABLE `pedidos` (
  `numero_ped` int(11) NOT NULL,
  `data_emissao` datetime DEFAULT current_timestamp(),
  `codigo_cliente` int(11) DEFAULT NULL,
  `valor_total` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `pedidos`
--

INSERT INTO `pedidos` (`numero_ped`, `data_emissao`, `codigo_cliente`, `valor_total`) VALUES
(1, '2024-05-31 00:00:00', 2, 940);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedidos_item`
--

CREATE TABLE `pedidos_item` (
  `numero_item` int(11) NOT NULL,
  `numero_pedido` int(11) NOT NULL,
  `codigo_produto` int(11) NOT NULL,
  `quantidade` float NOT NULL DEFAULT 0,
  `valor_unitario` float NOT NULL DEFAULT 0,
  `valor_total` float NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE `produtos` (
  `codigo` int(11) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `precovenda` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`codigo`, `descricao`, `precovenda`) VALUES
(1, 'Produto 100', 10),
(2, 'Produto 101', 11),
(3, 'Produto 102', 12),
(4, 'Produto 103', 13),
(5, 'Produto 104', 14),
(6, 'Produto 105', 15),
(7, 'Produto 106', 16),
(8, 'Produto 107', 17),
(9, 'Produto 108', 18),
(10, 'Produto 109', 19),
(11, 'Produto 110', 20),
(12, 'Produto 111', 21),
(13, 'Produto 112', 22),
(14, 'Produto 113', 23),
(15, 'Produto 114', 24),
(16, 'Produto 115', 25),
(17, 'Produto 116', 26),
(18, 'Produto 117', 27),
(19, 'Produto 118', 28),
(20, 'Produto 119', 30);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `idx_cliente_nome` (`nome`),
  ADD KEY `idx_cliente_cidade` (`cidade`),
  ADD KEY `idx_cliente_uf` (`uf`);

--
-- Índices para tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`numero_ped`),
  ADD KEY `idx_pedidos_emissao` (`data_emissao`),
  ADD KEY `idx_pedidos_cliente` (`codigo_cliente`);

--
-- Índices para tabela `pedidos_item`
--
ALTER TABLE `pedidos_item`
  ADD PRIMARY KEY (`numero_item`),
  ADD KEY `idx_item_pedido` (`numero_pedido`),
  ADD KEY `idx_item_produto` (`codigo_produto`);

--
-- Índices para tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`codigo`),
  ADD KEY `idx_produtos_descricao` (`descricao`) USING BTREE;

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `numero_ped` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `pedidos_item`
--
ALTER TABLE `pedidos_item`
  MODIFY `numero_item` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `codigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `FK_CLIENTE` FOREIGN KEY (`codigo_cliente`) REFERENCES `clientes` (`codigo`);

--
-- Limitadores para a tabela `pedidos_item`
--
ALTER TABLE `pedidos_item`
  ADD CONSTRAINT `FK_PEDIDO` FOREIGN KEY (`numero_pedido`) REFERENCES `pedidos` (`numero_ped`),
  ADD CONSTRAINT `FK_PRODUTO` FOREIGN KEY (`codigo_produto`) REFERENCES `produtos` (`codigo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
