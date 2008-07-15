From: Zachary Amsden <zach@vmware.com>
Subject: Patch from LKML
Date: Tue, 15 Jul 2008 11:38:50 -0700
Message-ID: <1216147130.6620.184.camel@bodhitayantram.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: suresh.b.siddha@intel.com, yhlu.kernel@gmail.com, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: virtualization@lists.linuxfoundation.org


> On Tue, Jul 15, 2008 at 10:33 AM, Suresh Siddha
> <suresh.b.siddha@intel.com> wrote:
> > On Sun, Jul 13, 2008 at 10:19:35PM -0700, Yinghai Lu wrote:
> >>
> >> fix for pv.
> >>
> >> Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
> >>
> >> ---
> >>  arch/x86/kernel/paravirt.c |    5 ----
> >>  arch/x86/kernel/vmi_32.c   |   51 ++++++++++++++++++++++++++++++++++++++++++---
> >>  arch/x86/xen/enlighten.c   |   19 +++++++---------
> >>  include/asm-x86/paravirt.h |   29 -------------------------
> >>  4 files changed, 57 insertions(+), 47 deletions(-)
> >>
> >> Index: linux-2.6/arch/x86/kernel/paravirt.c
> >> ===================================================================
> >> --- linux-2.6.orig/arch/x86/kernel/paravirt.c
> >> +++ linux-2.6/arch/x86/kernel/paravirt.c
> >> @@ -373,11 +373,6 @@ struct pv_cpu_ops pv_cpu_ops = {
> >>
> >>  struct pv_apic_ops pv_apic_ops = {
> >>  #ifdef CONFIG_X86_LOCAL_APIC
> >> -#ifndef CONFIG_X86_64
> >> -       .apic_write = native_apic_mem_write,
> >> -       .apic_write_atomic = native_apic_mem_write_atomic,
> >> -       .apic_read = native_apic_mem_read,
> >> -#endif
> >>         .setup_boot_clock = setup_boot_APIC_clock,
> >>         .setup_secondary_clock = setup_secondary_APIC_clock,
> >>         .startup_ipi_hook = paravirt_nop,
> >> Index: linux-2.6/arch/x86/kernel/vmi_32.c
> >> ===================================================================
> >> --- linux-2.6.orig/arch/x86/kernel/vmi_32.c
> >> +++ linux-2.6/arch/x86/kernel/vmi_32.c
> >> @@ -676,6 +676,50 @@ static inline int __init probe_vmi_rom(v
> >>         return 0;
> >>  }
> >>
> >> +#ifdef CONFIG_X86_LOCAL_APIC
> >> +static u32 vmi_apic_read(u32 reg)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >> +static void vmi_apic_write(u32 reg, u32 val)
> >> +{
> >> +       /* Warn to see if there's any stray references */
> >> +       WARN_ON(1);
> >> +}
> >> +
> >> +static u64 vmi_apic_icr_read(void)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >> +static void vmi_apic_icr_write(u32 low, u32 id)
> >> +{
> >> +       /* Warn to see if there's any stray references */
> >> +       WARN_ON(1);
> >> +}
> >> +
> >> +static void vmi_apic_wait_icr_idle(void)
> >> +{
> >> +       return;
> >> +}
> >> +
> >> +static u32 vmi_safe_apic_wait_icr_idle(void)
> >> +{
> >> +       return 0;
> >> +}
> >> +
> >> +static struct apic_ops vmi_basic_apic_ops = {
> >> +        .read = vmi_apic_read,
> >> +        .write = vmi_apic_write,
> >> +        .write_atomic = vmi_apic_write,
> >> +        .icr_read = vmi_apic_icr_read,
> >> +        .icr_write = vmi_apic_icr_write,
> >> +        .wait_icr_idle = vmi_apic_wait_icr_idle,
> >> +        .safe_wait_icr_idle = vmi_safe_apic_wait_icr_idle,
> >> +};
> >> +#endif
> >> +
> >>  /*
> >>   * VMI setup common to all processors
> >>   */
> >> @@ -904,9 +948,10 @@ static inline int __init activate_vmi(vo
> >>  #endif
> >>
> >>  #ifdef CONFIG_X86_LOCAL_APIC
> >> -       para_fill(pv_apic_ops.apic_read, APICRead);
> >> -       para_fill(pv_apic_ops.apic_write, APICWrite);
> >> -       para_fill(pv_apic_ops.apic_write_atomic, APICWrite);
> >> +       para_fill(vmi_basic_apic_ops.read, APICRead);
> >> +       para_fill(vmi_basic_apic_ops.write, APICWrite);
> >> +       para_fill(vmi_basic_apic_ops.write_atomic, APICWrite);
> >> +       apic_ops = &vmi_basic_apic_ops;
> >
> > Yinghai, Looking more closely at this, based on my understanding this might be
> > wrong for VMI. Correct patch should be as follows. Any comments?
> 
> so you mean icr related will still use default native member?
> 
> YH

Nacked-by: Zachary Amsden <zach@vmware.com>

What are you doing here and why aren't you cc-ing the maintainers?

Thanks,

Zach
