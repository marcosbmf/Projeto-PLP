cmake_minimum_required(VERSION 3.10)
project(plp)

set(CMAKE_CXX_STANDARD 11)

add_executable(plp main.cpp models/item.h models/restaurant.h models/client.h models/pedido.h)