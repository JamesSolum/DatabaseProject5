import csv # for writing to a csv file
from faker import Faker # for pretty data
import random # for some random choices
import string # to eliminate punctuation

# Written by James Solum

fake = Faker()

# Constants
big = 20000
big_small = 5000
small = 500

# Sizes for each dataset
student_size = big
job_size = big_small
hobby_size = small
subject_size = small
class_size = small
employed_by_size = big_small
#dream_size = big
participates_size = big
studies_size = big
takes_size = small
#teaches_size = small

punct_trans = str.maketrans('','',string.punctuation)

################## Jobs #####################
my_id = 0
def generate_job(my_id): # generate job dictionary
    job = {'id' : ' ', 'role' : ' ', 'salary' : ' ', 'industry' : ' '}
    job['role'] = fake.job().replace(' ', '').translate(punct_trans)
    job['salary'] = fake.random_int(min=100, max=1000000)
    job['industry'] = fake.company().replace(' ', '').translate(punct_trans)
    job['id'] = my_id 
    return job

# turn the job into a string so we can put it into a set
def stringify_job(job):
    return job['role'] + ' ' + str(job['salary']) + ' ' + job['industry'] + ' ' + str(job['id'])

# undo the stringify and turn it into a dict
def de_stringify_and_dict_job(j):
    job_dict = {'id': ' ', 'role': ' ', 'salary' : ' ', 'industry' : ' '} 
    x = j.split(' ')
    job_dict['role'] = x[0]
    job_dict['salary'] = x[1]
    job_dict['industry'] = x[2]
    job_dict['id'] = x[3]
    return job_dict

jobs = set()
while(len(jobs) < job_size):
    my_id += 1
    jobs.add(stringify_job(generate_job(my_id)))

with open('jobs.csv', 'w') as f:
    fieldnames = ['id', 'role', 'salary', 'industry']
    writer = csv.DictWriter(f, fieldnames)
    for job in jobs:
        j = de_stringify_and_dict_job(job)
        writer.writerow(j)

################## Students #####################
def generate_student(fullname): # Generate a student dictionary
    student = {'firstname' : ' ', 'lastname': ' ', 'sex' : ' ', 'email': ' ', 'gpa' : ' ', 'dreamJob' : ' '}
    splitFullName = fullname.split(' ')
    student['firstname'] = splitFullName[0]
    student['lastname'] = splitFullName[1]
    student['sex'] = fake.random_element(elements=('M', 'F'))
    student['email'] = fullname.replace(' ', '') + "@westmont.edu"
    student['gpa'] = fake.numerify(text="#.##")
    j = de_stringify_and_dict_job(random.sample(jobs, 1)[0])
    student['dreamJob'] = j['id']
    return student
 
# Generate many unique Student names
studentNames = set() # used to ensure we have uniqueness.  Every set you see in this file will be for the same purpose
email = set() # key

# Generate unique first and last names
while(len(studentNames) < student_size):
    first = fake.first_name()
    last = fake.last_name()
    studentNames.add(first + " " + last)

# write these names to the files
with open('students.csv', 'w') as f:
    fieldnames = ['firstname', 'lastname', 'sex', 'email', 'gpa', 'dreamJob']
    writer = csv.DictWriter(f, fieldnames)
    for name in studentNames:
        s = generate_student(name)
        writer.writerow(s) 
        email.add(s['email'])
    

