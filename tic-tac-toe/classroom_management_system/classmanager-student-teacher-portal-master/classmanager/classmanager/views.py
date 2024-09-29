from django.views.generic import TemplateView
from django.shortcuts import render,get_object_or_404,redirect
from django.views import generic
from django.views.generic import  (View,TemplateView,
                                  ListView,DetailView,
                                  CreateView,UpdateView,
                                  DeleteView)
from django.utils.decorators import method_decorator
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
# Create your views here.
from classroom.forms import UserForm,TeacherProfileForm,StudentProfileForm,MarksForm,MessageForm,NoticeForm,AssignmentForm,SubmitForm,TeacherProfileUpdateForm,StudentProfileUpdateForm
from django.urls import reverse
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout,update_session_auth_hash
from django.http import HttpResponseRedirect,HttpResponse
from classroom import models
from classroom.models import StudentsInClass,StudentMarks,ClassAssignment,SubmitAssignment,Student,Teacher
from django.contrib.auth.forms import PasswordChangeForm
from django.db.models import Q

from django.http import HttpResponse, JsonResponse
from django.utils import timezone
from classroom.models import QRCodeAttendance, Attendance, Student, Teacher

import qrcode
from django.conf import settings
import os
from io import BytesIO
from django.core.files.base import ContentFile
from django.views.generic import View
from django.contrib.auth.decorators import login_required

from django.shortcuts import render


class HomePage(TemplateView):
    template_name = "classroom/index.html"
# View for teachers to see attendance of students
@login_required
def view_attendance(request):
    teacher = request.user.Teacher
    students_in_class = Student.objects.filter(user_student_name__teacher=teacher)
    
    attendance_data = []
    for student in students_in_class:
        student_attendance = Attendance.objects.filter(student=student)
        attendance_data.append({
            "student": student,
            "attendance": student_attendance,
        })
    
    return render(request, 'classroom/view_attendance.html', {'attendance_data': attendance_data})

def scan_qr_code(request):
    # Your logic here
    return render(request, 'scan_qr_code.html')



# Function to generate QR code for teachers
@login_required
def qr_code_generated(request):
    teacher = request.user.Teacher
    
    # Generate QR code containing attendance link or unique code
    qr_data = f"teacher_{teacher.id}_attendance_{timezone.now().strftime('%Y-%m-%d')}"
    qr_image = qrcode.make(qr_data)
    
    # Save QR code image in memory
    buffer = BytesIO()
    qr_image.save(buffer, format="PNG")
    
    # Create QRCodeAttendance instance and save image to it
    qr_attendance = QRCodeAttendance(teacher=teacher)
    filename = f"qr_{teacher.id}_{timezone.now().strftime('%Y%m%d%H%M%S')}.png"
    qr_attendance.qr_code_image.save(filename, ContentFile(buffer.getvalue()))
    qr_attendance.save()

    return render(request, 'classroom/qr_code_generated.html', {'qr_attendance': qr_attendance})


