//
//  LinkedStack.hpp
//  4.1
//
//  Created by Eric on 17/11/2017.
//  Copyright © 2017 Eric. All rights reserved.
//

#ifndef LinkedStack_hpp
#define LinkedStack_hpp

#include <iostream>
using namespace std;

//template <typename T> class LinkedQueue;
template <typename T> class LinkedStack;

template <typename T>
class Node {
//    friend class LinkedQueue<T>;
    friend class LinkedStack<T>;
    
    T data;
    Node<T> * link;
};

template <typename T>
class LinkedStack {
    Node<T> * top;
public:
    LinkedStack(): top(0) {}
    ~LinkedStack();
    
    bool empty() const { return !top; }
    
    int size() const;
    T Top() const;
    
    LinkedStack<T> & push(const T & t);
    LinkedStack<T> & pop(T & receiver);
    LinkedStack<T> & pop();
    ///返回被pop掉的数据。
    T pop_r();
    
};
template <typename T>
int LinkedStack<T>::size() const {
    int c = 0;
    Node<T> * n = top;
    while (n) {
        c++;
        n = n->link;
    }
    return c;
}
template <typename T>
LinkedStack<T>::~LinkedStack<T>() {
    Node<T> * n;
    while (top) {
        n = top->link;
        delete top;
        top = n;
    }
}

///必须保证有top。
template <typename T>
T LinkedStack<T>::Top() const {
 
    return top->data;
}

template <typename T>
LinkedStack<T> & LinkedStack<T>::push(const T & t) {
    Node<T> * n = new Node<T>;
    n->data = t;
    n->link = top;
    top = n;
    return *this;
}

template <typename T>
LinkedStack<T> & LinkedStack<T>::pop(T & r) {
    if (!top)
        return 0;
    Node<T> * n = top->link;
    r = top->data;
    delete top;
    top = n;
    return *this;
}

template <typename T>
T LinkedStack<T>::pop_r() {
 
    Node<T> * n = top->link;
    T r = top->data;
    delete top;
    top = n;
    return r;
}

template <typename T>
LinkedStack<T> & LinkedStack<T>::pop() {
   
    Node<T> * n = top->link;
    delete top;
    top = n;
    return *this;
}

#endif /* LinkedStack_hpp */
