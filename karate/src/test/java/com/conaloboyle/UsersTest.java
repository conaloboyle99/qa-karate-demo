package com.conaloboyle;

import com.intuit.karate.junit5.Karate;
import com.intuit.karate.junit5.Karate.Test;

class UsersTest {

   @Test
   Karate testUsers() {
       return Karate.run("classpath:features/users.feature");
   }
}