# Attendance System: Face Recognition-based Automatic Attendance Marking

Table of Contents:

- Introduction
- Background
- System Overview
- Getting Started
   -Prerequisites
   -Installation
- Technical Details
- Implementation
- How to Run
- License
- Contact
- Acknowledgments

  
# Introduction

Welcome to the repository of the Face Recognition Based Attendance System,
This project is a face recognition-based attendance system. It allows users to mark their attendance automatically by recognizing their faces, eliminating the need for manual intervention. The system leverages machine learning models to perform the recognition tasks, capturing images from the video feed and recognizing faces.

# Background

Our aim is to automate the attendance marking system by using face recognition. The system captures images from the video feed, recognizes faces, and then marks the attendance of the recognized individuals in a MySQL database.

# System Overview

The system consists of a machine learning backend for face recognition, a web interface built with PHP and Laravel for administrators, and a Flutter app for students and doctors to view attendance. The recognized attendance data is stored in a MySQL database, which is then accessed via the web interface and mobile application.

# Getting Started

Prerequisites

Python 3.7 or above
TensorFlow 2.0 or above
Keras 2.4.3 or above
OpenCV 4.5.3 or above
NumPy
Pandas
MySQL Connector for Python
PHP 7.3 or above
Laravel 8.0 or above
Flutter 2.0 or above

# Installation

Clone the repo: git clone https://github.com/mostafathemar/Attendance-System.
Install Python packages: pip install tensorflow keras opencv-python numpy pandas mysql-connector-python:

  - Set up your PHP, Laravel, and Flutter environments according to their respective official guides.
  - Set up your MySQL database and update the configuration in the application.
   
# Technical Details

In this project, transfer learning, a machine learning method where a pre-trained model is reused for a different but related problem, is leveraged. The following architectures have been utilized:

- VGG19: Pre-trained on the ImageNet dataset, VGG19 was used as a base model, with a custom classification layer added on top for the specific task of face recognition.
- MobileNetV2: Similar to VGG19, MobileNetV2 pre-trained on the ImageNet dataset was used with a custom SoftMax activation function to fine-tune it for face recognition.
- FaceNet: The FaceNet model, specifically designed for face recognition, was used to extract meaningful features from face images.
- ResNet: Residual Neural Network, also pre-trained on ImageNet, was fine-tuned for face recognition by adding custom classification layers.
- An open-source face recognition library was also leveraged to facilitate face recognition.

# Implementation

The project is implemented in Python, using the TensorFlow and Keras libraries for the machine learning components, OpenCV for video processing, PHP and Laravel for the web interface, Flutter for the mobile application, and MySQL Connector for Python to interact with the MySQL database.

# How to Run

- Run the machine learning backend: python Final.py
- Run the Laravel server: php artisan serve
- Open the Laravel website on a browser with the URL displayed in the console.
- Run the Flutter app: flutter run

# Contact

For any queries, please feel free to reach out to us at mostafathemar@email.com.

# Acknowledgments

- Open Source Face Recognition Library
- ImageNet Dataset
- VGG19
- MobileNetV2
- FaceNet
- ResNet
- PHP
- Laravel
- Flutter
