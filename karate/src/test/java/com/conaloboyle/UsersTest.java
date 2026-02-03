package com.conaloboyle;

import com.intuit.karate.junit5.Karate;

class UsersTest {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("features/users").relativeTo(getClass());
    }
}