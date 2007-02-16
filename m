From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 10/21] Xen-paravirt: add hooks to intercept mm creation
	and destruction
Date: Thu, 15 Feb 2007 22:34:09 -0800
Message-ID: <20070215223409.eea8f1e3.akpm@linux-foundation.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.267584466@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070216022531.267584466@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 15 Feb 2007 18:24:59 -0800 Jeremy Fitzhardinge <jeremy@goop.org> wr=
ote:

> Add hooks to allow a paravirt implementation to track the lifetime of
> an mm.
> =

> --- a/arch/i386/kernel/paravirt.c
> +++ b/arch/i386/kernel/paravirt.c
> @@ -706,6 +706,10 @@ struct paravirt_ops paravirt_ops =3D {
>  	.irq_enable_sysexit =3D native_irq_enable_sysexit,
>  	.iret =3D native_iret,
>  =

> +	.dup_mmap =3D (void *)native_nop,
> +	.exit_mmap =3D (void *)native_nop,
> +	.activate_mm =3D (void *)native_nop,
> +
>  	.startup_ipi_hook =3D (void *)native_nop,
>  };

eww.  I suppose there's a good reason for the casting.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/include/asm-i386/mmu_context.h
> +++ b/include/asm-i386/mmu_context.h
> @@ -5,6 +5,7 @@
>  #include <asm/atomic.h>
>  #include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
> +#include <asm/paravirt.h>
>  =

>  /*
>   * Used for LDT copy/destruction.
> @@ -65,7 +66,10 @@ static inline void switch_mm(struct mm_s
>  #define deactivate_mm(tsk, mm)			\
>  	asm("movl %0,%%gs": :"r" (0));
>  =

> -#define activate_mm(prev, next) \
> -	switch_mm((prev),(next),NULL)
> +#define activate_mm(prev, next)				\
> +	do {						\
> +		arch_activate_mm(prev, next);		\
> +		switch_mm((prev),(next),NULL);		\
> +	} while(0);

It seems strange to call out to arch_foo() from within an arch header file.
I mean, we implicity know we're i386.

Maybe it's just poorly named.

> +static inline void paravirt_activate_mm(struct mm_struct *prev,
> +					struct mm_struct *next)
> +{
> +}
> +
> +static inline void paravirt_dup_mmap(struct mm_struct *oldmm,
> +				     struct mm_struct *mm)
> +{
> +}
> +
> +static inline void paravirt_exit_mmap(struct mm_struct *mm)
> +{
> +}

These functions are unreferenced in this patchset.

>  #endif /* CONFIG_PARAVIRT */
>  #endif	/* __ASM_PARAVIRT_H */
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -374,6 +374,12 @@ struct mm_struct {
>  	rwlock_t		ioctx_list_lock;
>  	struct kioctx		*ioctx_list;
>  };
> +
> +#ifndef __HAVE_ARCH_MM_LIFETIME
> +#define arch_activate_mm(prev, next)	do {} while(0)
> +#define arch_dup_mmap(oldmm, mm)	do {} while(0)
> +#define arch_exit_mmap(mm)		do {} while(0)
> +#endif

Can we lose __HAVE_ARCH_MM_LIFETIME?  Just define these (preferably in C,
not in cpp) in the appropriate include/asm-foo/ files?

>  struct sighand_struct {
>  	atomic_t		count;
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -286,6 +286,7 @@ static inline int dup_mmap(struct mm_str
>  		if (retval)
>  			goto out;
>  	}
> +	arch_dup_mmap(oldmm, mm);
>  	retval =3D 0;
>  out:
>  	up_write(&mm->mmap_sem);
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1976,6 +1976,8 @@ void exit_mmap(struct mm_struct *mm)
>  	struct vm_area_struct *vma =3D mm->mmap;
>  	unsigned long nr_accounted =3D 0;
>  	unsigned long end;
> +
> +	arch_exit_mmap(mm);
>  =

>  	lru_add_drain();
>  	flush_cache_mm(mm);

Perhaps some commentary telling the arch maintainer what these hooks he's
being offered are for?
