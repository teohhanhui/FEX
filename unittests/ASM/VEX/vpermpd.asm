%ifdef CONFIG
{
  "HostFeatures": ["AVX"],
  "RegData": {
    "XMM0":  ["0x3FF0000000000000", "0xEEEEEEEEEEEEEEEE", "0xFFFFFFFFFFFFFFFF", "0xAAAAAAAAAAAAAAAA"],
    "XMM1":  ["0x3FF0000000000000", "0x3FF0000000000000", "0x3FF0000000000000", "0x3FF0000000000000"],
    "XMM2":  ["0x3FF0000000000000", "0x3FF0000000000000", "0x3FF0000000000000", "0x3FF0000000000000"],
    "XMM3":  ["0xAAAAAAAAAAAAAAAA", "0xFFFFFFFFFFFFFFFF", "0xEEEEEEEEEEEEEEEE", "0x3FF0000000000000"],
    "XMM4":  ["0xAAAAAAAAAAAAAAAA", "0xFFFFFFFFFFFFFFFF", "0xEEEEEEEEEEEEEEEE", "0x3FF0000000000000"],
    "XMM5":  ["0xAAAAAAAAAAAAAAAA", "0xFFFFFFFFFFFFFFFF", "0xEEEEEEEEEEEEEEEE", "0x3FF0000000000000"],
    "XMM6":  ["0xEEEEEEEEEEEEEEEE", "0xEEEEEEEEEEEEEEEE", "0xEEEEEEEEEEEEEEEE", "0xEEEEEEEEEEEEEEEE"],
    "XMM7":  ["0xEEEEEEEEEEEEEEEE", "0xEEEEEEEEEEEEEEEE", "0xEEEEEEEEEEEEEEEE", "0xEEEEEEEEEEEEEEEE"],
    "XMM8":  ["0xFFFFFFFFFFFFFFFF", "0xFFFFFFFFFFFFFFFF", "0xFFFFFFFFFFFFFFFF", "0xFFFFFFFFFFFFFFFF"],
    "XMM9":  ["0xFFFFFFFFFFFFFFFF", "0xFFFFFFFFFFFFFFFF", "0xFFFFFFFFFFFFFFFF", "0xFFFFFFFFFFFFFFFF"],
    "XMM10": ["0xAAAAAAAAAAAAAAAA", "0xAAAAAAAAAAAAAAAA", "0xAAAAAAAAAAAAAAAA", "0xAAAAAAAAAAAAAAAA"],
    "XMM11": ["0xAAAAAAAAAAAAAAAA", "0xAAAAAAAAAAAAAAAA", "0xAAAAAAAAAAAAAAAA", "0xAAAAAAAAAAAAAAAA"]
  },
  "MemoryRegions": {
    "0x100000000": "4096"
  }
}
%endif

lea rdx, [rel .data]

vmovapd ymm0, [rdx]

; Permute first element across
vpermpd ymm1, ymm0, 0b00000000
vpermpd ymm2, [rdx], 0b00000000

; Invert vector
vpermpd ymm3, ymm0, 0b00011011
vpermpd ymm4, [rdx], 0b00011011

; Invert self
vmovapd ymm5, ymm0
vpermpd ymm5, ymm5, 0b00011011

; Permute second element
vpermq ymm6, ymm0, 0b01010101
vpermq ymm7, [rdx], 0b01010101

; Permute third element
vpermq ymm8, ymm0, 0b10101010
vpermq ymm9, [rdx], 0b10101010

; Permute fourth element
vpermq ymm10, ymm0, 0b11111111
vpermq ymm11, [rdx], 0b11111111

hlt

align 32
.data:
dq 0x3FF0000000000000
dq 0xEEEEEEEEEEEEEEEE
dq 0xFFFFFFFFFFFFFFFF
dq 0xAAAAAAAAAAAAAAAA
