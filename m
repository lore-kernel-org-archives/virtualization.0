From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH 5/5] x86-64: Add user_64bit_mode paravirt op
Date: Wed, 27 Jul 2011 13:45:17 -0400
Message-ID: <CAObL_7HZfVbPK0sf5GXHLxROhLy7XdMRhE+NRhc67KSYig00ow__34224.1020677195$1311788775$gmane$org@mail.gmail.com>
References: <cover.1311736366.git.luto@mit.edu>
	<4f4f2b2fdd92eff234f833125732b82a039203e2.1311736366.git.luto@mit.edu>
	<4E3049BA.7060907@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4E3049BA.7060907@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org, keir.xen@gmail.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jul 27, 2011 at 1:24 PM, Jeremy Fitzhardinge <jeremy@goop.org> wrot=
e:
> On 07/26/2011 08:20 PM, Andy Lutomirski wrote:
>> Three places in the kernel assume that the only long mode CPL 3
>> selector is __USER_CS. =A0This is not true on Xen -- Xen's sysretq
>> changes cs to the magic value 0xe033.
>>
>> Two of the places are corner cases, but as of "x86-64: Improve
>> vsyscall emulation CS and RIP handling"
>> (c9712944b2a12373cb6ff8059afcfb7e826a6c54), vsyscalls will segfault
>> if called with Xen's extra CS selector. =A0This causes a panic when
>> older init builds die.
>>
>> It seems impossible to make Xen use __USER_CS reliably without
>> taking a performance hit on every system call, so this fixes the
>> tests instead with a new paravirt op. =A0It's a little ugly because
>> ptrace.h can't include paravirt.h.
>>
>> Signed-off-by: Andy Lutomirski <luto@mit.edu>
>> Reported-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> ---
>> =A0arch/x86/include/asm/desc.h =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++--
>> =A0arch/x86/include/asm/paravirt_types.h | =A0 =A06 ++++++
>> =A0arch/x86/include/asm/ptrace.h =A0 =A0 =A0 =A0 | =A0 19 ++++++++++++++=
+++++
>> =A0arch/x86/kernel/paravirt.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++++
>> =A0arch/x86/kernel/step.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
>> =A0arch/x86/kernel/vsyscall_64.c =A0 =A0 =A0 =A0 | =A0 =A06 +-----
>> =A0arch/x86/mm/fault.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
>> =A0arch/x86/xen/enlighten.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A08 files changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
>> index 7b439d9..41935fa 100644
>> --- a/arch/x86/include/asm/desc.h
>> +++ b/arch/x86/include/asm/desc.h
>> @@ -27,8 +27,8 @@ static inline void fill_ldt(struct desc_struct *desc, =
const struct user_desc *in
>>
>> =A0 =A0 =A0 desc->base2 =A0 =A0 =A0 =A0 =A0 =A0 =3D (info->base_addr & 0=
xff000000) >> 24;
>> =A0 =A0 =A0 /*
>> - =A0 =A0 =A0* Don't allow setting of the lm bit. It is useless anyway
>> - =A0 =A0 =A0* because 64bit system calls require __USER_CS:
>> + =A0 =A0 =A0* Don't allow setting of the lm bit. It would confuse
>> + =A0 =A0 =A0* user_64bit_mode and would get overridden by sysret anyway.
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 desc->l =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0;
>> =A0}
>> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/as=
m/paravirt_types.h
>> index 2c76521..8e8b9a4 100644
>> --- a/arch/x86/include/asm/paravirt_types.h
>> +++ b/arch/x86/include/asm/paravirt_types.h
>> @@ -41,6 +41,7 @@
>>
>> =A0#include <asm/desc_defs.h>
>> =A0#include <asm/kmap_types.h>
>> +#include <asm/pgtable_types.h>
>>
>> =A0struct page;
>> =A0struct thread_struct;
>> @@ -63,6 +64,11 @@ struct paravirt_callee_save {
>> =A0struct pv_info {
>> =A0 =A0 =A0 unsigned int kernel_rpl;
>> =A0 =A0 =A0 int shared_kernel_pmd;
>> +
>> +#ifdef CONFIG_X86_64
>> + =A0 =A0 u16 extra_user_64bit_cs; =A0/* __USER_CS if none */
>> +#endif
>> +
>> =A0 =A0 =A0 int paravirt_enabled;
>> =A0 =A0 =A0 const char *name;
>> =A0};
>> diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace=
.h
>> index 94e7618..3566454 100644
>> --- a/arch/x86/include/asm/ptrace.h
>> +++ b/arch/x86/include/asm/ptrace.h
>> @@ -131,6 +131,9 @@ struct pt_regs {
>> =A0#ifdef __KERNEL__
>>
>> =A0#include <linux/init.h>
>> +#ifdef CONFIG_PARAVIRT
>> +#include <asm/paravirt_types.h>
>> +#endif
>>
>> =A0struct cpuinfo_x86;
>> =A0struct task_struct;
>> @@ -187,6 +190,22 @@ static inline int v8086_mode(struct pt_regs *regs)
>> =A0#endif
>> =A0}
>>
>> +#ifdef CONFIG_X86_64
>> +static inline bool user_64bit_mode(struct pt_regs *regs)
>> +{
>> +#ifndef CONFIG_PARAVIRT
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* On non-paravirt systems, this is the only long mode CPL 3
>> + =A0 =A0 =A0* selector. =A0We do not allow long mode selectors in the L=
DT.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 return regs->cs =3D=3D __USER_CS;
>> +#else
>> + =A0 =A0 /* Headers are too twisted for this to go in paravirt.h. */
>> + =A0 =A0 return regs->cs =3D=3D __USER_CS || regs->cs =3D=3D pv_info.ex=
tra_user_64bit_cs;
>
> Is this necessary because usermode may sometimes be on __USER_CS or
> sometimes on Xen's? =A0Could we just commit to one or the other and make
> it a simple comparison?

Currently (from memory), brand new threads start out on __USER_CS.
Also, there might be software out there that thunks back and forth
between 32-bit and 64-bit mode and hardcodes CS=3D51 as the 32->64 bit
jump target.

It is said that 32-64 bit thunking is impossible, but this is
empirically untrue -- I've done it in the intcc32 vsyscall test I
wrote, and if you remove the actual intcc instruction, it will survive
the thunk in both directions.  My code didn't hardcode the assumption.

>
> What if __USER_CS were a variable?

That sounds a little evil :)  It will also make the FIXUP_TOP_OF_STACK
macro a little uglier than it is.

