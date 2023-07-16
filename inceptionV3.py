import os
import pandas as pd
from keras.preprocessing.image import ImageDataGenerator
from keras import layers
from keras import Model
from keras.applications.inception_v3 import InceptionV3
from keras.optimizers import Adam
from keras.callbacks import EarlyStopping
from keras.layers import BatchNormalization

class InceptionModel:
    def __init__(self, data_dir, image_size=128, num_classes=5, batch_size=32, num_epochs=20):
        self.data_dir = data_dir
        self.image_size = image_size
        self.num_classes = num_classes
        self.batch_size = batch_size
        self.num_epochs = num_epochs

        self.train_datagen = ImageDataGenerator(
            rotation_range=20,
            width_shift_range=0.2,
            height_shift_range=0.2,
            shear_range=0.2,
            zoom_range=0.2,
            horizontal_flip=True,
            fill_mode='nearest'
        )

        self.val_datagen = ImageDataGenerator()

        self.model = self.build_model()

    def build_model(self):
        base_model = InceptionV3(
            input_shape=(self.image_size, self.image_size, 3),
            include_top=False,
            weights='imagenet'
        )

        for layer in base_model.layers:
            layer.trainable = False

        x = base_model.output
        x = layers.GlobalAveragePooling2D()(x)
        x = layers.Dense(1024, activation='relu')(x)
        x = BatchNormalization()(x)
        x = layers.Dropout(0.5)(x)
        x = layers.Dense(512, activation='relu')(x)
        x = BatchNormalization()(x)
        x = layers.Dropout(0.5)(x)
        predictions = layers.Dense(self.num_classes, activation='softmax')(x)

        model = Model(inputs=base_model.input, outputs=predictions)

        model.compile(
            optimizer=Adam(learning_rate=0.001),
            loss='categorical_crossentropy',
            metrics=['accuracy']
        )

        return model

    def train_model(self):
        train_generator = self.train_datagen.flow_from_directory(
            os.path.join(self.data_dir, 'train'),
            target_size=(self.image_size, self.image_size),
            batch_size=self.batch_size,
            class_mode='categorical'
        )

        val_generator = self.val_datagen.flow_from_directory(
            os.path.join(self.data_dir, 'val'),
            target_size=(self.image_size, self.image_size),
            batch_size=self.batch_size,
            class_mode='categorical'
        )

        early_stop = EarlyStopping(monitor='val_loss',mode='min',patience=5,restore_best_weights=True)

        self.model.fit(
            train_generator,
            epochs=self.num_epochs,
            validation_data=val_generator,
            callbacks=[early_stop]
        )

    def save_model(self, model_name, label_name):
        self.model.save(f'{model_name}.h5', save_format='tf')

        names = sorted(os.listdir(os.path.join(self.data_dir, 'train')))
        labels = [i for i in range(len(names))]
        df = pd.DataFrame({'label': labels, 'name': names})
        df.to_pickle(f'labels_{label_name}.pkl')

model = InceptionModel(data_dir='New folder/')
model.train_model()
model.save_model(model_name='inceptionV3', label_name='inceptionV3')