from setuptools import setup, find_packages
from setuptools.extension import Extension
from Cython.Build import cythonize

extensions = [
    Extension(
        "MIcalc",
        ["python/MIcalc.pyx"],
        #libraries=['numpy']
    ),
]

setup(
    name = "MIcalc",
    packages = find_packages(),
    version="0.0.1",
    author="Pavel Prochazka",
    author_email="pavel.prochazka@firma.seznam.cz",
    description="Empirical MI calculation of two samples",
    ext_modules = cythonize(extensions)
)
