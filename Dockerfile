# Use the official Android SDK image as the base image
FROM androidsdk/android-30:latest

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Copy the pubspec files and get dependencies
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy the rest of the application code
COPY . .

# Build the Flutter Android application
RUN flutter build apk --release

# Install and start the Android emulator
RUN sdkmanager "system-images;android-30;google_apis;x86_64"
RUN echo "no" | avdmanager create avd -n test -k "system-images;android-30;google_apis;x86_64"
RUN $ANDROID_HOME/emulator/emulator -avd test -no-skin -no-audio -no-window &

# Install the built APK on the emulator
RUN adb wait-for-device
RUN adb install build/app/outputs/flutter-apk/app-release.apk

# Expose necessary ports
EXPOSE 5554 5555

# Start the emulator and run the app
CMD adb shell am start -n com.example.yourapp/.MainActivity && tail -f /dev/null