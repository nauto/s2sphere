from __future__ import print_function, unicode_literals, division

import unittest

import s2  # SWIG wrapped original C++ implementation
import s2sphere


class TestCellId(unittest.TestCase):

    def test_cellid(self):
        lat, lng = (33, -122)
        py_cellid = s2sphere.CellId.from_lat_lng(
            s2sphere.LatLng.from_degrees(lat, lng)
        )
        cpp_cellid = s2.S2CellId.FromLatLng(
            s2.S2LatLng.FromDegrees(lat, lng)
        )
        self.assertEqual(py_cellid.id(), cpp_cellid.id())

    def cellid_parent_comparison(self, level=12):
        lat, lng = (33, -122)
        py_cellid = (s2sphere.CellId
                     .from_lat_lng(s2sphere.LatLng.from_degrees(lat, lng))
                     .parent(level))
        cpp_cellid = (s2.S2CellId
                      .FromLatLng(s2.S2LatLng.FromDegrees(lat, lng))
                      .parent(level))
        self.assertEqual(py_cellid.id(), cpp_cellid.id())

    def test_cellid_parents(self):
        for level in range(1, 31):
            self.cellid_parent_comparison(level)


if __name__ == '__main__':
    unittest.main()
