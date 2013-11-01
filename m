From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 3/3] x86: Support compiling out userspace I/O (iopl and
	ioperm)
Date: Fri, 1 Nov 2013 10:19:12 -0700
Message-ID: <20131101171911.GA1122@leaf>
References: <cover.1382407802.git.josh@joshtriplett.org>
	<c6432a64f977031b3d1cf0df1d292c3808faf166.1382407802.git.josh@joshtriplett.org>
	<1383249882.6635.41326997.4D0EF91B@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1383249882.6635.41326997.4D0EF91B@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, x86@kernel.org, Len Brown <len.brown@intel.com>, Frederic Weisbecker <fweisbec@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, virtualization@lists.linux-foundation.org, Paul Gortmaker <paul.gortmaker@windriver.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Herrmann <dh.herrmann@gmail.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Seiji Aguchi <seiji.aguchi@hds.com>, Jiri Slaby <jslaby@suse.cz>, Alok Kataria <akataria@vmware.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Andi Kleen <ak@linux.intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, xen-devel@lists.xenproject.org, Borislav Petkov <bp@suse.de>, Fenghua Yu <fenghua.yu@intel.com>, Kees Cook <keescook@chromium.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Ross
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 31, 2013 at 09:04:42PM +0100, Alexander van Heukelum wrote:
> On Tue, Oct 22, 2013, at 3:35, Josh Triplett wrote:
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -976,6 +976,16 @@ config VM86
> >  	  XFree86 to initialize some video cards via BIOS. Disabling this
> >  	  option saves about 6k.
> >  
> > +config X86_IOPORT
> > +	bool "iopl and ioperm system calls"
> > +	default y
> > +	---help---
> > +	  This option enables the iopl and ioperm system calls, which allow
> > +	  privileged userspace processes to directly access I/O ports. This
> > +	  is used by some legacy software to drive hardware directly from
> > +	  userspace rather than via a proper kernel driver. Unless you intend
> > +	  to run such software, you can safely say N here.
> > +
> 
> I think this entry should be under General setup / Configure standard kernel
> features (expert users).

It's entirely x86-specific, and it's similar to VM86 just above it; it
belongs on the x86-specific menu.

> Remove references to "legacy" and "proper driver".

Hardware drivers belong in the kernel, and anything using iopl or ioperm
won't run on x86-64, which argues rather strongly for its obsolescence.
There's also /dev/port for cleaner access to ports from userspace.
However, I've rephrased this for v2.

> > --- a/arch/x86/kernel/cpu/common.c
> > +++ b/arch/x86/kernel/cpu/common.c
> > @@ -1223,7 +1223,6 @@ void cpu_init(void)
> >  	struct tss_struct *t;
> >  	unsigned long v;
> >  	int cpu;
> > -	int i;
> >  
> >  	/*
> >  	 * Load microcode on this cpu if a valid microcode is available.
> > @@ -1285,14 +1284,7 @@ void cpu_init(void)
> >  		}
> >  	}
> >  
> > -	t->x86_tss.io_bitmap_base = offsetof(struct tss_struct, io_bitmap);
> > -
> > -	/*
> > -	 * <= is required because the CPU will access up to
> > -	 * 8 bits beyond the end of the IO permission bitmap.
> > -	 */
> > -	for (i = 0; i <= IO_BITMAP_LONGS; i++)
> > -		t->io_bitmap[i] = ~0UL;
> > +	init_tss_io(t);
> >  
> >  	atomic_inc(&init_mm.mm_count);
> >  	me->active_mm = &init_mm;
> > @@ -1351,7 +1343,7 @@ void cpu_init(void)
> >  	load_TR_desc();
> >  	load_LDT(&init_mm.context);
> >  
> > -	t->x86_tss.io_bitmap_base = offsetof(struct tss_struct, io_bitmap);
> > +	init_tss_io(t);
> 
> This patch is too big. I think it would all look nicer if you added ioport.c in
> one patch, and then convert the users in a separate patch?

I'm not sure what you mean by "added ioport.c"; ioport.c already exists,
and this patch just makes it optional.

> > --- a/arch/x86/kernel/process-io.h
> > +++ b/arch/x86/kernel/process-io.h
> > @@ -1,9 +1,17 @@
> >  #ifndef _X86_KERNEL_PROCESS_IO_H
> >  #define _X86_KERNEL_PROCESS_IO_H
> >  
> > +static inline void clear_thread_io_bitmap(struct task_struct *p)
> > +{
> > +#ifdef CONFIG_X86_IOPORT
> > +	p->thread.io_bitmap_ptr = NULL;
> > +#endif /* CONFIG_X86_IOPORT */
> > +}
> > +
> 
> This is thought of as ugly... Instead, do something like
> 
> #ifndef CONFIG_X86_IOPORT
> 
> static inline void clear_thread_io_bitmap(struct task_struct *p) {}
> static inline int copy_io_bitmap(struct task_struct *me, struct task_struct *p) {return 0}
> ... etc...
> 
> #else
> 
> static inline void clear_thread_io_bitmap(struct task_struct *p)
> {
>    p->thread.io_bitmap_ptr = NULL;
> }
> ... etc...
> 
> #endif

In .c files, any ifdefs at all are ugly; in .h files, both styles are
quite common, and in particular the style I used is common when omitting
the entire body of the function.  It has the advantage of keeping a
common function signature rather than duplicating it.

> > --- a/arch/x86/kernel/process_32.c
> > +++ b/arch/x86/kernel/process_32.c
> > @@ -155,7 +155,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp,
> >  		childregs->cs = __KERNEL_CS | get_kernel_rpl();
> >  		childregs->flags = X86_EFLAGS_IF | X86_EFLAGS_FIXED;
> >  		p->fpu_counter = 0;
> > -		p->thread.io_bitmap_ptr = NULL;
> > +		clear_thread_io_bitmap(p);
> >  		memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
> >  		return 0;
> >  	}
> > @@ -269,14 +269,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
> >  	 */
> >  	load_TLS(next, cpu);
> >  
> > -	/*
> > -	 * Restore IOPL if needed.  In normal use, the flags restore
> > -	 * in the switch assembly will handle this.  But if the kernel
> > -	 * is running virtualized at a non-zero CPL, the popf will
> > -	 * not restore flags, so it must be done in a separate step.
> > -	 */
> > -	if (get_kernel_rpl() && unlikely(prev->iopl != next->iopl))
> > -		set_iopl_mask(next->iopl);
> > +	switch_iopl_mask(prev, next);
> >  
> >  	/*
> >  	 * Now maybe handle debug registers and/or IO bitmaps
> 
> If copy_thread would be in process.c instead, the .h-file would be unnecessary,
> right?

No, there are calls to the new functions in the .h file in several other
places.

- Josh Triplett
