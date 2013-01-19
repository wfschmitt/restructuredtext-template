.. sectnum::

.. role:: test(literal)

.. header:: ok

セクション1
================

子セクション1
---------------

.. raw:: pdf

    PageBreak

セクション2
===================

子セクション2
---------------

.. figure:: Images/example.png
    :alt: example
    :scale: 30%

    キャプション

.. raw:: pdf

    PageBreak

セクション2
===================

子セクション2
---------------

.. code::

    | test*dd*
    ``



.. container:: terminalblock

    :test:`# ok
            dfdfd
            `

.. parsed-literal::
    :class: rststyle-terminalblock

    test*ggg*
    fddfd

.. include:: tmp.py
    :literal:

