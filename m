From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: Re: [PATCH 3/3] x86: Support compiling out userspace I/O (iopl and
	ioperm)
Date: Thu, 31 Oct 2013 21:04:42 +0100
Message-ID: <1383249882.6635.41326997.4D0EF91B@webmail.messagingengine.com>
References: <cover.1382407802.git.josh@joshtriplett.org>
	<c6432a64f977031b3d1cf0df1d292c3808faf166.1382407802.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c6432a64f977031b3d1cf0df1d292c3808faf166.1382407802.git.josh@joshtriplett.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Josh Triplett <josh@joshtriplett.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, x86@kernel.org, xen-devel@lists.xenproject.org
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, David Herrmann <dh.herrmann@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <keescook@chromium.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ross Lagerwall <rosslagerwall@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>, Chris Wright <chrisw@s>
List-Id: virtualization@lists.linuxfoundation.org

Hi Josh,

On Tue, Oct 22, 2013, at 3:35, Josh Triplett wrote:
> On the vast majority of modern systems, no processes will use the
> userspsace I/O syscalls, iopl and ioperm.  Add a new config option,
> CONFIG_X86_IOPORT, to support configuring them out of the kernel
> entirely.  Since these syscalls only exist to support rare legacy
> userspace programs, X86_IOPORT does not depend on EXPERT, though it does
> still default to y.
> 
> In addition to saving a significant amount of space, this also reduces
> the size of several major kernel data structures, drops a bit of code
> from several task-related hot paths, and reduces the attack surface of
> the kernel.
> 
> All of the task-related code dealing with userspace I/O permissions now
> lives in process-io.h as several new inline functions, which become
> no-ops when CONFIG_X86_IOPORT.
> 
> bloat-o-meter shows a net reduction of 17681 bytes on 32-bit and 9719
> bytes on 64-bit:
> 
> 32-bit bloat-o-meter:
> add/remove: 0/3 grow/shrink: 0/10 up/down: 0/-17681 (-17681)
> function                                     old     new   delta
> cpu_init                                     676     668      -8
> ioperm_active                                 18       7     -11
> init_task                                   1296    1284     -12
> exit_thread                                  179      91     -88
> ioperm_get                                   103      10     -93
> __switch_to_xtra                             254     161     -93
> sys_iopl                                     127       -    -127
> SyS_iopl                                     127       -    -127

These are not really different ;)

> copy_thread                                  606     446    -160
> vt_ioctl                                    4127    3919    -208
> sys_ioperm                                   370       -    -370
> init_tss                                    8576     384   -8192
> doublefault_tss                             8576     384   -8192
> 
> 64-bit bloat-o-meter:
> add/remove: 0/4 grow/shrink: 2/9 up/down: 45/-9764 (-9719)
> function                                     old     new   delta
> cpu_init                                     958     995     +37
> arch_align_stack                              78      86      +8
> perf_event_exit_task                         525     517      -8
> ioperm_active                                 17       8      -9
> init_task                                   1968    1944     -24
> stub_iopl                                     81       -     -81
> ioperm_get                                   111      11    -100
> __switch_to_xtra                             281     164    -117
> exit_thread                                  212      92    -120
> vt_ioctl                                    4432    4304    -128
> sys_iopl                                     137       -    -137
> SyS_iopl                                     137       -    -137
> copy_thread                                  694     520    -174
> sys_ioperm                                   473       -    -473
> init_tss                                    8896     640   -8256
> 
> Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> ---
>  arch/x86/Kconfig                      | 10 +++++
>  arch/x86/include/asm/paravirt.h       |  2 +
>  arch/x86/include/asm/paravirt_types.h |  2 +
>  arch/x86/include/asm/processor.h      | 51 +++++++++++++++++++++----
>  arch/x86/include/asm/syscalls.h       |  3 ++
>  arch/x86/kernel/Makefile              |  3 +-
>  arch/x86/kernel/cpu/common.c          | 12 +-----
>  arch/x86/kernel/entry_64.S            |  9 +++--
>  arch/x86/kernel/paravirt.c            |  2 +
>  arch/x86/kernel/process-io.h          | 71 +++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/process.c             | 34 ++---------------
>  arch/x86/kernel/process_32.c          | 11 +-----
>  arch/x86/kernel/ptrace.c              |  8 ++++
>  arch/x86/xen/enlighten.c              |  4 ++
>  drivers/tty/vt/vt_ioctl.c             |  2 +-
>  kernel/sys_ni.c                       |  5 +++
>  16 files changed, 168 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index e241a19..d5b1e68 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -976,6 +976,16 @@ config VM86
>  	  XFree86 to initialize some video cards via BIOS. Disabling this
>  	  option saves about 6k.
>  
> +config X86_IOPORT
> +	bool "iopl and ioperm system calls"
> +	default y
> +	---help---
> +	  This option enables the iopl and ioperm system calls, which allow
> +	  privileged userspace processes to directly access I/O ports. This
> +	  is used by some legacy software to drive hardware directly from
> +	  userspace rather than via a proper kernel driver. Unless you intend
> +	  to run such software, you can safely say N here.
> +

