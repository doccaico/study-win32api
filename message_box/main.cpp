#define NOMINMAX
#define WIN32_LEAN_AND_MEAN
#include <windows.h>


int main()
{
    MessageBox(
            NULL,
            (LPCWSTR)L"How old? Do you want to try again?",
            (LPCWSTR)L"Account Details",
            MB_ICONWARNING | MB_CANCELTRYCONTINUE | MB_DEFBUTTON2
            );

}
