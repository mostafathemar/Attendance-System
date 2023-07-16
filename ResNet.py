import os
import pandas as pd
import matplotlib.pyplot as plt
from keras.preprocessing.image import ImageDataGenerator
from keras import Model, layers
from keras.layers import BatchNormalization
from keras.applications.resnet50 import ResNet50, preprocess_input
from keras.optimizers import Adam
from keras.callbacks import EarlyStopping

# Define the input shape of the model
IMAGE_SIZE = 224  # ResNet50 requires image size to be 224x224

# Define the number of classes
NUM_CLASSES = 6

# Define the batch size for training and validation
BATCH_SIZE = 32

# Define the number of epochs to train the model
NUM_EPOCHS = 20

# Define the path to the data directory
data_dir = 'New folder/'

# Define the augmentation settings for the training data
train_datagen = ImageDataGenerator(
    preprocessing_function=preprocess_input,
    rotation_range=20,
    width_shift_range=0.2,
    height_shift_range=0.2,
    shear_range=0.2,
    zoom_range=0.2,
    horizontal_flip=True,
    fill_mode='nearest'
)

# Define the augmentation settings for the validation data
val_datagen = ImageDataGenerator(
    preprocessing_function=preprocess_input
)

# Load the ResNet50 model with pre-trained weights
base_model = ResNet50(
    input_shape=(IMAGE_SIZE, IMAGE_SIZE, 3),
    include_top=False,
    weights='imagenet'
)

# Freeze all layers in the base model
for layer in base_model.layers:
    layer.trainable = False

# Add a custom classifier on top of the base model
x = base_model.output
x = layers.GlobalAveragePooling2D()(x)
x = layers.Dense(1024, activation='relu')(x)
x = BatchNormalization()(x)
x = layers.Dropout(0.5)(x)
x = layers.Dense(512, activation='relu')(x)
x = BatchNormalization()(x)
x = layers.Dropout(0.5)(x)
predictions = layers.Dense(NUM_CLASSES, activation='softmax')(x)

# Define the final model
model = Model(inputs=base_model.input, outputs=predictions)

# Compile the model
model.compile(
    optimizer=Adam(learning_rate=0.001),
    loss='categorical_crossentropy',
    metrics=['accuracy']
)

# Define the training and validation data generators
train_generator = train_datagen.flow_from_directory(
    os.path.join(data_dir, 'train'),
    target_size=(IMAGE_SIZE, IMAGE_SIZE),
    batch_size=BATCH_SIZE,
    class_mode='categorical'
)

val_generator = val_datagen.flow_from_directory(
    os.path.join(data_dir, 'val'),
    target_size=(IMAGE_SIZE, IMAGE_SIZE),
    batch_size=BATCH_SIZE,
    class_mode='categorical'
)

early_stop = EarlyStopping(monitor='val_loss', mode='min', patience=5, restore_best_weights=True)

# Train the model
history = model.fit(
    train_generator,
    epochs=NUM_EPOCHS,
    validation_data=val_generator,
    callbacks=[early_stop]
)

# Save the trained model
model.save('resnet.h5', save_format='tf')

# Save the label names to a file
names = sorted(os.listdir(os.path.join(data_dir, 'train')))
labels = [i for i in range(len(names))]
df = pd.DataFrame({'label': labels, 'name': names})
df.to_pickle('labels.pkl')

def plot_metrics(history):
    plt.figure(figsize=(10, 5))
    plt.subplot(1, 2, 1)
    plt.plot(history.history['loss'], label='Training Loss')
    plt.plot(history.history['val_loss'], label='Validation Loss')
    plt.legend()
    plt.title('Loss')

    plt.subplot(1, 2, 2)
    plt.plot(history.history['accuracy'], label='Training Accuracy')
    plt.plot(history.history['val_accuracy'], label='Validation Accuracy')
    plt.legend()
    plt.title('Accuracy')
    plt.show()

plot_metrics(history)