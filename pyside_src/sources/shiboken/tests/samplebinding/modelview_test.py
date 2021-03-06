#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# This file is part of the Shiboken Python Bindings Generator project.
#
# Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
#
# Contact: PySide team <contact@pyside.org>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public License
# version 2.1 as published by the Free Software Foundation. Please
# review the following information to ensure the GNU Lesser General
# Public License version 2.1 requirements will be met:
# http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
# #
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
# 02110-1301 USA

'''Test case for objects that keep references to other object without owning them (e.g. model/view relationships).'''

import unittest
from sample import ObjectModel, ObjectType, ObjectView


object_name = 'test object'

class MyObject(ObjectType):
    pass

class ListModelKeepsReference(ObjectModel):
    def __init__(self, parent=None):
        ObjectModel.__init__(self, parent)
        self.obj = MyObject()
        self.obj.setObjectName(object_name)

    def data(self):
        return self.obj

class ListModelDoesntKeepsReference(ObjectModel):
    def data(self):
        obj = MyObject()
        obj.setObjectName(object_name)
        return obj


class ModelViewTest(unittest.TestCase):

    def testListModelDoesntKeepsReference(self):
        model = ListModelDoesntKeepsReference()
        view = ObjectView(model)
        obj = view.getRawModelData()
        self.assertEqual(type(obj), MyObject)
        self.assertEqual(obj.objectName(), object_name)

    def testListModelKeepsReference(self):
        model = ListModelKeepsReference()
        view = ObjectView(model)
        obj = view.getRawModelData()
        self.assertEqual(type(obj), MyObject)
        self.assertEqual(obj.objectName(), object_name)


if __name__ == '__main__':
    unittest.main()

