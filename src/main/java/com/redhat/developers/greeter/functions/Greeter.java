package com.redhat.developers.greeter.functions;

import java.util.function.Function;

/**
 * Greeter
 */
public class Greeter implements Function<String, String> {

  public String apply(String name) {
    return String.format("Hello %s", name);
  }
}
