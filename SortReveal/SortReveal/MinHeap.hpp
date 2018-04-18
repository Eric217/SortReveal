//
//  MinHeap.hpp
//  9.3
//
//  Created by Eric on 06/01/2018.
//  Copyright © 2018 Eric. All rights reserved.
//

#ifndef MinHeap_hpp
#define MinHeap_hpp
#include "xcept.hpp"

template <typename T, typename Q> class Huffman;



///返回的index
template <typename T>
inline int maxChild(T * arr, int leftChld, int length) {
    if (leftChld + 1 == length || arr[leftChld] > arr[leftChld+1])
        return leftChld;
    return leftChld + 1;
}


template <typename T>
class MinHeap {
    T * element;
    int maxSize;
    int currentSize;
    
public:
    
    MinHeap(T * arr, int length, int maxSize = -1);
    ~MinHeap() { delete [] element; }
    
    int size() const { return currentSize; }
    T min() const { return element[0]; }
    bool empty() const { return !currentSize; }
    bool full() const { return currentSize == maxSize; }
    void deactive() { element = 0; maxSize = currentSize = 0; }
 
    MinHeap<T> & push(const T &);
    MinHeap<T> & pop(T &);
    MinHeap<T> & pop();
};

template <typename T>
MinHeap<T>::MinHeap(T * arr, int length, int mxs) {
    element = arr;
    maxSize = (mxs == -1 ? length : mxs);
    currentSize = length;
    
    for (int i = currentSize/2; i > 0; i--) {
        T t = arr[i-1];
        int c_idx = 2*i-1;
        while (c_idx+1 <= currentSize) {
            if (c_idx+1 < currentSize && arr[c_idx] > arr[c_idx+1])
                c_idx++;
            if (t < arr[c_idx])
                break;
            arr[i-1] = arr[c_idx];
            c_idx = c_idx*2+1;
        }
        int a = (c_idx+1)/2-1;
        
        arr[a] = t;
    }
}

template <typename T>
MinHeap<T> & MinHeap<T>::push(const T & t) {
    if (currentSize == maxSize)
        throw NoMemory();
    int i = ++currentSize; //t从新的叶节点开始 沿着树上升
    while (i != 1 && element[i/2-1] > t) {
        element[i-1] = element[i/2-1];
        i /= 2;
    }
    element[i-1] = t;
    return *this;
}

template <typename T>
MinHeap<T> & MinHeap<T>::pop(T & receiver) {
    if (!currentSize)
        throw OutOfBounds();
    receiver = element[0];
    T data = element[--currentSize];
    element[currentSize] = receiver;
    if (!currentSize)
        return *this;
    int i = 1; //下标
    while (i < currentSize) {
        if (i+1 < currentSize && element[i] > element[i+1])
            i++;
        if (data < element[i])
            break;
        element[(i+1)/2-1] = element[i];
        i = i*2+1;
    }
    element[(1+i)/2-1] = data;
    return *this;
}

template <typename T>
MinHeap<T> & MinHeap<T>::pop() {
    if (!currentSize)
        throw OutOfBounds();
    T data = element[--currentSize];
    element[currentSize] = element[0];
    if (!currentSize)
        return *this;
    int i = 1; //下标
    while (i < currentSize) {
        if (i+1 < currentSize && element[i] > element[i+1])
            i++;
        if (data < element[i])
            break;
        element[(i+1)/2-1] = element[i];
        i = i*2+1;
    }
    element[(1+i)/2-1] = data;
    return *this;
}

#endif /* MinHeap_hpp */
