@echo on

if "%PKG_NAME%"=="libprotobuf-static" (
    set CF_SHARED=OFF
    mkdir build-static
    cd build-static
) else (
    set CF_SHARED=ON
    mkdir build-shared
    cd build-shared
)

:: Configure and install based on protobuf's instructions and other `bld.bat`s.
cmake -G "Ninja" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -Dprotobuf_ABSL_PROVIDER="package" ^
    -Dprotobuf_BUILD_SHARED_LIBS=%CF_SHARED% ^
    -Dprotobuf_JSONCPP_PROVIDER="package" ^
    -Dprotobuf_MSVC_STATIC_RUNTIME=OFF ^
    -Dprotobuf_WITH_ZLIB=ON ^
    ..
if %ERRORLEVEL% neq 0 exit 1

cmake --build . --target install --config Release
if %ERRORLEVEL% neq 0 exit 1
