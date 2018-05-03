//
//  Heap.hpp
//  9.3
//
//  Created by Eric on 06/01/2018.
//  Copyright © 2018 Eric. All rights reserved.
//

#ifndef Heap_hpp
#define Heap_hpp
#include <iostream>
using namespace std;

class OutOfBounds {};
class NoMemory {};


template <typename T>
class Heap {
    T * element;
    int maxSize;
    int currentSize;
 
public:
    
    Heap() {};
    Heap(T * arr, int length, int maxSize = -1);
    ~Heap() { delete [] element; }
    
    int size() const { return currentSize; }
    T top() const { return element[0]; }
    bool empty() const { return !currentSize; }
    bool full() const { return currentSize == maxSize; }
    void deactive() { element = 0; maxSize = currentSize = 0; }
 
    Heap<T> & push(const T &);
    Heap<T> & pop(T &);
    Heap<T> & pop();
};

template <typename T>
Heap<T>::Heap(T * arr, int length, int mxs) {
    element = arr;
    maxSize = (mxs == -1 ? length : mxs);
    currentSize = length;
    
    for (int i = currentSize/2; i > 0; i--) {
        T t = arr[i-1];
        int c_idx = 2*i-1;
        while (c_idx+1 <= currentSize) {
            if (c_idx+1 < currentSize && arr[c_idx] > arr[c_idx+1]) //一个符号 <
                c_idx++;
            if (t < arr[c_idx]) // >=
                break;
            arr[i-1] = arr[c_idx];
            c_idx = c_idx*2+1;
        }
        int a = (c_idx+1)/2-1;
        
        arr[a] = t;
    }
}

template <typename T>
Heap<T> & Heap<T>::push(const T & t) {
    if (currentSize == maxSize)
        throw NoMemory();
    int i = ++currentSize; //t从新的叶节点开始 沿着树上升
    while (i != 1 && element[i/2-1] > t) { // ，<
        element[i-1] = element[i/2-1];
        i /= 2;
    }
    element[i-1] = t;
    return *this;
}

template <typename T>
Heap<T> & Heap<T>::pop(T & receiver) {
    if (!currentSize)
        throw OutOfBounds();
    receiver = element[0];
    T data = element[--currentSize];
    element[currentSize] = receiver;
    if (!currentSize)
        return *this;
    int i = 1; //下标
    while (i < currentSize) {
        if (i+1 < currentSize && element[i] > element[i+1])//， <
            i++;
        if (data < element[i])//>=
            break;
        element[(i+1)/2-1] = element[i];
        i = i*2+1;
    }
    element[(1+i)/2-1] = data;
    return *this;
}

template <typename T>
Heap<T> & Heap<T>::pop() {
    if (!currentSize)
        throw OutOfBounds();
    T data = element[--currentSize];
    element[currentSize] = element[0];
    if (!currentSize)
        return *this;
    int i = 1; //下标
    while (i < currentSize) {
        if (i+1 < currentSize && element[i] > element[i+1])//， <
            i++;
        if (data < element[i])//>=
            break;
        element[(i+1)/2-1] = element[i];
        i = i*2+1;
    }
    element[(1+i)/2-1] = data;
    return *this;
}

#endif /* Heap_hpp */
