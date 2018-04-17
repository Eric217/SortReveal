//
//  HuffmanTree.hpp
//  9.3
//
//  Created by Eric on 06/01/2018.
//  Copyright © 2018 Eric. All rights reserved.
//

//makeTree的用处

#ifndef HuffmanTree_hpp
#define HuffmanTree_hpp

#include "BinaryTree.mm"
#include "MinHeap.hpp"

template <typename T, typename Q>
class Huffman {
    template <typename M, typename N>
    friend BinaryTree<N> HuffmanTree(N *, M *, int);
    
    BinaryTree<Q> tree;
    T weight;

public:
    Huffman() {}
    Huffman(const T & weigh, const Q & data) {
        weight = weigh;
        tree = BinaryTree<Q>(data);
    }
    //拷贝构造
    Huffman(const Huffman<T, Q> & h) {
        weight = h.weight;
        tree = BinaryTree<Q>(h.tree);
    }
    void Delete() { tree.Delete(); }
    ///重载读Huffman的值的方法
    operator T() const { return weight; }
 
};

///参数 data为各个数据，按顺序对应的权重为 weights
//因此Q一般是char, T一般是int
template <typename T, typename Q>
BinaryTree<Q> HuffmanTree(Q * data, T * weights, int length)
{
    Huffman<T, Q> * initDataSet = new Huffman<T, Q>[length];
    for (int i = 0; i < length; i++)
        initDataSet[i] = Huffman<T, Q>(weights[i], data[i]);
    
    MinHeap<Huffman<T, Q>> heap(initDataSet, length, length);
 
    for (int i = 1; i < length; i++) {
        Huffman<T, Q> left, right, temp;
        heap.pop(left);
        heap.pop(right);
        temp.weight = left+right;
        if (LEFT_HIGH)
            temp.tree.makeTree(ZERO_SIGN, left.tree, right.tree);
        else
            temp.tree.makeTree(ZERO_SIGN, right.tree, left.tree);
        
        heap.push(temp);
        
    }
    Huffman<T, Q> result;
    heap.pop(result);
    heap.deactive();
    delete [] initDataSet;
    return result.tree;
}


#endif /* HuffmanTree_hpp */