I think this entry should be under General setup / Configure standard kernel
features (expert users). Remove references to "legacy" and "proper driver".

>  config TOSHIBA
>  	tristate "Toshiba Laptop support"
>  	depends on X86_32
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 401f350..2e106d5 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -299,10 +299,12 @@ static inline void write_idt_entry(gate_desc *dt, int entry, const gate_desc *g)
>  {
>  	PVOP_VCALL3(pv_cpu_ops.write_idt_entry, dt, entry, g);
>  }
> +#ifdef CONFIG_X86_IOPORT
>  static inline void set_iopl_mask(unsigned mask)
>  {
>  	PVOP_VCALL1(pv_cpu_ops.set_iopl_mask, mask);
>  }
> +#endif /* CONFIG_X86_IOPORT */
>  
>  /* The paravirtualized I/O functions */
>  static inline void slow_down_io(void)
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index aab8f67..bc5bfeb 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -142,7 +142,9 @@ struct pv_cpu_ops {
>  
>  	void (*load_sp0)(struct tss_struct *tss, struct thread_struct *t);
>  
> +#ifdef CONFIG_X86_IOPORT
>  	void (*set_iopl_mask)(unsigned mask);
> +#endif /* CONFIG_X86_IOPORT */
>  
>  	void (*wbinvd)(void);
>  	void (*io_delay)(void);
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 03d3003..48f6fbe 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -256,7 +256,11 @@ struct x86_hw_tss {
>  /*
>   * IO-bitmap sizes:
>   */
> +#ifdef CONFIG_X86_IOPORT
>  #define IO_BITMAP_BITS			65536
> +#else
> +#define IO_BITMAP_BITS			0
> +#endif
>  #define IO_BITMAP_BYTES			(IO_BITMAP_BITS/8)
>  #define IO_BITMAP_LONGS			(IO_BITMAP_BYTES/sizeof(long))
>  #define INVALID_IO_BITMAP_OFFSET	0x8000
> @@ -269,6 +273,7 @@ struct tss_struct {
>  	 */
>  	struct x86_hw_tss	x86_tss;
>  
> +#ifdef CONFIG_X86_IOPORT
>  	/*
>  	 * The extra 1 is there because the CPU will access an
>  	 * additional byte beyond the end of the IO permission
> @@ -276,6 +281,7 @@ struct tss_struct {
>  	 * be within the limit.
>  	 */
>  	unsigned long		io_bitmap[IO_BITMAP_LONGS + 1];
> +#endif /* CONFIG_X86_IOPORT */
>  
>  	/*
>  	 * .. and then another 0x100 bytes for the emergency kernel stack:
> @@ -286,6 +292,24 @@ struct tss_struct {
>  
>  DECLARE_PER_CPU_SHARED_ALIGNED(struct tss_struct, init_tss);
>  
> +static inline void init_tss_io(struct tss_struct *t)
> +{
> +#ifdef CONFIG_X86_IOPORT
> +	int i;
> +
> +	t->x86_tss.io_bitmap_base = offsetof(struct tss_struct, io_bitmap);
> +
> +	/*
> +	 * <= is required because the CPU will access up to
> +	 * 8 bits beyond the end of the IO permission bitmap.
> +	 */
> +	for (i = 0; i <= IO_BITMAP_LONGS; i++)
> +		t->io_bitmap[i] = ~0UL;
> +#else
> +	t->x86_tss.io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
> +#endif
> +}
> +
>  /*
>   * Save the original ist values for checking stack pointers during debugging
>   */
> @@ -484,13 +508,16 @@ struct thread_struct {
>  	unsigned int		saved_fs;
>  	unsigned int		saved_gs;
>  #endif
> +#ifdef CONFIG_X86_IOPORT
>  	/* IO permissions: */
>  	unsigned long		*io_bitmap_ptr;
>  	unsigned long		iopl;
>  	/* Max allowed port in the bitmap, in bytes: */
>  	unsigned		io_bitmap_max;
> +#endif /* CONFIG_X86_IOPORT */
>  };
>  
> +#ifdef CONFIG_X86_IOPORT
>  /*
>   * Set IOPL bits in EFLAGS from given mask
>   */
> @@ -509,6 +536,7 @@ static inline void native_set_iopl_mask(unsigned mask)
>  		      : "i" (~X86_EFLAGS_IOPL), "r" (mask));
>  #endif
>  }
> +#endif /* CONFIG_X86_IOPORT */
>  
>  static inline void
>  native_load_sp0(struct tss_struct *tss, struct thread_struct *thread)
> @@ -828,12 +856,8 @@ static inline void spin_lock_prefetch(const void *x)
>  #define STACK_TOP		TASK_SIZE
>  #define STACK_TOP_MAX		STACK_TOP
>  
> -#define INIT_THREAD  {							  \
> -	.sp0			= sizeof(init_stack) + (long)&init_stack, \
> -	.vm86_info		= NULL,					  \
> -	.sysenter_cs		= __KERNEL_CS,				  \
> -	.io_bitmap_ptr		= NULL,					  \
> -}
> +#ifdef CONFIG_X86_IOPORT
> +#define INIT_THREAD_IO .io_bitmap_ptr = NULL,
>  
>  /*
>   * Note that the .io_bitmap member must be extra-big. This is because
> @@ -841,6 +865,19 @@ static inline void spin_lock_prefetch(const void *x)
>   * permission bitmap. The extra byte must be all 1 bits, and must
>   * be within the limit.
>   */
> +#define INIT_TSS_IO .io_bitmap = { [0 ... IO_BITMAP_LONGS] = ~0 },
> +#else
> +#define INIT_THREAD_IO
> +#define INIT_TSS_IO
> +#endif
> +
> +#define INIT_THREAD  {							  \
> +	.sp0			= sizeof(init_stack) + (long)&init_stack, \
> +	.vm86_info		= NULL,					  \
> +	.sysenter_cs		= __KERNEL_CS,				  \
> +	INIT_THREAD_IO							  \
> +}
> +
>  #define INIT_TSS  {							  \
>  	.x86_tss = {							  \
>  		.sp0		= sizeof(init_stack) + (long)&init_stack, \
> @@ -848,7 +885,7 @@ static inline void spin_lock_prefetch(const void *x)
>  		.ss1		= __KERNEL_CS,				  \
>  		.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,		  \
>  	 },								  \
> -	.io_bitmap		= { [0 ... IO_BITMAP_LONGS] = ~0 },	  \
> +	INIT_TSS_IO							  \
>  }
>  
>  extern unsigned long thread_saved_pc(struct task_struct *tsk);
> diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
> index 592a6a6..4db79ea 100644
> --- a/arch/x86/include/asm/syscalls.h
> +++ b/arch/x86/include/asm/syscalls.h
> @@ -16,9 +16,12 @@
>  #include <linux/types.h>
>  
>  /* Common in X86_32 and X86_64 */
> +
> +#ifdef CONFIG_X86_IOPORT
>  /* kernel/ioport.c */
>  asmlinkage long sys_ioperm(unsigned long, unsigned long, int);
>  asmlinkage long sys_iopl(unsigned int);
> +#endif /* CONFIG_X86_IOPORT */
>  
>  /* kernel/ldt.c */
>  asmlinkage int sys_modify_ldt(int, void __user *, unsigned long);
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index a5408b9..9644737 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -20,7 +20,8 @@ CFLAGS_irq.o := -I$(src)/../include/asm/trace
>  
>  obj-y			:= process_$(BITS).o signal.o entry_$(BITS).o
>  obj-y			+= traps.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
> -obj-y			+= time.o ioport.o ldt.o dumpstack.o nmi.o
> +obj-y			+= time.o ldt.o dumpstack.o nmi.o
> +obj-$(CONFIG_X86_IOPORT) += ioport.o
>  obj-y			+= setup.o x86_init.o i8259.o irqinit.o jump_label.o
>  obj-$(CONFIG_IRQ_WORK)  += irq_work.o
>  obj-y			+= probe_roms.o
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 2793d1f..01235ef 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1223,7 +1223,6 @@ void cpu_init(void)
>  	struct tss_struct *t;
>  	unsigned long v;
>  	int cpu;
> -	int i;
>  
>  	/*
>  	 * Load microcode on this cpu if a valid microcode is available.
> @@ -1285,14 +1284,7 @@ void cpu_init(void)
>  		}
>  	}
>  
> -	t->x86_tss.io_bitmap_base = offsetof(struct tss_struct, io_bitmap);
> -
> -	/*
> -	 * <= is required because the CPU will access up to
> -	 * 8 bits beyond the end of the IO permission bitmap.
> -	 */
> -	for (i = 0; i <= IO_BITMAP_LONGS; i++)
> -		t->io_bitmap[i] = ~0UL;
> +	init_tss_io(t);
>  
>  	atomic_inc(&init_mm.mm_count);
>  	me->active_mm = &init_mm;
> @@ -1351,7 +1343,7 @@ void cpu_init(void)
>  	load_TR_desc();
>  	load_LDT(&init_mm.context);
>  
> -	t->x86_tss.io_bitmap_base = offsetof(struct tss_struct, io_bitmap);
> +	init_tss_io(t);

