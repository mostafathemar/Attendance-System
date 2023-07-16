from flask import Flask, Response, jsonify, render_template
from database import Database
from camera import Camera

app = Flask(__name__)

db = Database()
camera = Camera()

attendance_running = False  # Variable to keep track of attendance status


@app.route('/')
def index():
    return render_template('home.html')

@app.route('/start_attendance')
def start_attendance():
    global attendance_running  # Use the global attendance_running variable
    if not attendance_running:  # Check if attendance is not currently running
        camera.start()
        attendance_running = True  # Update the global variable to True
        return Response(camera.generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')
    else:
        return Response(camera.generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/stop_attendance')
def stop_attendance():
    global attendance_running  # Use the global attendance_running variable
    if attendance_running:  # Check if attendance is currently running
        camera.stop()
        attendance_running = False  # Update the global variable to False
        return jsonify(message='Attendance stopped')
    else:
        return jsonify(message='Attendance is not currently running')

@app.route('/send_data', methods=['GET'])
def website_data():
    attendance_data = db.get_attendance_data()

    processed_data = [{'email': data['email'],
                       'date': str(data['date']),
                       'time': str(data['time'])
                       } for data in attendance_data]

    for record in processed_data:
        db.send_to_web_api(record['email'], record['date'], record['time'])

    return jsonify(message='Data sent successfully to web API')


if __name__ == '__main__':
    app.run(debug=True)
