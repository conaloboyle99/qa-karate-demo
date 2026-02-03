package com.conaloboyle;

import com.intuit.karate.junit5.Karate;

class UsersTest {

    @Karate.Test
    Karate testUsers() {
        // Use absolute classpath to the feature
        return Karate.run("classpath:features/users.feature");
    }
}