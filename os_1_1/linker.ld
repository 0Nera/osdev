
/* С метки _start мы будем грузиться */
ENTRY (_start)

SECTIONS
{
        . = 0x00100000;
    /* Ядро будет находиться в 3GB + 1MB в виртуальном адресном пространстве, */
    /* который будет отображен на 1 МБ в физическом адресном пространстве. */
    /* Обратите внимание, что мы выравниваем разделы по страницам. */

    _kernel_start = .;
        .multiboot.data : {
            *(.multiboot.data)
        }

       .multiboot.text : {
           *(.multiboot.text)
       }

    . += 0xC0000000;
    /* Добавляем символ, указывающий начальный адрес ядра. */
    .text ALIGN (4K) : AT (ADDR (.text) - 0xC0000000)
    {
        *(.text)
    }
    .rodata ALIGN (4K) : AT (ADDR (.rodata) - 0xC0000000)
    {
        *(.rodata)
    }
    .data ALIGN (4K) : AT (ADDR (.data) - 0xC0000000)
    {
        *(.data)
    }
    .bss ALIGN (4K) : AT (ADDR (.bss) - 0xC0000000)
    {
        *(COMMON)
        *(.bss)
        *(.bootstrap_stack)
    }
    /* Добавляем символ, указывающий конечный адрес ядра. */
    _kernel_end = .;
}