This patch is too big. I think it would all look nicer if you added ioport.c in
one patch, and then convert the users in a separate patch?

>  #ifdef CONFIG_DOUBLEFAULT
>  	/* Set up doublefault TSS pointer in the GDT */
> diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
> index 1b69951..eb4f5ba 100644
> --- a/arch/x86/kernel/entry_64.S
> +++ b/arch/x86/kernel/entry_64.S
> @@ -844,6 +844,11 @@ ENTRY(stub_\func)
>  END(stub_\func)
>  	.endm
>  
> +	FORK_LIKE  clone
> +	FORK_LIKE  fork
> +	FORK_LIKE  vfork
> +
> +#ifdef CONFIG_X86_IOPORT
>  	.macro FIXED_FRAME label,func
>  ENTRY(\label)
>  	CFI_STARTPROC
> @@ -856,10 +861,8 @@ ENTRY(\label)
>  END(\label)
>  	.endm
>  
> -	FORK_LIKE  clone
> -	FORK_LIKE  fork
> -	FORK_LIKE  vfork
>  	FIXED_FRAME stub_iopl, sys_iopl
> +#endif /* CONFIG_X86_IOPORT */
>  
>  ENTRY(ptregscall_common)
>  	DEFAULT_FRAME 1 8	/* offset 8: return address */
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 1b10af8..46da3d9 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -382,7 +382,9 @@ __visible struct pv_cpu_ops pv_cpu_ops = {
>  	.iret = native_iret,
>  	.swapgs = native_swapgs,
>  
> +#ifdef CONFIG_X86_IOPORT
>  	.set_iopl_mask = native_set_iopl_mask,
> +#endif /* CONFIG_X86_IOPORT */
>  	.io_delay = native_io_delay,
>  
>  	.start_context_switch = paravirt_nop,
> diff --git a/arch/x86/kernel/process-io.h b/arch/x86/kernel/process-io.h
> index d884444..3e773fa 100644
> --- a/arch/x86/kernel/process-io.h
> +++ b/arch/x86/kernel/process-io.h
> @@ -1,9 +1,17 @@
>  #ifndef _X86_KERNEL_PROCESS_IO_H
>  #define _X86_KERNEL_PROCESS_IO_H
>  
> +static inline void clear_thread_io_bitmap(struct task_struct *p)
> +{
> +#ifdef CONFIG_X86_IOPORT
> +	p->thread.io_bitmap_ptr = NULL;
> +#endif /* CONFIG_X86_IOPORT */
> +}
> +

This is thought of as ugly... Instead, do something like

#ifndef CONFIG_X86_IOPORT

static inline void clear_thread_io_bitmap(struct task_struct *p) {}
static inline int copy_io_bitmap(struct task_struct *me, struct task_struct *p) {return 0}
... etc...

#else

static inline void clear_thread_io_bitmap(struct task_struct *p)
{
   p->thread.io_bitmap_ptr = NULL;
}
... etc...

#endif


>  static inline int copy_io_bitmap(struct task_struct *me,
>  				 struct task_struct *p)
>  {
> +#ifdef CONFIG_X86_IOPORT
>  	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
>  		p->thread.io_bitmap_ptr = kmemdup(me->thread.io_bitmap_ptr,
>  						  IO_BITMAP_BYTES, GFP_KERNEL);
> @@ -15,8 +23,71 @@ static inline int copy_io_bitmap(struct task_struct *me,
>  	} else {
>  		p->thread.io_bitmap_ptr = NULL;
>  	}
> +#endif /* CONFIG_X86_IOPORT */
>  
>  	return 0;
>  }
>  
> +static inline void exit_thread_io(struct task_struct *me)
> +{
> +#ifdef CONFIG_X86_IOPORT
> +        struct thread_struct *t = &me->thread;
> +        unsigned long *bp = t->io_bitmap_ptr;
> +
> +        if (bp) {
> +                struct tss_struct *tss = &per_cpu(init_tss, get_cpu());
> +
> +                t->io_bitmap_ptr = NULL;
> +                clear_thread_flag(TIF_IO_BITMAP);
> +                /*
> +                 * Careful, clear this in the TSS too:
> +                 */
> +                memset(tss->io_bitmap, 0xff, t->io_bitmap_max);
> +                t->io_bitmap_max = 0;
> +                put_cpu();
> +                kfree(bp);
> +        }
> +#endif /* CONFIG_X86_IOPORT */
> +}
> +
> +static inline void switch_iopl_mask(struct thread_struct *prev,
> +				    struct thread_struct *next)
> +{
> +#ifdef CONFIG_X86_IOPORT
> +        /*
> +         * Restore IOPL if needed.  In normal use, the flags restore
> +         * in the switch assembly will handle this.  But if the kernel
> +         * is running virtualized at a non-zero CPL, the popf will
> +         * not restore flags, so it must be done in a separate step.
> +         */
> +        if (get_kernel_rpl() && unlikely(prev->iopl != next->iopl))
> +                set_iopl_mask(next->iopl);
> +#endif /* CONFIG_X86_IOPORT */
> +}
> +
> +static inline void switch_io_bitmap(struct tss_struct *tss,
> +				    struct task_struct *prev_p,
> +				    struct task_struct *next_p)
> +{
> +#ifdef CONFIG_X86_IOPORT
> +        struct thread_struct *prev, *next;
> +        prev = &prev_p->thread;
> +        next = &next_p->thread;
> +
> +        if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
> +                /*
> +                 * Copy the relevant range of the IO bitmap.
> +                 * Normally this is 128 bytes or less:
> +                 */
> +                memcpy(tss->io_bitmap, next->io_bitmap_ptr,
> +                       max(prev->io_bitmap_max, next->io_bitmap_max));
> +        } else if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
> +                /*
> +                 * Clear any possible leftover bits:
> +                 */
> +                memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
> +        }
> +#endif /* CONFIG_X86_IOPORT */
> +}
> +
>  #endif /* _X86_KERNEL_PROCESS_IO_H */
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index c83516b..2df5b00 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -29,6 +29,8 @@
>  #include <asm/debugreg.h>
>  #include <asm/nmi.h>
>  
> +#include "process-io.h"
> +
>  /*
>   * per-CPU TSS segments. Threads are completely 'soft' on Linux,
>   * no more per-task TSS's. The TSS size is kept cacheline-aligned
> @@ -101,23 +103,7 @@ void arch_task_cache_init(void)
>  void exit_thread(void)
>  {
>  	struct task_struct *me = current;
> -	struct thread_struct *t = &me->thread;
> -	unsigned long *bp = t->io_bitmap_ptr;
> -
> -	if (bp) {
> -		struct tss_struct *tss = &per_cpu(init_tss, get_cpu());
> -
> -		t->io_bitmap_ptr = NULL;
> -		clear_thread_flag(TIF_IO_BITMAP);
> -		/*
> -		 * Careful, clear this in the TSS too:
> -		 */
> -		memset(tss->io_bitmap, 0xff, t->io_bitmap_max);
> -		t->io_bitmap_max = 0;
> -		put_cpu();
> -		kfree(bp);
> -	}
> -
> +	exit_thread_io(me);
>  	drop_fpu(me);
>  }
>  
> @@ -222,19 +208,7 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
>  			hard_enable_TSC();
>  	}
>  
> -	if (test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
> -		/*
> -		 * Copy the relevant range of the IO bitmap.
> -		 * Normally this is 128 bytes or less:
> -		 */
> -		memcpy(tss->io_bitmap, next->io_bitmap_ptr,
> -		       max(prev->io_bitmap_max, next->io_bitmap_max));
> -	} else if (test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)) {
> -		/*
> -		 * Clear any possible leftover bits:
> -		 */
> -		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
> -	}
> +	switch_io_bitmap(tss, prev_p, next_p);
>  	propagate_user_return_notify(prev_p, next_p);
>  }
>  
> diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
> index e86028b..dc780cb 100644
> --- a/arch/x86/kernel/process_32.c
> +++ b/arch/x86/kernel/process_32.c
> @@ -155,7 +155,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
>  		childregs->cs = __KERNEL_CS | get_kernel_rpl();
>  		childregs->flags = X86_EFLAGS_IF | X86_EFLAGS_FIXED;
>  		p->fpu_counter = 0;
> -		p->thread.io_bitmap_ptr = NULL;
> +		clear_thread_io_bitmap(p);
>  		memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
>  		return 0;
>  	}
> @@ -269,14 +269,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
>  	 */
>  	load_TLS(next, cpu);
>  
> -	/*
> -	 * Restore IOPL if needed.  In normal use, the flags restore
> -	 * in the switch assembly will handle this.  But if the kernel
> -	 * is running virtualized at a non-zero CPL, the popf will
> -	 * not restore flags, so it must be done in a separate step.
> -	 */
> -	if (get_kernel_rpl() && unlikely(prev->iopl != next->iopl))
> -		set_iopl_mask(next->iopl);
> +	switch_iopl_mask(prev, next);
>  
>  	/*
>  	 * Now maybe handle debug registers and/or IO bitmaps

If copy_thread would be in process.c instead, the .h-file would be unnecessary,
right?

> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index 7461f50..f071bfa 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -785,7 +785,11 @@ static int ptrace_set_debugreg(struct task_struct *tsk, int n,
>  static int ioperm_active(struct task_struct *target,
>  			 const struct user_regset *regset)
>  {
> +#ifdef CONFIG_X86_IOPORT
>  	return target->thread.io_bitmap_max / regset->size;
> +#else
> +	return 0;
> +#endif
>  }
>  
>  static int ioperm_get(struct task_struct *target,
> @@ -793,12 +797,16 @@ static int ioperm_get(struct task_struct *target,
>  		      unsigned int pos, unsigned int count,
>  		      void *kbuf, void __user *ubuf)
>  {
> +#ifdef CONFIG_X86_IOPORT
>  	if (!target->thread.io_bitmap_ptr)
>  		return -ENXIO;
>  
>  	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>  				   target->thread.io_bitmap_ptr,
>  				   0, IO_BITMAP_BYTES);
> +#else
> +	return -ENXIO;
> +#endif
>  }
>  
>  /*
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index fa6ade7..f485d92 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -911,6 +911,7 @@ static void xen_load_sp0(struct tss_struct *tss,
>  	xen_mc_issue(PARAVIRT_LAZY_CPU);
>  }
>  
> +#ifdef CONFIG_X86_IOPORT
>  static void xen_set_iopl_mask(unsigned mask)
>  {
>  	struct physdev_set_iopl set_iopl;
> @@ -919,6 +920,7 @@ static void xen_set_iopl_mask(unsigned mask)
>  	set_iopl.iopl = (mask == 0) ? 1 : (mask >> 12) & 3;
>  	HYPERVISOR_physdev_op(PHYSDEVOP_set_iopl, &set_iopl);
>  }
> +#endif /* CONFIG_X86_IOPORT */
>  
>  static void xen_io_delay(void)
>  {
> @@ -1277,7 +1279,9 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
>  	.write_idt_entry = xen_write_idt_entry,
>  	.load_sp0 = xen_load_sp0,
>  
> +#ifdef CONFIG_X86_IOPORT
>  	.set_iopl_mask = xen_set_iopl_mask,
> +#endif /* CONFIG_X86_IOPORT */
>  	.io_delay = xen_io_delay,
>  
>  	/* Xen takes care of %gs when switching to usermode for us */
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 2bd78e2..7c7d405 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -410,7 +410,7 @@ int vt_ioctl(struct tty_struct *tty,
>  		 *
>  		 * XXX: you should never use these, just call ioperm directly..
>  		 */
> -#ifdef CONFIG_X86
> +#ifdef CONFIG_X86_IOPORT
>  	case KDADDIO:
>  	case KDDELIO:
>  		/*
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 7078052..e7f4a35 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -209,3 +209,8 @@ cond_syscall(compat_sys_open_by_handle_at);
>  
>  /* compare kernel pointers */
>  cond_syscall(sys_kcmp);
> +
> +/* userspace I/O port access */
> +cond_syscall(stub_iopl);
> +cond_syscall(sys_iopl);
> +cond_syscall(sys_ioperm);
> -- 
> 1.8.4.rc3
> 
