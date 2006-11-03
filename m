From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for	paravirtualizing
 critical operations
Date: Fri, 03 Nov 2006 12:35:03 -0800
Message-ID: <454BA7F7.8030205@vmware.com>
References: <20061029024504.760769000@sous-sol.org>	<20061030231132.GA98768@muc.de>	<1162376827.23462.5.camel@localhost.localdomain> <200611030356.54074.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932090AbWKCUfG@vger.kernel.org>
In-Reply-To: <200611030356.54074.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> On Wednesday 01 November 2006 11:27, Rusty Russell wrote:
>  =20
>> Create a paravirt.h header for all the critical operations which nee=
d
>> to be replaced with hypervisor calls, and include that instead of
>> defining native operations, when CONFIG_PARAVIRT.
>>    =20
>
> Hmm, did this all ever compile in mainline? I had to do a few merges
> and in the end i get
>
> /home/lsrc/quilt/linux/kernel/spinlock.c: In function =E2=80=98_spin_=
lock_irqsave=E2=80=99:
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number miss=
ing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number miss=
ing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number miss=
ing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number miss=
ing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number miss=
ing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number miss=
ing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number miss=
ing after %
> -letter
> include2/asm/spinlock.h:59: error: invalid 'asm': operand number miss=
ing after %
> -letter
> {standard input}: Assembler messages:
> {standard input}:593: Error: undefined symbol `paravirt_ops' in opera=
tion
> {standard input}:593: Error: undefined symbol `PARAVIRT_irq_enable' i=
n operation
> {standard input}:605: Error: undefined symbol `paravirt_ops' in opera=
tion
> {standard input}:605: Error: undefined symbol `PARAVIRT_irq_disable' =
in operatio
> n
>  =20

Not seeing that here (on 2.6.19-rc2-mm2 with gcc 4.0.2).

> and lots of new warnings like
>
> /home/lsrc/quilt/linux/arch/i386/kernel/traps.c: In function =E2=80=98=
set_intr_gate=E2=80=99:
> /home/lsrc/quilt/linux/arch/i386/kernel/traps.c:1165: warning: implic=
it declarat
> ion of function =E2=80=98_set_gate=E2=80=99
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/common.c: In function =E2=
=80=98_cpu_init=E2=80=99:
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/common.c:754: warning: im=
plicit decl
> aration of function =E2=80=98__set_tss_desc'
>  =20

Sounds like desc.h got reordered.  Somewhere, there was a broken patch=20
once that did this, I thought we fixed that.

> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c: In function =
=E2=80=98intel_mach
> ine_check=E2=80=99:
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.eax=E2=80=99=20
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.ebx=E2=80=99=20
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.ecx=E2=80=99=20
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.edx=E2=80=99=20
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.esi=E2=80=99=20
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.edi=E2=80=99=20
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.ebp=E2=80=99=20
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.esp=E2=80=99=20
> may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.eflag
> s=E2=80=99 may be used uninitialized in this function
> /home/lsrc/quilt/linux/arch/i386/kernel/cpu/mcheck/p4.c:158: warning:=
 =E2=80=98dbg.eip=E2=80=99=20
> may be used uninitialized in this function
>  =20

Those appear to be valid warnings, with or without paravirt, due to the=
=20
tacky glued inline oddity of intel_get_extended_msrs.

Zach
