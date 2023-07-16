import os

basedir = os.path.abspath(os.path.dirname(__file__))

DB_CONFIG = {
    'user': 'root',
    'password': 'MyNewPass',
    'host': 'localhost',
    'port': '3306',
    'database': 'attendance'
}

SQLALCHEMY_DATABASE_URI = f"mysql+pymysql://{DB_CONFIG['user']}:{DB_CONFIG['password']}@{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}"

SQLALCHEMY_TRACK_MODIFICATIONS = False  # Turn off update messages from SQLAlchemy

# Model and cascade classifier paths
MODEL_PATH = os.path.join(basedir, 'face_recognition_model.h5')
FRONT_FACE_CASCADE_PATH = os.path.join(basedir, 'haarcascade_frontalface_default.xml')
LABEL_TO_CATEGORICAL_PATH = os.path.join(basedir, 'labels_mobilnet.pkl')

# Image size for face recognition model
IMAGE_SIZE = 128

# Mark threshold seconds for attendance
MARK_THRESHOLD_SECONDS = 60