# note: everything below will be the same as you have already seen above.  Therefore, there will be less comments to reduce redundancy
################## HOBBIES #####################
def generate_hobby():
    return fake.lexify(text="??????????", letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

hobbies = set()
while(len(hobbies) < hobby_size):
    hobbies.add(generate_hobby())

with open('hobby.csv', 'w') as f:
    fieldnames = ['hobbyName']
    writer = csv.DictWriter(f, fieldnames)
    for hobby in hobbies:
        h = {"hobbyName" : hobby}
        writer.writerow(h)

################## SUBJECT #####################
def generate_subject():
    return fake.lexify(text="????????????????", letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

subjects = set()
while(len(subjects) < subject_size):
    subjects.add(generate_subject())

with open('subject.csv', 'w') as f:
    fieldnames = ['subjectName']
    writer = csv.DictWriter(f, fieldnames)
    for subject in subjects:
        s = {'subjectName': subject}
        writer.writerow(s)

################## CLASS #####################
def generate_class(class_name):
    edu_class = {'className' : ' ', 'units' : ' ', 'subject' : ' '}
    edu_class['className'] = class_name
    edu_class['units'] = fake.random_int(min=1, max=10)
    edu_class['subject'] = random.sample(subjects, 1)[0]
    return edu_class

#Generate class names
class_names = set()
while(len(class_names) < class_size):
    class_names.add(generate_subject()) # equally random

with open('class.csv', 'w') as f:
        fieldnames = ['className', 'units', 'subject']
        writer = csv.DictWriter(f, fieldnames)
        for cname in class_names:
            c = generate_class(cname)
            writer.writerow(c)

#####################################################
################## RELATIONSHIPS#####################
# the relations below will use the data from the above
# relations

def stringify_part(e, h):
    return e + " " + h

################## EMPLOYED BY #####################

employ_set = set()
with open('employedBy.csv', 'w') as f:
        fieldnames = ['email', 'id']
        writer = csv.DictWriter(f, fieldnames)
        tmp_dic = {'email': ' ', 'id' : ' '}
        for _ in range(0, employed_by_size):
            e = random.sample(email, 1)[0] #b/c many-many
            tmp_dic['email'] = e
            j = de_stringify_and_dict_job(random.sample(jobs, 1)[0])
            j = j['id']
            p = stringify_part(e, j)
            while(p in employ_set):
                e = random.sample(email, 1)[0]
                tmp_dic['email'] = e
                j = de_stringify_and_dict_job(random.sample(jobs, 1)[0])
                j = j['id']
                p = stringify_part(e, j)
            employ_set.add(p)
            tmp_dic['id'] = j
            writer.writerow(tmp_dic)

################## PARTICIPATES #####################
par_set = set()
with open('participates.csv', 'w') as f:
        fieldnames = ['email', 'hobbyName']
        writer = csv.DictWriter(f, fieldnames)
        for _ in range(0, participates_size): # many-many
            tmp_dic = {'email': ''}
            tmp_dic['email'] = random.sample(email,1)[0]
            j = {'hobbyName': random.sample(hobbies, 1)[0]}
            p = stringify_part(tmp_dic['email'], j['hobbyName'])
            while(p in par_set):
                tmp_dic['email'] = random.sample(email,1)[0]
                j = {'hobbyName': random.sample(hobbies, 1)[0]}
                p = stringify_part(tmp_dic['email'], j['hobbyName'])
            par_set.add(p) 
            final = {**tmp_dic, **j}
            writer.writerow(final)

################## STUDIES #####################
stud_set = set()
with open('studies.csv', 'w') as f:
        fieldnames = ['email', 'subjectName']
        writer = csv.DictWriter(f, fieldnames)
        for _ in range(0, studies_size):
            s = random.sample(email, 1)[0]
            sub = random.sample(subjects,1)[0]
            p = stringify_part(s, sub)
            while(p in stud_set):
                s = random.sample(email, 1)[0]
                sub = random.sample(subjects,1)[0]
                p = stringify_part(s, sub)
            stud_set.add(p)
            final = {'email': s, 'subjectName': sub}
            writer.writerow(final)

################## TAKES #####################

take_set = set()
with open('takes.csv', 'w') as f:
        fieldnames = ['email', 'className']
        writer = csv.DictWriter(f, fieldnames)
        for _ in range(0, takes_size):
            s = random.sample(email,1)[0]
            c = random.sample(class_names,1)[0]
            p = stringify_part(s, c)
            while(p in take_set):
                s = random.sample(email, 1)[0]
                sub = random.sample(subjects,1)[0]
                p = stringify_part(s, sub)
            take_set.add(p)
            final = {'email': s, 'className': c}
            writer.writerow(final)
