From: Satya <satyakiran@gmail.com>
Subject: Re: [PATCH 10/10] xen: use boot protocol to boot xen kernel
Date: Fri, 15 Jun 2007 11:12:29 -0500
Message-ID: <acbcf3840706150912k4c80dfaak17260d503a007278@mail.gmail.com>
References: <20070615004818.424726597@goop.org>
	<20070615005013.609105644@goop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7205995532468638946=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070615005013.609105644@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: v12n <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

--===============7205995532468638946==
Content-Type: multipart/alternative;
	boundary="----=_Part_56979_20845460.1181923949544"

------=_Part_56979_20845460.1181923949544
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,
I was trying to figure out the boot code of mini-os included in the
Xen-3.1source distribution. Is it going to change significantly
because of this new
boot protocol? thanks!

satya.

On 6/14/07, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
> Boot a Xen kernel using the boot protocol.  There are two parts to this:
>
> 1. Add Xen-specific notes to the bzImage's internal ELF file, so that
>    the Xen domain builder knows what to do with it.  This is simply a
>    matter of adding a new notes-xen.S to the image.  The notes depend
>    on the config options, but they contain no addresses, so there's no
>    concern about relocation, or references into the kernel image itself.
>
> 2. Do the early setup after booting, mainly to remap the kernel to
>    the proper virtual address.  The kernel initially comes up with
>    a P=V 1:1 mapping.  We need to copy the appropriate internal pagetable
>    pointers to get the kernel also mapped at __PAGE_OFFSET.  In order
>    to simplify this process, we just keep the same pte pages, and only
>    update the pgd/pmd entries (depending on whether its PAE or not, and
>    whether the kernel and Xen want to share the same pgd slot).
>
>    A pre-requisite for updating the pagetables is setting up the
>    hypercall page in order to do hypercalls.  Rather than using the
>    Xen Notes to set this up (which would require a relocatable
>    reference from the bzImage notes into the kernel), we use the Xen
>    reserved MSR to set the page address.
>
>    Once the kernel has been relocated, we update some of the pointers
>    in the start_info to kernel virtual addresses, and then jump to
>    xen_start_kernel() to do the rest of the setup before calling
>    start_kernel() proper.
>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
>
> ---
> arch/i386/boot/compressed/Makefile    |    4
> arch/i386/boot/compressed/notes-xen.S |   17 ++
> arch/i386/kernel/head.S               |    2
> arch/i386/xen/Makefile                |    2
> arch/i386/xen/early.c                 |  215
> +++++++++++++++++++++++++++++++++
> arch/i386/xen/enlighten.c             |   29 +---
> arch/i386/xen/xen-head.S              |   38 -----
> arch/i386/xen/xen-ops.h               |    1
> include/asm-i386/xen/hypercall.h      |    4
> 9 files changed, 251 insertions(+), 61 deletions(-)
>
> ===================================================================
> --- a/arch/i386/boot/compressed/Makefile
> +++ b/arch/i386/boot/compressed/Makefile
> @@ -5,7 +5,7 @@
> #
>
> targets                := blob vmlinux.bin vmlinux.bin.gz \
> -                       elfhdr.o head.o misc.o notes.o piggy.o \
> +                       elfhdr.o head.o misc.o notes.o notes-xen.o piggy.o\
>                         vmlinux.bin.all vmlinux.relocs
>
> hostprogs-y    := relocs
> @@ -16,7 +16,7 @@ CFLAGS  := -m32 -D__KERNEL__ $(LINUX_INC
>            $(call cc-option,-fno-stack-protector)
> LDFLAGS := -R $(obj)/vmlinux-syms --defsym IMAGE_OFFSET=$(IMAGE_OFFSET) -T
>
>
> -OBJS=$(addprefix $(obj)/,elfhdr.o head.o misc.o notes.o piggy.o)
> +OBJS=$(addprefix $(obj)/,elfhdr.o head.o misc.o notes.o notes-xen.o
> piggy.o)
>
> $(obj)/blob: $(src)/vmlinux.lds $(obj)/vmlinux-syms $(OBJS) FORCE
>         $(call if_changed,ld)
> ===================================================================
> --- /dev/null
> +++ b/arch/i386/boot/compressed/notes-xen.S
> @@ -0,0 +1,17 @@
> +
> +#ifdef CONFIG_XEN
> +#include <linux/elfnote.h>
> +#include <xen/interface/elfnote.h>
> +
> +       ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
> +       ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
> +       ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz " xen-3.0")
> +       ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,
> +                       .asciz
> "!writable_page_tables|pae_pgdir_above_4gb")
> +#ifdef CONFIG_X86_PAE
> +       ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "yes")
> +#else
> +       ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "no")
> +#endif
> +       ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz "generic")
> +#endif
> ===================================================================
> --- a/arch/i386/kernel/head.S
> +++ b/arch/i386/kernel/head.S
> @@ -594,8 +594,6 @@ fault_msg:
>         .ascii "Int %d: CR2 %p  err %p  EIP %p  CS %p  flags %p\n"
>         .asciz "Stack: %p %p %p %p %p %p %p %p\n"
>
> -#include "../xen/xen-head.S"
> -
> /*
>   * The IDT and GDT 'descriptors' are a strange 48-bit object
>   * only used by the lidt and lgdt instructions. They are not
> ===================================================================
> --- a/arch/i386/xen/Makefile
> +++ b/arch/i386/xen/Makefile
> @@ -1,4 +1,4 @@ obj-y           := enlighten.o setup.o features.o
> -obj-y          := enlighten.o setup.o features.o multicalls.o mmu.o \
> +obj-y          := early.o enlighten.o setup.o features.o multicalls.o
> mmu.o \
>                         events.o time.o manage.o xen-asm.o
>
> obj-$(CONFIG_SMP)      += smp.o
> ===================================================================
> --- /dev/null
> +++ b/arch/i386/xen/early.c
> @@ -0,0 +1,215 @@
> +/*
> + * Very earliest code, run before we're in the kernel virtual address
> + * space.  As a result, we need to be careful about touching static
> + * symbols or any absolute address.
> + */
> +
> +#include <linux/types.h>
> +#include <linux/bug.h>
> +#include <linux/sched.h>
> +
> +#include <asm/bootparam.h>
> +#include <asm/setup.h>
> +#include <asm/paravirt.h>
> +#include <asm/pgtable.h>
> +
> +#include <xen/interface/xen.h>
> +#include <xen/page.h>
> +#include <asm/xen/interface.h>
> +#include <asm/xen/hypercall.h>
> +
> +#include "xen-ops.h"
> +
> +#define PA(ptr)        ((typeof(ptr)) __pa_symbol((ptr)))
> +
> +extern char _end[];
> +
> +static inline void early_cpuid(unsigned int *eax, unsigned int *ebx,
> +                              unsigned int *ecx, unsigned int *edx)
> +{
> +       asm(XEN_EMULATE_PREFIX "cpuid"
> +               : "=a" (*eax),
> +                 "=b" (*ebx),
> +                 "=c" (*ecx),
> +                 "=d" (*edx)
> +               : "0" (*eax), "2" (*ecx));
> +}
> +
> +static __init u64 early_p2m(unsigned long *mfn_list,
> +                           unsigned long phys)
> +{
> +       unsigned offset = phys & ~PAGE_MASK;
> +       return PFN_PHYS((u64)mfn_list[PFN_DOWN(phys)]) + offset;
> +}
> +
> +static __init unsigned long early_m2p(unsigned long mfn)
> +{
> +       unsigned long ret = machine_to_phys_mapping[mfn];
> +       if (ret == ~0)
> +               ret = 0;
> +       return ret;
> +}
> +
> +static __init void setup_hypercall_page(struct start_info *info)
> +{
> +       unsigned long *mfn_list = (unsigned long *)info->mfn_list;
> +       unsigned eax, ebx, ecx, edx;
> +       unsigned long hypercall_mfn;
> +
> +       /* leaf 0x40000000 is a virtual machine leaf */
> +       eax = 0x40000000;
> +       ecx = 0;
> +       early_cpuid(&eax, &ebx, &ecx, &edx);
> +
> +       /* No way we should be able to get here without being under Xen */
> +       if (ebx != 0x566e6558 || /* Signature 1: "XenV" */
> +           ecx != 0x65584d4d || /* Signature 2: "MMXe" */
> +           edx != 0x4d4d566e || /* Signature 3: "nVMM" */
> +           eax < 0x40000002)
> +               BUG();
> +
> +       /* Get the number of hypercall pages (we only need 1) and the
> +          Xen MSR base */
> +       eax = 0x40000002;
> +       early_cpuid(&eax, &ebx, &ecx, &edx);
> +
> +       /* Use magic msr to set the address of the hypercall page */
> +       hypercall_mfn = PFN_DOWN(__pa_symbol(hypercall_page));
> +       if (mfn_list)
> +               hypercall_mfn = mfn_list[hypercall_mfn];
> +
> +       native_write_msr(ebx + 0, ((u64)hypercall_mfn) << PAGE_SHIFT);
> +}
> +
> +static __init pmd_t *get_pmd(pgd_t *pgd, unsigned long addr)
> +{
> +       unsigned idx = pgd_index(addr);
> +       pmd_t *ret;
> +
> +#ifdef CONFIG_X86_PAE
> +       {
> +               unsigned long pfn;
> +               pfn = PFN_DOWN(pgd_val_ma(pgd[idx]));
> +               pfn = machine_to_phys_mapping[pfn];
> +
> +               ret = ((pmd_t *)PFN_PHYS(pfn)) + pmd_index(addr);
> +       }
> +#else
> +       ret = (pmd_t *)&pgd[idx];
> +#endif
> +
> +       return ret;
> +}
> +
> +static __init void copy_mapping(struct start_info *info, void *src, void
> *dst)
> +{
> +       unsigned long *mfn_list = (unsigned long *)info->mfn_list;
> +       struct mmu_update u;
> +
> +       u.ptr = early_p2m(mfn_list, (unsigned long)dst);
> +       u.val = pte_val_ma(*(pte_t *)src);
> +
> +       if (HYPERVISOR_mmu_update(&u, 1, NULL, DOMID_SELF) != 0)
> +               BUG();
> +}
> +
> +static __init void remap_addr_pmd(struct start_info *info, unsigned long
> addr)
> +{
> +       pgd_t *pgd = (pgd_t *)info->pt_base;
> +       pmd_t *src = get_pmd(pgd, addr);
> +       pmd_t *dst = get_pmd(pgd, addr + __PAGE_OFFSET);
> +
> +       copy_mapping(info, src, dst);
> +}
> +
> +static __init void remap_kernel_pmd(struct start_info *info,
> +                                   unsigned long addr, unsigned long max)
> +{
> +       while (addr < max) {
> +               remap_addr_pmd(info, addr);
> +               addr += PMD_SIZE;
> +       }
> +}
> +
> +static __init void remap_addr_pgd(struct start_info *info, unsigned long
> addr)
> +{
> +       pgd_t *pgd = (pgd_t *)info->pt_base;
> +       pgd_t *src = &pgd[pgd_index(addr)];
> +       pgd_t *dst = &pgd[pgd_index(addr + __PAGE_OFFSET)];
> +
> +       copy_mapping(info, src, dst);
> +}
> +
> +static __init void remap_kernel_pgd(struct start_info *info,
> +                                   unsigned long addr, unsigned long max)
> +{
> +       while (addr < max) {
> +               remap_addr_pgd(info, addr);
> +               addr += PGDIR_SIZE;
> +       }
> +}
> +
> +static __init void remap_kernel(struct start_info *info,
> +                               unsigned long start, unsigned long max)
> +{
> +       pgd_t *pgd = (pgd_t *)info->pt_base;
> +
> +#ifdef CONFIG_X86_PAE
> +       /*
> +        * If we're running PAE, the kernel will probably want to be
> +        * mapped into the same pgd slot as Xen.  If so, we need to
> +        * copy the pmd entries rather than the pgd entries.  If not,
> +        * either the kernel doesn't want to be at the top of the
> +        * address space, or Xen has decided not to reserve any space;
> +        * in that case, we can just clone the pgd entries.
> +        */
> +       if (pgd_val_ma(pgd[pgd_index(__PAGE_OFFSET)]) != 0) {
> +               remap_kernel_pmd(info, start, max);
> +               return;
> +       }
> +#endif
> +
> +       remap_kernel_pgd(info, start, max);
> +}
> +
> +void __init xen_entry(void)
> +{
> +       struct start_info *info;
> +       unsigned long limit;
> +
> +       info = (struct start_info *)(unsigned long)
> +               (PA(&boot_params)->hdr.hardware_subarch_data);
> +
> +       BUG_ON(memcmp(info->magic, PA(&"xen-3.0"), 7) != 0);
> +
> +       /* establish a hypercall page */
> +       setup_hypercall_page(info);
> +
> +       /* work out how far we need to remap */
> +       limit = __pa(_end);
> +       limit = max(limit, info->pt_base + (info->nr_pt_frames *
> PAGE_SIZE));
> +       limit = max(limit, info->mfn_list +
> +                   (info->nr_pages * sizeof(unsigned long)));
> +       limit = max(limit, info->mod_start + info->mod_len);
> +       limit = max(limit, early_m2p(info->console.domU.mfn) <<
> PAGE_SHIFT);
> +       limit = max(limit, early_m2p(info->store_mfn) << PAGE_SHIFT);
> +
> +       limit += PAGE_SIZE;
> +
> +       /* remap the kernel to its virtual address */
> +       remap_kernel(info, 0, limit + PAGE_SIZE);
> +
> +       /* repoint things to their new virtual addresses */
> +       info->pt_base = (unsigned long)__va(info->pt_base);
> +       info->mfn_list = (unsigned long)__va(info->mfn_list);
> +
> +       init_pg_tables_end = limit;
> +
> +       asm volatile("mov %0,%%esp;"
> +                    "push $0;"
> +                    "jmp *%1"
> +                    :
> +                    : "i"
> (&init_thread_union.stack[THREAD_SIZE/sizeof(long)]),
> +                      "r" (xen_start_kernel)
> +                    : "memory");
> +}
> ===================================================================
> --- a/arch/i386/xen/enlighten.c
> +++ b/arch/i386/xen/enlighten.c
> @@ -50,6 +50,8 @@
> #include "mmu.h"
> #include "multicalls.h"
>
> +struct hypercall_entry hypercall_page[PAGE_SIZE/sizeof(struct
> hypercall_entry)]
> +       __attribute__((aligned(PAGE_SIZE), section(".bss.page_aligned")));
>
> EXPORT_SYMBOL_GPL(hypercall_page);
>
> DEFINE_PER_CPU(enum paravirt_lazy_mode, xen_lazy_mode);
> @@ -1096,15 +1098,19 @@ static void __init xen_reserve_top(void)
>         reserve_top_address(-top + 2 * PAGE_SIZE);
> }
>
> -/* First C function to be called on Xen boot */
> -asmlinkage void __init xen_start_kernel(void)
> +/*
> + * This is jumped to by early.c, once we're running in the proper
> + * kernel virtual address space.
> + */
> +void __init xen_start_kernel(void)
> {
>         pgd_t *pgd;
>
> -       if (!xen_start_info)
> -               return;
> -
> -       BUG_ON(memcmp(xen_start_info->magic, "xen-3.0", 7) != 0);
> +       xen_start_info = (struct start_info *)
> +               __va(boot_params.hdr.hardware_subarch_data);
> +
> +       /* Get mfn list */
> +       phys_to_machine_mapping = (unsigned long
> *)xen_start_info->mfn_list;
>
>         /* Install Xen paravirt ops */
>         paravirt_ops = xen_paravirt_ops;
> @@ -1116,13 +1122,7 @@ asmlinkage void __init xen_start_kernel(
>
>         xen_setup_features();
>
> -       /* Get mfn list */
> -       if (!xen_feature(XENFEAT_auto_translated_physmap))
> -               phys_to_machine_mapping = (unsigned long
> *)xen_start_info->mfn_list;
> -
>         pgd = (pgd_t *)xen_start_info->pt_base;
> -
> -       init_pg_tables_end = __pa(pgd) +
> xen_start_info->nr_pt_frames*PAGE_SIZE;
>
>         init_mm.pgd = pgd; /* use the Xen pagetables to start */
>
> @@ -1152,11 +1152,6 @@ asmlinkage void __init xen_start_kernel(
>         new_cpu_data.hard_math = 1;
>         new_cpu_data.x86_capability[0] = cpuid_edx(1);
>
> -       /* Poke various useful things into boot_params */
> -       LOADER_TYPE = (9 << 4) | 0;
> -       INITRD_START = xen_start_info->mod_start ?
> __pa(xen_start_info->mod_start) : 0;
> -       INITRD_SIZE = xen_start_info->mod_len;
> -
>         /* Start the world */
>         start_kernel();
> }
> ===================================================================
> --- a/arch/i386/xen/xen- head.S
> +++ /dev/null
> @@ -1,38 +0,0 @@
> -/* Xen-specific pieces of head.S, intended to be included in the right
> -       place in head.S */
> -
> -#ifdef CONFIG_XEN
> -
> -#include <linux/elfnote.h>
> -#include <asm/boot.h>
> -#include <xen/interface/elfnote.h>
> -
> -.pushsection .init.text,"ax",@progbits
> -ENTRY(startup_xen)
> -       movl %esi,xen_start_info
> -       cld
> -       movl $(init_thread_union+THREAD_SIZE),%esp
> -       jmp xen_start_kernel
> -.popsection
> -
> -.pushsection ".bss.page_aligned"
> -       .align PAGE_SIZE_asm
> -ENTRY(hypercall_page)
> -       .skip 0x1000
> -.popsection
> -
> -       ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
> -       ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
> -       ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
> -       ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      .long  __PAGE_OFFSET)
> -       ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          .long  startup_xen)
> -       ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, .long  hypercall_page)
> -       ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,       .asciz
> "!writable_page_tables|pae_pgdir_above_4gb")
> -#ifdef CONFIG_X86_PAE
> -       ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "yes")
> -#else
> -       ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz "no")
> -#endif
> -       ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz "generic")
> -
> -#endif /*CONFIG_XEN */
> ===================================================================
> --- a/arch/i386/xen/xen-ops.h
> +++ b/arch/i386/xen/xen-ops.h
> @@ -19,6 +19,7 @@ void __init xen_arch_setup(void);
> void __init xen_arch_setup(void);
> void __init xen_init_IRQ(void);
>
> +void xen_start_kernel(void);
> void xen_setup_timer(int cpu);
> void xen_setup_cpu_clockevents(void);
> unsigned long xen_cpu_khz(void);
> ===================================================================
> --- a/include/asm-i386/xen/hypercall.h
> +++ b/include/asm-i386/xen/hypercall.h
> @@ -40,7 +40,9 @@
> #include <xen/interface/sched.h>
> #include <xen/interface/physdev.h>
>
> -extern struct { char _entry[32]; } hypercall_page[];
> +extern struct hypercall_entry {
> +       char _entry[32];
> +} hypercall_page[];
>
> #define _hypercall0(type,
> name)                                                \
> ({                                                                     \
>
> --
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
>

------=_Part_56979_20845460.1181923949544
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi,<br>I was trying to figure out the boot code of mini-os included in the Xen-3.1 source distribution. Is it going to change significantly because of this new boot protocol? thanks!<br><br>satya.<br><br><div><span class="gmail_quote">

On 6/14/07, <b class="gmail_sendername">Jeremy Fitzhardinge</b> &lt;<a href="mailto:jeremy@goop.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">jeremy@goop.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

Boot a Xen kernel using the boot protocol.&nbsp;&nbsp;There are two parts to this:<br><br>1. Add Xen-specific notes to the bzImage&#39;s internal ELF file, so that<br>&nbsp;&nbsp; the Xen domain builder knows what to do with it.&nbsp;&nbsp;This is simply a
<br>&nbsp;&nbsp; matter of adding a new notes-xen.S to the image.&nbsp;&nbsp;The notes depend<br>&nbsp;&nbsp; on the config options, but they contain no addresses, so there&#39;s no<br>&nbsp;&nbsp; concern about relocation, or references into the kernel image itself.
<br><br>2. Do the early setup after booting, mainly to remap the kernel to<br>&nbsp;&nbsp; the proper virtual address.&nbsp;&nbsp;The kernel initially comes up with<br>&nbsp;&nbsp; a P=V 1:1 mapping.&nbsp;&nbsp;We need to copy the appropriate internal pagetable
<br>&nbsp;&nbsp; pointers to get the kernel also mapped at __PAGE_OFFSET.&nbsp;&nbsp;In order<br>&nbsp;&nbsp; to simplify this process, we just keep the same pte pages, and only<br>&nbsp;&nbsp; update the pgd/pmd entries (depending on whether its PAE or not, and
<br>&nbsp;&nbsp; whether the kernel and Xen want to share the same pgd slot).<br><br>&nbsp;&nbsp; A pre-requisite for updating the pagetables is setting up the<br>&nbsp;&nbsp; hypercall page in order to do hypercalls.&nbsp;&nbsp;Rather than using the<br>&nbsp;&nbsp; Xen Notes to set this up (which would require a relocatable
<br>&nbsp;&nbsp; reference from the bzImage notes into the kernel), we use the Xen<br>&nbsp;&nbsp; reserved MSR to set the page address.<br><br>&nbsp;&nbsp; Once the kernel has been relocated, we update some of the pointers<br>&nbsp;&nbsp; in the start_info to kernel virtual addresses, and then jump to
<br>&nbsp;&nbsp; xen_start_kernel() to do the rest of the setup before calling<br>&nbsp;&nbsp; start_kernel() proper.<br><br>Signed-off-by: Jeremy Fitzhardinge &lt;<a href="mailto:jeremy@xensource.com" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
jeremy@xensource.com</a>&gt;<br><br>---
<br> arch/i386/boot/compressed/Makefile&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;4<br> arch/i386/boot/compressed/notes-xen.S |&nbsp;&nbsp; 17 ++<br> arch/i386/kernel/head.S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;2<br> arch/i386/xen/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;2<br> arch/i386/xen/early.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;215 +++++++++++++++++++++++++++++++++
<br> arch/i386/xen/enlighten.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 29 +---<br> arch/i386/xen/xen-head.S&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp; 38 -----<br> arch/i386/xen/xen-ops.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;1<br> include/asm-i386/xen/hypercall.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;4<br> 9 files changed, 251 insertions(+), 61 deletions(-)
<br><br>===================================================================<br>--- a/arch/i386/boot/compressed/Makefile<br>+++ b/arch/i386/boot/compressed/Makefile<br>@@ -5,7 +5,7 @@<br> #<br><br> targets&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:= blob 
vmlinux.bin vmlinux.bin.gz \<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; elfhdr.o head.o misc.o notes.o piggy.o \<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; elfhdr.o head.o misc.o notes.o notes-xen.o piggy.o \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vmlinux.bin.all 
vmlinux.relocs
<br><br> hostprogs-y&nbsp;&nbsp;&nbsp;&nbsp;:= relocs<br>@@ -16,7 +16,7 @@ CFLAGS&nbsp;&nbsp;:= -m32 -D__KERNEL__ $(LINUX_INC<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(call cc-option,-fno-stack-protector)<br> LDFLAGS := -R $(obj)/vmlinux-syms --defsym IMAGE_OFFSET=$(IMAGE_OFFSET) -T
<br><br>-OBJS=$(addprefix $(obj)/,elfhdr.o head.o misc.o notes.o piggy.o)<br>+OBJS=$(addprefix $(obj)/,elfhdr.o head.o misc.o notes.o notes-xen.o piggy.o)<br><br> $(obj)/blob: $(src)/vmlinux.lds $(obj)/vmlinux-syms $(OBJS) FORCE
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$(call if_changed,ld)<br>===================================================================<br>--- /dev/null<br>+++ b/arch/i386/boot/compressed/notes-xen.S<br>@@ -0,0 +1,17 @@<br>+<br>+#ifdef CONFIG_XEN<br>+#include &lt;linux/elfnote.h&gt;
<br>+#include &lt;xen/interface/elfnote.h&gt;<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;linux&quot;)<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,&nbsp;&nbsp;.asciz &quot;2.6&quot;)<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,&nbsp;&nbsp;&nbsp;&nbsp;.asciz &quot;
xen-3.0&quot;)<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;!writable_page_tables|pae_pgdir_above_4gb&quot;)<br>+#ifdef CONFIG_X86_PAE<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;yes&quot;)
<br>+#else<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;no&quot;)<br>+#endif<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_LOADER,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;generic&quot;)<br>+#endif<br>===================================================================
<br>--- a/arch/i386/kernel/head.S<br>+++ b/arch/i386/kernel/head.S<br>@@ -594,8 +594,6 @@ fault_msg:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.ascii &quot;Int %d: CR2 %p&nbsp;&nbsp;err %p&nbsp;&nbsp;EIP %p&nbsp;&nbsp;CS %p&nbsp;&nbsp;flags %p\n&quot;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.asciz &quot;Stack: %p %p %p %p %p %p %p %p\n&quot;
<br><br>-#include &quot;../xen/xen-head.S&quot;<br>-<br> /*<br>&nbsp;&nbsp;* The IDT and GDT &#39;descriptors&#39; are a strange 48-bit object<br>&nbsp;&nbsp;* only used by the lidt and lgdt instructions. They are not<br>===================================================================
<br>--- a/arch/i386/xen/Makefile<br>+++ b/arch/i386/xen/Makefile<br>@@ -1,4 +1,4 @@ obj-y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; := enlighten.o setup.o features.o<br>-obj-y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:= enlighten.o setup.o features.o multicalls.o mmu.o \<br>+obj-y&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:= 
early.o enlighten.o setup.o features.o multicalls.o mmu.o \<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;events.o time.o manage.o xen-asm.o<br><br> obj-$(CONFIG_SMP)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;+= smp.o<br>===================================================================
<br>--- /dev/null<br>+++ b/arch/i386/xen/early.c<br>@@ -0,0 +1,215 @@<br>+/*<br>+ * Very earliest code, run before we&#39;re in the kernel virtual address<br>+ * space.&nbsp;&nbsp;As a result, we need to be careful about touching static
<br>+ * symbols or any absolute address.<br>+ */<br>+<br>+#include &lt;linux/types.h&gt;<br>+#include &lt;linux/bug.h&gt;<br>+#include &lt;linux/sched.h&gt;<br>+<br>+#include &lt;asm/bootparam.h&gt;<br>+#include &lt;asm/setup.h&gt;
<br>+#include &lt;asm/paravirt.h&gt;<br>+#include &lt;asm/pgtable.h&gt;<br>+<br>+#include &lt;xen/interface/xen.h&gt;<br>+#include &lt;xen/page.h&gt;<br>+#include &lt;asm/xen/interface.h&gt;<br>+#include &lt;asm/xen/hypercall.h&gt;
<br>+<br>+#include &quot;xen-ops.h&quot;<br>+<br>+#define PA(ptr)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;((typeof(ptr)) __pa_symbol((ptr)))<br>+<br>+extern char _end[];<br>+<br>+static inline void early_cpuid(unsigned int *eax, unsigned int *ebx,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unsigned int *ecx, unsigned int *edx)
<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asm(XEN_EMULATE_PREFIX &quot;cpuid&quot;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &quot;=a&quot; (*eax),<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;=b&quot; (*ebx),<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;=c&quot; (*ecx),<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;=d&quot; (*edx)
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &quot;0&quot; (*eax), &quot;2&quot; (*ecx));<br>+}<br>+<br>+static __init u64 early_p2m(unsigned long *mfn_list,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long phys)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned offset = phys &amp; ~PAGE_MASK;
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return PFN_PHYS((u64)mfn_list[PFN_DOWN(phys)]) + offset;<br>+}<br>+<br>+static __init unsigned long early_m2p(unsigned long mfn)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long ret = machine_to_phys_mapping[mfn];<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret == ~0)
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = 0;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>+}<br>+<br>+static __init void setup_hypercall_page(struct start_info *info)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *mfn_list = (unsigned long *)info-&gt;mfn_list;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned eax, ebx, ecx, edx;
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long hypercall_mfn;<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* leaf 0x40000000 is a virtual machine leaf */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eax = 0x40000000;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecx = 0;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; early_cpuid(&amp;eax, &amp;ebx, &amp;ecx, &amp;edx);<br>

