# Error.py

class CustomError(Exception):
    """Clase base para otras excepciones"""
    pass

class ValidationError(CustomError):
    """Error para validaciones fallidas"""
    def __init__(self, message="La validación falló"):
        super().__init__(message)

class DatabaseError(CustomError):
    """Error relacionado con la base de datos"""
    def __init__(self, message="Error en la base de datos"):
        super().__init__(message)
