Before starting the app...

1. Run the script file.

2. open com.airlines.service. Under sendEmail method enter the sender's email address and password.

3. Admins cannot sign-up later. Add admins if required (refer table admin).

NOTE: username implies the Email address.

After running the app...

Booking flight by searching for it at the home page:

1. Enter the flight details to book flight. Currently database will contain only three data (refer table bookings). 
If not found, respective message will be displayed.

2. If the flight is available on booking the flight, the user be directed to the login page of user. 
By logining in with the correct address and password(refer table user) the user will be directed to the personal details page.
In case, if the user doesn't have a account signning up by entering the mail is more than enough to get directed to the next page which is personal details. 
Intimation regarding the signup will be sent to the entered mail address if account doesn't exists previously. 
If account exists the user will get notified about it through pop-up.

3. After entering the personal details in the required format the details of the booking will be displayed. 
Options for booking another flight and logout will be provided at the bottom of the page.

Logining in as admin:

1. The option for logining in as admin will be provided at the home page. 

2. The admin credentials are checked based on the database. 
Admin can make use of forgot password for which the login details will be sent through email.

3. Once logged in, the admin will be given options for changing the password where the password gets changed if its a match and
 adding flight details to the database.

4. Admins can view all the flight details and edit or cancel it.

Logining in as user:

1. The option for logining in as admin will be provided at the home page. 

2. The user credentials are checked based on the database. 
User can make use of forgot password for which the login details will be sent through email.
User can also opt sign up option to create a new account.

3. User has given option to book ticket, view bookings and change password.

4. View bookings has options for editing and canceling the booking.

5. In case of query, the user can make use of contact tab and convey the query. On submitting, a custom message will be sent through mail.

NOTE: Chrome's default back buttons are disabled and the "get" methods will be redirected to home page if the url is entered directly for security purposes.