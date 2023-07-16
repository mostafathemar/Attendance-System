import os
import pandas as pd
from keras.preprocessing.image import ImageDataGenerator
from keras import layers
from keras import Model
from keras.applications.mobilenet_v2 import MobileNetV2, preprocess_input
from keras.optimizers import Adam
from keras.callbacks import EarlyStopping
# Define the input shape of the model
IMAGE_SIZE = 128

# Define the number of classes
NUM_CLASSES = 5

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

# Load the MobileNetV2 model with pre-trained weights
base_model = MobileNetV2(
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
x = layers.Dropout(0.3)(x)
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
early_stop = EarlyStopping(monitor='val_loss',mode='min',patience=5,restore_best_weights=True)

# Train the model
history = model.fit(
    train_generator,
    epochs=NUM_EPOCHS,
    validation_data=val_generator,
    callbacks = [early_stop]
)

# Save the trained model
model.save('mobilenet.h5', save_format='tf')

# Save the label names to a file
names = sorted(os.listdir(os.path.join(data_dir, 'train')))
labels = [i for i in range(len(names))]
df = pd.DataFrame({'label': labels, 'name': names})
df.to_pickle('labels_mobilnet.pkl')


"""class ModelBuilder:
    def __init__(self, image_size, num_classes):
        self.image_size = image_size
        self.num_classes = num_classes
        self.model = self.build_model()

    def build_model(self):
        base_model = MobileNetV2(
            input_shape=(self.image_size, self.image_size, 3),
            include_top=False,
            weights='imagenet'
        )
        for layer in base_model.layers:
            layer.trainable = False
        x = base_model.output
        x = layers.GlobalAveragePooling2D()(x)
        x = layers.Dense(1024, activation='relu')(x)
        x = layers.Dropout(0.3)(x)
        predictions = layers.Dense(self.num_classes, activation='softmax')(x)
        model = Model(inputs=base_model.input, outputs=predictions)
        model.compile(
            optimizer=Adam(learning_rate=0.001),
            loss='categorical_crossentropy',
            metrics=['accuracy']
        )
        return model"""