But maybe it's not so bad.  We could even remove the legacy 64-bit
selector, and presumably everything would still work.

What do you think?  I'll benchmark removing VCGF_in_syscall later tonight.

--Andy

>
> =A0 =A0J
>> +#endif
>> +}
>> +#endif
>> +
>> =A0/*
>> =A0 * X86_32 CPUs don't save ss and esp if the CPU is already in kernel =
mode
>> =A0 * when it traps. =A0The previous stack will be directly underneath t=
he saved
>> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
>> index 613a793..d90272e 100644
>> --- a/arch/x86/kernel/paravirt.c
>> +++ b/arch/x86/kernel/paravirt.c
>> @@ -307,6 +307,10 @@ struct pv_info pv_info =3D {
>> =A0 =A0 =A0 .paravirt_enabled =3D 0,
>> =A0 =A0 =A0 .kernel_rpl =3D 0,
>> =A0 =A0 =A0 .shared_kernel_pmd =3D 1, /* Only used when CONFIG_X86_PAE i=
s set */
>> +
>> +#ifdef CONFIG_X86_64
>> + =A0 =A0 .extra_user_64bit_cs =3D __USER_CS,
>> +#endif
>> =A0};
>>
>> =A0struct pv_init_ops pv_init_ops =3D {
>> diff --git a/arch/x86/kernel/step.c b/arch/x86/kernel/step.c
>> index 7977f0c..c346d11 100644
>> --- a/arch/x86/kernel/step.c
>> +++ b/arch/x86/kernel/step.c
>> @@ -74,7 +74,7 @@ static int is_setting_trap_flag(struct task_struct *ch=
ild, struct pt_regs *regs)
>>
>> =A0#ifdef CONFIG_X86_64
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x40 ... 0x4f:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (regs->cs !=3D __USER_CS)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!user_64bit_mode(regs))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 32-bit mo=
de: register increment */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 64-bit mode: REX prefix */
>> diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64=
.c
>> index dda7dff..1725930 100644
>> --- a/arch/x86/kernel/vsyscall_64.c
>> +++ b/arch/x86/kernel/vsyscall_64.c
>> @@ -127,11 +127,7 @@ void dotraplinkage do_emulate_vsyscall(struct pt_re=
gs *regs, long error_code)
>>
>> =A0 =A0 =A0 local_irq_enable();
>>
>> - =A0 =A0 /*
>> - =A0 =A0 =A0* Real 64-bit user mode code has cs =3D=3D __USER_CS. =A0An=
ything else
>> - =A0 =A0 =A0* is bogus.
>> - =A0 =A0 =A0*/
>> - =A0 =A0 if (regs->cs !=3D __USER_CS) {
>> + =A0 =A0 if (!user_64bit_mode(regs)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we trapped from kernel mode, we migh=
t as well OOPS now
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* instead of returning to some random add=
ress and OOPSing
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index 4d09df0..decd51a 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -105,7 +105,7 @@ check_prefetch_opcode(struct pt_regs *regs, unsigned=
 char *instr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* but for now it's good enough to assume =
that long
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* mode only uses well known segments or k=
ernel.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 return (!user_mode(regs)) || (regs->cs =3D=3D =
__USER_CS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return (!user_mode(regs) || user_64bit_mode(re=
gs));
>> =A0#endif
>> =A0 =A0 =A0 case 0x60:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 0x64 thru 0x67 are valid prefixes in all =
modes. */
>> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
>> index 974a528..a9c710a 100644
>> --- a/arch/x86/xen/enlighten.c
>> +++ b/arch/x86/xen/enlighten.c
>> @@ -950,6 +950,7 @@ static unsigned xen_patch(u8 type, u16 clobbers, voi=
d *insnbuf,
>> =A0static const struct pv_info xen_info __initconst =3D {
>> =A0 =A0 =A0 .paravirt_enabled =3D 1,
>> =A0 =A0 =A0 .shared_kernel_pmd =3D 0,
>> + =A0 =A0 .extra_user_64bit_cs =3D FLAT_USER_CS64,
>>
>> =A0 =A0 =A0 .name =3D "Xen",
>> =A0};
>
>
