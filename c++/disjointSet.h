#pragma once
#include <vector>
using std::vector;
struct DisjointSet {
    vector<int> parent;
    DisjointSet(int maxSize) {
        parent.resize(maxSize);
        for (int i = 0; i < maxSize; i++) {
            parent[i] = i;
        }
    }

    int find_set(int v) {
        if (v == parent[v])
            return v;
        return parent[v] = find_set(parent[v]); // with path compression.
    }

    void union_set(int a, int b) {
        a = find_set(a);
        b = find_set(b);
        if (a != b) { // their parents are different.
            if (a > b) // let label always be the small one.
                std::swap(a, b);
            parent[b] = a;
        }
    }
};