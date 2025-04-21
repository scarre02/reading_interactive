import unittest
import uuid
import app  

class SignupTestCase(unittest.TestCase):
    def setUp(self):
        app.app.config.from_object('config_test')
        self.client = app.app.test_client()
        self.client.testing = True

        # generate unique email
        self.test_email = f"testuser_{uuid.uuid4()}@example.com"

    def test_signup_valid_user(self):
        response = self.client.post('/signup', data=dict(
            name='Test User',
            email=self.test_email,
            dob='2000-01-01',
            password='Test1234!',
            terms='on',
            privacy='on'
        ))

        print("Generated email:", self.test_email)
        print("Response data:", response.data.decode())

        self.assertEqual(response.status_code, 200)
        self.assertNotIn(b'This email is already registered', response.data)
        self.assertIn(b'verification', response.data.lower())

    def tearDown(self):
        conn = app.mysql.connector.connect(**app.db_config)
        cursor = conn.cursor()

        # delete history if it exists
        cursor.execute("""
            DELETE FROM history 
            WHERE users_id_user = (SELECT id_user FROM users WHERE email = %s)
        """, (self.test_email,))
        conn.commit()

        # delete user
        cursor.execute("DELETE FROM users WHERE email = %s", (self.test_email,))
        conn.commit()

        cursor.close()
        conn.close()

if __name__ == '__main__':
    unittest.main()
