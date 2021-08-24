FROM openjdk:18-jdk-buster

ENV ANDROID_COMPILE_SDK "30"
ENV ANDROID_BUILD_TOOLS "30.0.2"
ENV ANDROID_SDK_TOOLS "7583922"

RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 cmake python3 build-essential libtool automake ninja-build curl

# Install Android SDK
RUN wget --quiet --output-document=android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
RUN unzip -d $ANDROID_HOME android-sdk.zip
RUN rm android-sdk.zip

# Accept android SDK lisences.
RUN echo y | ${ANDROID_HOME}/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" "build-tools;${ANDROID_BUILD_TOOLS}"
RUN echo y | $SDK_PATH/android-sdk-linux/tools/bin/sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" >/dev/null
RUN echo y | $SDK_PATH/android-sdk-linux/tools/bin/sdkmanager "platform-tools" >/dev/null
RUN echo y | $SDK_PATH/android-sdk-linux/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}" >/dev/null

# Download NDK
RUN wget --continue --quiet -N --output-document=android-ndk.zip https://dl.google.com/android/repository/android-ndk-r21b-linux-x86_64.zip
RUN unzip -d $ANDROID_NDK_ROOT android-ndk.zip
RUN rm android-ndk.zip