+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* No way we should be able to get here without being under Xen */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ebx != 0x566e6558 || /* Signature 1: &quot;XenV&quot; */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecx != 0x65584d4d || /* Signature 2: &quot;MMXe&quot; */
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edx != 0x4d4d566e || /* Signature 3: &quot;nVMM&quot; */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eax &lt; 0x40000002)<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get the number of hypercall pages (we only need 1) and the<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Xen MSR base */
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eax = 0x40000002;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; early_cpuid(&amp;eax, &amp;ebx, &amp;ecx, &amp;edx);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Use magic msr to set the address of the hypercall page */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hypercall_mfn = PFN_DOWN(__pa_symbol(hypercall_page));
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (mfn_list)<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hypercall_mfn = mfn_list[hypercall_mfn];<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; native_write_msr(ebx + 0, ((u64)hypercall_mfn) &lt;&lt; PAGE_SHIFT);<br>+}<br>+<br>+static __init pmd_t *get_pmd(pgd_t *pgd, unsigned long addr)
<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned idx = pgd_index(addr);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pmd_t *ret;<br>+<br>+#ifdef CONFIG_X86_PAE<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long pfn;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pfn = PFN_DOWN(pgd_val_ma(pgd[idx]));<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pfn = machine_to_phys_mapping[pfn];
<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = ((pmd_t *)PFN_PHYS(pfn)) + pmd_index(addr);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>+#else<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = (pmd_t *)&amp;pgd[idx];<br>+#endif<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>+}<br>+<br>+static __init void copy_mapping(struct start_info *info, void *src, void *dst)
<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long *mfn_list = (unsigned long *)info-&gt;mfn_list;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mmu_update u;<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u.ptr = early_p2m(mfn_list, (unsigned long)dst);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u.val = pte_val_ma(*(pte_t *)src);
<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (HYPERVISOR_mmu_update(&amp;u, 1, NULL, DOMID_SELF) != 0)<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>+}<br>+<br>+static __init void remap_addr_pmd(struct start_info *info, unsigned long addr)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pgd_t *pgd = (pgd_t *)info-&gt;pt_base;
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pmd_t *src = get_pmd(pgd, addr);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pmd_t *dst = get_pmd(pgd, addr + __PAGE_OFFSET);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_mapping(info, src, dst);<br>+}<br>+<br>+static __init void remap_kernel_pmd(struct start_info *info,
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long addr, unsigned long max)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (addr &lt; max) {<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remap_addr_pmd(info, addr);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr += PMD_SIZE;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}
<br>+<br>+static __init void remap_addr_pgd(struct start_info *info, unsigned long addr)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pgd_t *pgd = (pgd_t *)info-&gt;pt_base;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pgd_t *src = &amp;pgd[pgd_index(addr)];<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pgd_t *dst = &amp;pgd[pgd_index(addr + __PAGE_OFFSET)];
<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_mapping(info, src, dst);<br>+}<br>+<br>+static __init void remap_kernel_pgd(struct start_info *info,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long addr, unsigned long max)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (addr &lt; max) {
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remap_addr_pgd(info, addr);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr += PGDIR_SIZE;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>+}<br>+<br>+static __init void remap_kernel(struct start_info *info,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long start, unsigned long max)
<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pgd_t *pgd = (pgd_t *)info-&gt;pt_base;<br>+<br>+#ifdef CONFIG_X86_PAE<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* If we&#39;re running PAE, the kernel will probably want to be<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* mapped into the same pgd slot as Xen.&nbsp;&nbsp;If so, we need to
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* copy the pmd entries rather than the pgd entries.&nbsp;&nbsp;If not,<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* either the kernel doesn&#39;t want to be at the top of the<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* address space, or Xen has decided not to reserve any space;
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;* in that case, we can just clone the pgd entries.<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*/<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pgd_val_ma(pgd[pgd_index(__PAGE_OFFSET)]) != 0) {<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remap_kernel_pmd(info, start, max);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>+#endif<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remap_kernel_pgd(info, start, max);<br>+}<br>+<br>+void __init xen_entry(void)<br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct start_info *info;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long limit;<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info = (struct start_info *)(unsigned long)
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (PA(&amp;boot_params)-&gt;hdr.hardware_subarch_data);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(memcmp(info-&gt;magic, PA(&amp;&quot;xen-3.0&quot;), 7) != 0);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* establish a hypercall page */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup_hypercall_page(info);
<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* work out how far we need to remap */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; limit = __pa(_end);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; limit = max(limit, info-&gt;pt_base + (info-&gt;nr_pt_frames * PAGE_SIZE));<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; limit = max(limit, info-&gt;mfn_list +
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (info-&gt;nr_pages * sizeof(unsigned long)));<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; limit = max(limit, info-&gt;mod_start + info-&gt;mod_len);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; limit = max(limit, early_m2p(info-&gt;console.domU.mfn) &lt;&lt; PAGE_SHIFT);
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; limit = max(limit, early_m2p(info-&gt;store_mfn) &lt;&lt; PAGE_SHIFT);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; limit += PAGE_SIZE;<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* remap the kernel to its virtual address */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remap_kernel(info, 0, limit + PAGE_SIZE);
<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* repoint things to their new virtual addresses */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;pt_base = (unsigned long)__va(info-&gt;pt_base);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info-&gt;mfn_list = (unsigned long)__va(info-&gt;mfn_list);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pg_tables_end = limit;
<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asm volatile(&quot;mov %0,%%esp;&quot;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;push $0;&quot;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;jmp *%1&quot;<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &quot;i&quot; (&amp;init_thread_union.stack[THREAD_SIZE/sizeof(long)]),
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&quot;r&quot; (xen_start_kernel)<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: &quot;memory&quot;);<br>+}<br>===================================================================<br>--- a/arch/i386/xen/enlighten.c<br>

