//
//  Node.hpp
//  9.3
//
//  Created by Eric on 10/02/2018.
//  Copyright © 2018 Eric. All rights reserved.
//

#ifndef Node_hpp
#define Node_hpp

#include "xcept.hpp"

template <typename T> class LinkedQueue;
template <typename T> class LinkedStack;

template <typename T>
class Node {
    friend class LinkedQueue<T>;
    friend class LinkedStack<T>;
    
    T data;
    Node<T> * link;
};
#endif /* Node_hpp */
