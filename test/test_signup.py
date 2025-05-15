import unittest
import uuid
import app  

class SignupTestCase(unittest.TestCase):
    def setUp(self):
        # Configure the Flask app to use the test settings
        app.app.config.from_object('config_test')
        self.client = app.app.test_client()
        self.client.testing = True

        # Generate a unique email for the test user to avoid duplication
        self.test_email = f"testuser_{uuid.uuid4()}@example.com"

    def test_signup_valid_user(self):
        # Send a POST request to simulate the signup form submission
        response = self.client.post('/signup', data=dict(
            name='Test User',
            email=self.test_email,
            dob='2000-01-01',
            password='Test1234!',
            terms='on',
            privacy='on'
        ))
        
        # Output the generated email and server response for debugging    
        print("Generated email:", self.test_email)
        print("Response data:", response.data.decode())

        self.assertEqual(response.status_code, 200)
        # Ensure the response does not contain the "email already registered" message
        self.assertNotIn(b'This email is already registered', response.data)

        # Check that a verification message or indicator is included in the response
        self.assertIn(b'verification', response.data.lower())

    def tearDown(self):
        # Clean up the test data from the database after the test

        # Connect to the MySQL database
        conn = app.mysql.connector.connect(**app.db_config)
        cursor = conn.cursor()

        # Delete reading history associated with the test user (if it exists)
        cursor.execute("""
            DELETE FROM history 
            WHERE users_id_user = (SELECT id_user FROM users WHERE email = %s)
        """, (self.test_email,))
        conn.commit()

        # Delete the test user from the database
        cursor.execute("DELETE FROM users WHERE email = %s", (self.test_email,))
        conn.commit()

        # Close the database connection
        cursor.close()
        conn.close()

# Entry point to run the unit test
if __name__ == '__main__':
    unittest.main()
