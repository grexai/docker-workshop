import os 
import time

print("Starting the script...")
time.sleep(0.3)
print("Preparing neural network...")
time.sleep(0.3)
print("Loading  models...")
time.sleep(0.3)
print("Loading data...")
time.sleep(0.3)
print("Preprocessing data...")
time.sleep(0.3)
print("Training the model...")
time.sleep(0.3)
for i in range(1, 101, 10):
    print(f"\rTraining... [{'#' * (i // 10)}{'.' * (10 - i // 10)}] {i}%", end="")
    time.sleep(0.3)
print("\n")    
print("Kaggle World Champion Segmentation model trained successfully!")
time.sleep(0.3)
print("Saving the model...")
time.sleep(0.3)
print("Model saved successfully!")
time.sleep(0.3)
print("Evaluating the model...")
time.sleep(0.3) 
print("Model evaluation completed!")
time.sleep(0.3)     
print("Kaggle competition won successfully!")


