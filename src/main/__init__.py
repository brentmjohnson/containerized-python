from .main import main
import sys

__all__ = ['main']

class CallableModule:
    def __init__(self, wrapped):
        self._wrapped = wrapped

    def __call__(self, *args, **kwargs):
        return main(*args, **kwargs) # type: ignore

    def __getattr__(self, attr):
        return object.__getattribute__(self._wrapped, attr)

sys.modules[__name__] = CallableModule(sys.modules[__name__]) # type: ignore