+++ b/arch/i386/xen/enlighten.c<br>@@ -50,6 +50,8 @@<br> #include &quot;mmu.h&quot;<br> #include &quot;multicalls.h&quot;<br><br>+struct hypercall_entry hypercall_page[PAGE_SIZE/sizeof(struct hypercall_entry)]<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __attribute__((aligned(PAGE_SIZE), section(&quot;.bss.page_aligned&quot;)));
<br> EXPORT_SYMBOL_GPL(hypercall_page);<br><br> DEFINE_PER_CPU(enum paravirt_lazy_mode, xen_lazy_mode);<br>@@ -1096,15 +1098,19 @@ static void __init xen_reserve_top(void)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;reserve_top_address(-top + 2 * PAGE_SIZE);
<br> }<br><br>-/* First C function to be called on Xen boot */<br>-asmlinkage void __init xen_start_kernel(void)<br>+/*<br>+ * This is jumped to by early.c, once we&#39;re running in the proper<br>+ * kernel virtual address space.
<br>+ */<br>+void __init xen_start_kernel(void)<br> {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pgd_t *pgd;<br><br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xen_start_info)<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>-<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(memcmp(xen_start_info-&gt;magic, &quot;xen-3.0&quot;, 7) != 0);
<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xen_start_info = (struct start_info *)<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __va(boot_params.hdr.hardware_subarch_data);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get mfn list */<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_to_machine_mapping = (unsigned long *)xen_start_info-&gt;mfn_list;
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Install Xen paravirt ops */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;paravirt_ops = xen_paravirt_ops;<br>@@ -1116,13 +1122,7 @@ asmlinkage void __init xen_start_kernel(<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xen_setup_features();<br><br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get mfn list */
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!xen_feature(XENFEAT_auto_translated_physmap))<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_to_machine_mapping = (unsigned long *)xen_start_info-&gt;mfn_list;<br>-<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pgd = (pgd_t *)xen_start_info-&gt;pt_base;<br>-<br>

