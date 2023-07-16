import os
import cv2

path = 'New folder/'
names = os.listdir(path)
print (names)
def create_folder():
    try:
        os.mkdir(path) # create new data folder if not exists
    except:
        print('Data File Aleady Exists')

def takephoto():
    student_name = input('Please Enter Your Full Name : ')
    capture = cv2.VideoCapture(0) # Videofile as string or 0 for front camera or  1 for second camera
    i = 0
    try:
        os.mkdir(path + student_name + '@gmail.com')
    except:
        print(student_name + ' Is Already Exists Please Choose Anther Name')

    while True:
            success , frame = capture.read() # success : boolean , frame : image
            if not success:
                break
            #resize_frame = cv2.resize(frame , (100,100), fx = 0.25, fy = 0.25)
            cv2.imshow('Camera mode on', frame)
            if cv2.waitKey(1) & 0xFF == ord('t'):  # if we press 't' it'll save new photo
                i += 1
                cv2.imwrite(path + student_name + '@gmail.com/' + student_name+str(i)+'.jpeg',frame)
                print( 'N.O. Photos taken:', i)
            if cv2.waitKey(1) & 0xFF == ord('q'):
                break
    capture.release() #close the camera
    cv2.destroyAllWindows()
    return student_name

create_folder()
takephoto()