#Create an in memory student management system using FastAPI with provisions for getting the details of a student, adding a student, deleting a student, updating details of a student.

from fastapi import FastAPI
from pydantic import BaseModel
from typing import Optional

app = FastAPI()

class Student(BaseModel):
    name: str
    age: int 
    grade: str

class StudentUpdate(BaseModel):
    name: Optional[str]
    age: Optional[int] 
    grade: Optional[str]

class StudentResponse(BaseModel):
    id: int
    name: str
    age: int 
    grade: str 

students = []

@app.get("/students")
def view_students():
    return students

@app.get("/students/student_id", response_model = StudentResponse)
def view_student(student_id: int):
    for s in students:
        if s["stud_id"] == student_id:
            return s
    return "Student not found"

@app.post("/students", response_model = StudentResponse)
def add_student(student: Student):
    new_student = {
        "stud_id" : len(students) + 1,
        "name": student.name,
        "age" : student.age,
        "grade": student.grade
    }
    students.append(new_student)
    return new_student

@app.put("/students/student_id",response_model = StudentResponse)
def update_student(student_id: int, student: Student):
    for s in students:
        if s["stud_id"] == student_id:
            s["name"] = student.name
            s["age"] = student.age
            s["grade"] = student.grade 
            return s 
    return "Student not found"

@app.delete("/students/student_id")
def delete_student(student_id: int):
    for s in students:
        if s["stud_id"] == student_id:
            students.remove(s)
            return "Deleted"
    return "Student not found"

@app.patch("/students/student_id")
def partial_update(student_id: int, student: StudentUpdate):
    for s in students:
        if s["stud_id"] == student_id:
            if student.name is not None:
                s["name"] = student.name
            if student.age is not None:
                s["age"] = student.age
            if student.grade is not None:
                s["grade"] = student.grade 
        return s
    return "Student not found"
