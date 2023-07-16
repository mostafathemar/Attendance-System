from face_recognition import FaceRecognizer
import cv2
class Camera:
    def __init__(self):
        self.recognizer = FaceRecognizer()
        self.camera = None
        self.is_running = False

    def generate_frames(self):
        while self.is_running:
            success, frame = self.camera.read()
            if not success:
                break
            frame = self.recognizer.recognize_faces(frame)
            ret, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')

    def start(self):
        # Perform any necessary setup for starting attendance
        self.camera = cv2.VideoCapture(0) # start the camera when starting attendance
        self.is_running = True

    def stop(self):
        # Perform any necessary cleanup for stopping attendance
        self.is_running = False
        if self.camera is not None:
            self.camera.release()  # stop the camera when stopping attendance
            self.camera = None