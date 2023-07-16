import cv2
import numpy as np
import pickle
from datetime import datetime, timedelta
from keras.models import load_model
from database import Database
import mysql.connector

class FaceRecognizer:
    def __init__(self):
        self.label_to_categorical = None
        self.model = None
        self.front_face_cascade = None
        self.IMAGE_SIZE = 100
        self.MARK_THRESHOLD_SECONDS = 60
        self.db = Database()
        self.load_label_to_categorical()
        self.load_model()
        self.load_front_face_cascade()

    def load_label_to_categorical(self):
        with open('labels_mobilnet.pkl', 'rb') as label:
            self.label_to_categorical = pickle.load(label)
        self.label_to_categorical.columns = ['label','name']

    def load_model(self):
        self.model = load_model('vgg19.h5')

    def load_front_face_cascade(self):
        self.front_face_cascade = cv2.CascadeClassifier('haarcascade_frontalface_default.xml')

    def recognize_faces(self, frame):
        if frame is None:
            return frame

        # Convert the frame to grayscale
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

        # Detect faces in the grayscale frame
        faces = self.front_face_cascade.detectMultiScale(gray, scaleFactor=1.3, minNeighbors=5)

        # If faces are detected
        if len(faces) > 0:

            for (x, y, w, h) in faces:
                # Crop the face region from the frame
                face_img = frame[y: y + h, x: x + w]

                # Resize the face region to the model input size
                resized_face = cv2.resize(face_img, (self.IMAGE_SIZE, self.IMAGE_SIZE))

                # Preprocess the resized image for the model
                preprocessed_face = cv2.cvtColor(resized_face, cv2.COLOR_BGR2RGB)
                img_array = np.array(preprocessed_face)
                scaled = img_array / 255.0
                img_array = np.expand_dims(scaled, axis=0)

                # Pass the preprocessed image through the model for prediction
                scores = self.model.predict(img_array)
                target = np.argmax(scores)
                name = 'Unknown Person'
                average_confidence = np.mean(scores[0])
                threshold = average_confidence + 0.722

                # If confidence is greater than threshold
                if scores[0][target] > threshold:
                    email = self.label_to_categorical.loc[target, 'name']

                    try:
                        # Check if the person is already registered within the last 30 minutes
                        current_time = datetime.now().time()
                        previous_time = (datetime.now() - timedelta(minutes=30)).time()
                        cursor = self.db.conn.cursor()
                        query = "SELECT COUNT(*) FROM attendance WHERE email = %s AND time >= %s AND time <= %s"
                        cursor.execute(query, (email, previous_time, current_time))
                        count = cursor.fetchone()[0]
                        cursor.close()

                        if count == 0:
                            # Insert the attendance data into the table
                            current_date = datetime.now().date()
                            #mark = 1  # Assuming 1 means attendance marked
                            self.db.insert_attendance_data(email, current_date, current_time)

                    except mysql.connector.Error as error:
                        print(f"Error occurred: {error}")

                # Draw a rectangle around the detected face and put the recognized name on it
                cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
                #cv2.putText(frame, name, (x, y - 10), cv2.FONT_HERSHEY_SIMPLEX, 0.9, (0, 255, 0), 2)

        return frame
