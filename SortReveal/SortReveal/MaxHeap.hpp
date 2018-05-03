//
//  MaxHeap.hpp
//  9.2
//
//  Created by Eric on 28/12/2017.
//  Copyright © 2017 Eric. All rights reserved.
//

#ifndef MaxHeap_hpp
#define MaxHeap_hpp

#include "xcept.hpp"
template <typename T>
class MaxHeap {
    T * element;
    int maxSize;
    int currentSize;
public:
    
    MaxHeap(T * arr, int length, int maxSize = -1);
    ~MaxHeap() { delete [] element; }
   
    int size() const { return currentSize; }
    T max() const { return element[0]; }
    bool empty() const { return !currentSize; }
    bool isFull() const { return currentSize == maxSize; }
    void deactive() { element = 0; maxSize = currentSize = 0; }
 
    MaxHeap<T> & push(const T &);
    MaxHeap<T> & pop(T &);
    MaxHeap<T> & pop();
};

template <typename T>
MaxHeap<T>::MaxHeap(T * arr, int length, int mxs) {
    element = arr;
    maxSize = (mxs == -1 ? length : mxs);
    currentSize = length;
    
    for (int i = currentSize/2; i > 0; i--) {
      
        // 这里element[i]就是第i个。
        T y = element[i]; //选中当前节点作为根，保存住根值
        int c = 2*i; //c是y的可能的子节点
        while (c <= currentSize) { //确定c存在
            if (c < currentSize && element[c] < element[c+1])
                c++; //如果第c+1存在就先比较，不然就是第c个了
            if (y >= element[c]) //父(原根值)大于子，结束
                break;
            element[c/2] = element[c]; //否则swap
            c *= 2; //cd下一层
        }
        //循环跳出，给刚乘以2的c除以2 赋原根值
        element[c/2] = y;
    }
}

template <typename T>
MaxHeap<T> & MaxHeap<T>::push(const T & t) {
    if (currentSize == maxSize)
        throw NoMem();
    int i = ++currentSize; //t从新的叶节点开始 沿着树上升
    while (i != 1 && element[i/2-1] < t) {
        element[i-1] = element[i/2-1];
        i /= 2;
    }
    element[i-1] = t;
    return *this;
}

template <typename T>
MaxHeap<T> & MaxHeap<T>::pop(T & receiver) {
    if (!currentSize)
        throw OutOfBounds();
    receiver = element[0];
    T data = element[--currentSize];
    element[currentSize] = receiver;
    if (!currentSize)
        return *this;
    int i = 1; //下标
    while (i < currentSize) {
        if (i+1 < currentSize && element[i] < element[i+1]) //>
            i++;
       
        if (data >= element[i]) //<
            break;
        element[(i+1)/2-1] = element[i];
        i = i*2+1;
    }
    element[(1+i)/2-1] = data;
    return *this;
}

template <typename T>
MaxHeap<T> & MaxHeap<T>::pop() {
    if (!currentSize)
        throw OutOfBounds();
    T data = element[--currentSize];
    element[currentSize] = element[0];
    if (!currentSize)
        return *this;
    int i = 1; //下标
    while (i < currentSize) {
        if (i+1 < currentSize && element[i] < element[i+1]) //>
            i++;
        if (data >= element[i]) //<
            break;
        element[(i+1)/2-1] = element[i];
        i = i*2+1;
    }
    element[(1+i)/2-1] = data;
    return *this;
}

#endif /* MaxHeap_hpp */
