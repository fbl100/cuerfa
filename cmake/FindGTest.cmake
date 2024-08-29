# cmake/FindGTest.cmake


# This module helps locate the GoogleTest framework in the project.
# It simplifies the process of fetching and configuring GoogleTest
# so that it can be easily reused in multiple parts of the project.

# Ensure that FetchContent is available
include(FetchContent)

# Download and configure GoogleTest using FetchContent
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG        v1.15.2
)

# Make the GoogleTest package available
FetchContent_MakeAvailable(googletest)

# Expose GTest and GTest Main libraries as targets
# so they can be linked to executables
set(GTEST_LIBS gtest gtest_main)
