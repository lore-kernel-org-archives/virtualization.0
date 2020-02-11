From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 08/62] x86/boot/compressed/64: Add IDT Infrastructure
Date: Tue, 11 Feb 2020 14:18:52 -0800
Message-ID: <CALCETrWznWHQNfd80G95G_CB-yCw8Botqee8bsLz3OcC4-SS=w@mail.gmail.com>
References: <20200211135256.24617-1-joro@8bytes.org> <20200211135256.24617-9-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200211135256.24617-9-joro@8bytes.org>
Sender: kvm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Hellstrom <thellstrom@vmware.com>, Jiri Slaby <jslaby@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Juergen Gross <jgross@suse.com>, Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>, Joerg Roedel <jroedel@suse.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 11, 2020 at 5:53 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Add code needed to setup an IDT in the early pre-decompression
> boot-code. The IDT is loaded first in startup_64, which is after
> EfiExitBootServices() has been called, and later reloaded when the
> kernel image has been relocated to the end of the decompression area.
>
> This allows to setup different IDT handlers before and after the
> relocation.
>

> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> new file mode 100644
> index 000000000000..46ecea671b90
> --- /dev/null
> +++ b/arch/x86/boot/compressed/idt_64.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <asm/trap_defs.h>
> +#include <asm/segment.h>
> +#include "misc.h"
> +
> +static void set_idt_entry(int vector, void (*handler)(void))
> +{
> +       unsigned long address = (unsigned long)handler;
> +       gate_desc entry;
> +
> +       memset(&entry, 0, sizeof(entry));
> +
> +       entry.offset_low    = (u16)(address & 0xffff);
> +       entry.segment       = __KERNEL_CS;
> +       entry.bits.type     = GATE_TRAP;

^^^

I realize we're not running a real kernel here, but GATE_TRAP is
madness.  Please use GATE_INTERRUPT.

> +       entry.bits.p        = 1;
> +       entry.offset_middle = (u16)((address >> 16) & 0xffff);
> +       entry.offset_high   = (u32)(address >> 32);
> +
> +       memcpy(&boot_idt[vector], &entry, sizeof(entry));
> +}
> +
> +/* Have this here so we don't need to include <asm/desc.h> */
> +static void load_boot_idt(const struct desc_ptr *dtr)
> +{
> +       asm volatile("lidt %0"::"m" (*dtr));
> +}
> +
> +/* Setup IDT before kernel jumping to  .Lrelocated */
> +void load_stage1_idt(void)
> +{
> +       boot_idt_desc.address = (unsigned long)boot_idt;
> +
> +       load_boot_idt(&boot_idt_desc);
> +}
> +
> +/* Setup IDT after kernel jumping to  .Lrelocated */
> +void load_stage2_idt(void)
> +{
> +       boot_idt_desc.address = (unsigned long)boot_idt;
> +
> +       load_boot_idt(&boot_idt_desc);
> +}
> diff --git a/arch/x86/boot/compressed/idt_handlers_64.S b/arch/x86/boot/compressed/idt_handlers_64.S
> new file mode 100644
> index 000000000000..0b2b6cf747d2
> --- /dev/null
> +++ b/arch/x86/boot/compressed/idt_handlers_64.S
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Early IDT handler entry points
> + *
> + * Copyright (C) 2019 SUSE
> + *
> + * Author: Joerg Roedel <jroedel@suse.de>
> + */
> +
> +#include <asm/segment.h>
> +
> +.macro EXCEPTION_HANDLER name function error_code=0
> +SYM_FUNC_START(\name)
> +
> +       /* Build pt_regs */
> +       .if \error_code == 0
> +       pushq   $0
> +       .endif

cld

> +
> +       pushq   %rdi
> +       pushq   %rsi
> +       pushq   %rdx
> +       pushq   %rcx
> +       pushq   %rax
> +       pushq   %r8
> +       pushq   %r9
> +       pushq   %r10
> +       pushq   %r11
> +       pushq   %rbx
> +       pushq   %rbp
> +       pushq   %r12
> +       pushq   %r13
> +       pushq   %r14
> +       pushq   %r15
> +
> +       /* Call handler with pt_regs */
> +       movq    %rsp, %rdi
> +       call    \function
> +
> +       /* Restore regs */
> +       popq    %r15
> +       popq    %r14
> +       popq    %r13
> +       popq    %r12
> +       popq    %rbp
> +       popq    %rbx
> +       popq    %r11
> +       popq    %r10
> +       popq    %r9
> +       popq    %r8
> +       popq    %rax
> +       popq    %rcx
> +       popq    %rdx
> +       popq    %rsi
> +       popq    %rdi

if error_code?

> +
> +       /* Remove error code and return */
> +       addq    $8, %rsp
> +
> +       /*
> +        * Make sure we return to __KERNEL_CS - the CS selector on
> +        * the IRET frame might still be from an old BIOS GDT
> +        */
> +       movq    $__KERNEL_CS, 8(%rsp)
> +

If this actually happens, you have a major bug.  Please sanitize all
the segment registers after installing the GDT rather than hacking
around it here.
