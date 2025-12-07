PROJECT - ASYNCHRONOUS FIFO (Dual Clock FIFO)

This project implements an Asynchronous FIFO using Verilog HDL, designed to transfer data safely between two different clock domains. The FIFO supports 8-bit data and provides a 64-location buffer, making it suitable for digital systems where the write and read operations occur at different clock speeds. The design ensures stable data transfer between unrelated clocks without data corruption, overflow, or underflow.

PROJECT OVERVIEW

The FIFO uses separate write and read clocks, allowing each side of the system to operate independently. Data written into the FIFO is stored in an internal memory array, and the design maintains both read and write pointers to track the current positions. A counter keeps track of the number of stored elements and updates the full and empty flags accordingly. The logic ensures that writes happen only when there is available space and reads happen only when valid data exists.

WORKING

The FIFO operates by incrementing the write pointer on every valid write and incrementing the read pointer on every valid read. The internal count reflects the total number of stored bytes, allowing the module to determine when the buffer becomes full or empty. When the count reaches zero, the FIFO is marked empty, and when it reaches the maximum depth, it is marked full. Because the clocks are asynchronous, the module uses separate always blocks for each clock domain to maintain proper timing separation and prevent metastability in the stored data.

FEATURES

This design includes dual-clock operation, 8-bit wide data storage, a 64-entry memory buffer, asynchronous reset functionality, and clear full/empty status flags. The implementation provides a simple and understandable model of asynchronous FIFO behavior, making it useful for academic learning, digital communication systems, and hardware design projects
