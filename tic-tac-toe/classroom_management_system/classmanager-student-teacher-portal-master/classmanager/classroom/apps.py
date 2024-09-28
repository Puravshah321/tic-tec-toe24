from django.apps import AppConfig
from flask import Flask, render_template, request, send_file
import qrcode
import sqlite3
import os
from datetime import datetime

app = Flask(__name__)

# Database connection
def get_db_connection():
    conn = sqlite3.connect('your_database_name.db')
    conn.row_factory = sqlite3.Row
    return conn

# Route for the teacher to generate a QR code
@app.route('/generate_qr', methods=['GET', 'POST'])
def generate_qr():
    if request.method == 'POST':
        class_id = request.form['class_id']
        date = datetime.now().strftime('%Y-%m-%d')
        attendance_link = f"http://localhost:5000/mark_attendance?class_id={class_id}&date={date}"

        # Generate QR code
        qr = qrcode.make(attendance_link)
        qr_code_path = f'static/qr_codes/qr_{class_id}_{date}.png'
        qr.save(qr_code_path)

        return render_template('teacher.html', qr_code_path=qr_code_path)

    return render_template('teacher.html')

# Route for students to mark attendance
@app.route('/mark_attendance', methods=['GET'])
def mark_attendance():
    class_id = request.args.get('class_id')
    date = request.args.get('date')
    student_id = request.args.get('student_id')  # Ideally, you'd authenticate the student here

    conn = get_db_connection()
    cursor = conn.cursor()

    # Mark attendance in the database
    cursor.execute("INSERT INTO classroom_attendance (student_id, class_id, date, status) VALUES (?, ?, ?, ?)",
                   (student_id, class_id, date, 'Present'))
    conn.commit()
    conn.close()

    return f"Attendance marked for student ID: {student_id} in class ID: {class_id} on {date}"

if __name__ == '__main__':
    app.run(debug=True)


class ClassroomConfig(AppConfig):
    name = 'classroom'