-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; init_pg_tables_end = __pa(pgd) + xen_start_info-&gt;nr_pt_frames*PAGE_SIZE;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;init_mm.pgd = pgd; /* use the Xen pagetables to start */<br><br>@@ -1152,11 +1152,6 @@ asmlinkage void __init xen_start_kernel(
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;new_cpu_data.hard_math = 1;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;new_cpu_data.x86_capability[0] = cpuid_edx(1);<br><br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Poke various useful things into boot_params */<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LOADER_TYPE = (9 &lt;&lt; 4) | 0;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INITRD_START = xen_start_info-&gt;mod_start ? __pa(xen_start_info-&gt;mod_start) : 0;
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; INITRD_SIZE = xen_start_info-&gt;mod_len;<br>-<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/* Start the world */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;start_kernel();<br> }<br>===================================================================<br>--- a/arch/i386/xen/xen-
head.S<br>+++ /dev/null<br>@@ -1,38 +0,0 @@<br>-/* Xen-specific pieces of head.S, intended to be included in the right<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; place in head.S */<br>-<br>-#ifdef CONFIG_XEN<br>-<br>-#include &lt;linux/elfnote.h&gt;<br>

-#include &lt;asm/boot.h&gt;<br>-#include &lt;xen/interface/elfnote.h&gt;<br>-<br>-.pushsection .init.text,&quot;ax&quot;,@progbits<br>-ENTRY(startup_xen)<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; movl %esi,xen_start_info<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cld<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; movl $(init_thread_union+THREAD_SIZE),%esp
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; jmp xen_start_kernel<br>-.popsection<br>-<br>-.pushsection &quot;.bss.page_aligned&quot;<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .align PAGE_SIZE_asm<br>-ENTRY(hypercall_page)<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .skip 0x1000<br>-.popsection<br>-<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;linux&quot;)
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,&nbsp;&nbsp;.asciz &quot;2.6&quot;)<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,&nbsp;&nbsp;&nbsp;&nbsp;.asciz &quot;xen-3.0&quot;)<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.long&nbsp;&nbsp;__PAGE_OFFSET)
<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;.long&nbsp;&nbsp;startup_xen)<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_HYPERCALL_PAGE, .long&nbsp;&nbsp;hypercall_page)<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_FEATURES,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;!writable_page_tables|pae_pgdir_above_4gb&quot;)
<br>-#ifdef CONFIG_X86_PAE<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;yes&quot;)<br>-#else<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;no&quot;)<br>-#endif<br>-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ELFNOTE(Xen, XEN_ELFNOTE_LOADER,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .asciz &quot;generic&quot;)
<br>-<br>-#endif /*CONFIG_XEN */<br>===================================================================<br>--- a/arch/i386/xen/xen-ops.h<br>+++ b/arch/i386/xen/xen-ops.h<br>@@ -19,6 +19,7 @@ void __init xen_arch_setup(void);
<br> void __init xen_arch_setup(void);<br> void __init xen_init_IRQ(void);<br><br>+void xen_start_kernel(void);<br> void xen_setup_timer(int cpu);<br> void xen_setup_cpu_clockevents(void);<br> unsigned long xen_cpu_khz(void);
<br>===================================================================<br>--- a/include/asm-i386/xen/hypercall.h<br>+++ b/include/asm-i386/xen/hypercall.h<br>@@ -40,7 +40,9 @@<br> #include &lt;xen/interface/sched.h&gt;<br>

 #include &lt;xen/interface/physdev.h&gt;<br><br>-extern struct { char _entry[32]; } hypercall_page[];<br>+extern struct hypercall_entry {<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char _entry[32];<br>+} hypercall_page[];<br><br> #define _hypercall0(type, name)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\
<br> ({&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br><br>--<br><br>_______________________________________________<br>Virtualization mailing list<br><a href="mailto:Virtualization@lists.linux-foundation.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">

Virtualization@lists.linux-foundation.org</a><br><a href="https://lists.linux-foundation.org/mailman/listinfo/virtualization" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">https://lists.linux-foundation.org/mailman/listinfo/virtualization
</a><br></blockquote></div><br>
<br clear="all"><br><br>

------=_Part_56979_20845460.1181923949544--

--===============7205995532468638946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============7205995532468638946==--
