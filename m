From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 25/25] [PATCH] add paravirtualization support for x86_64
Date: Wed, 8 Aug 2007 12:00:12 +0200
Message-ID: <200708081200.13669.ak__6101.04336306012$1186567919$gmane$org@suse.de>
References: <11865467522495-git-send-email-gcosta@redhat.com>
	<1186546847263-git-send-email-gcosta@redhat.com>
	<11865468513077-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11865468513077-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, anthony@codemonkey.ws, akpm@linux-foundation.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org


> +config PARAVIRT
> +       bool "Paravirtualization support (EXPERIMENTAL)"

This should be hidden and selected by the clients as needed
(I already did this change on i386) 

Users know nothing about paravirt, they just know about Xen, lguest
etc.

Strictly you would at least need a !X86_VSMP dependency, but
with the vsmp change i requested that will be unnecessary

Is this really synced with the latest version of the i386 code?


> +#ifdef CONFIG_PARAVIRT
> +#include <asm/paravirt.h>
> +#endif


> +#include <linux/errno.h>
> +#include <linux/module.h>
> +#include <linux/efi.h>
> +#include <linux/bcd.h>
> +#include <linux/start_kernel.h>
> +
> +#include <asm/bug.h>
> +#include <asm/paravirt.h>
> +#include <asm/desc.h>
> +#include <asm/setup.h>
> +#include <asm/irq.h>
> +#include <asm/delay.h>
> +#include <asm/fixmap.h>
> +#include <asm/apic.h>
> +#include <asm/tlbflush.h>
> +#include <asm/msr.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/proto.h>
> +#include <asm/e820.h>
> +#include <asm/time.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/smp.h>
> +#include <asm/irqflags.h>


Are the includes really all needed?


> +	if (opfunc == NULL)
> +		/* If there's no function, patch it with a ud2a (BUG) */
> +		ret = paravirt_patch_insns(site, len, start_ud2a, end_ud2a);

This will actually give corrupted BUGs because you don't supply
the full inline BUG header. Perhaps another trap would be better.


> +EXPORT_SYMBOL(paravirt_ops);

Definitely _GPL at least.



> +extern struct paravirt_ops paravirt_ops;

Should be native_paravirt_ops I guess

> +
> + * This generates an indirect call based on the operation type number.

The macros here don't

> +static inline unsigned long read_msr(unsigned int msr)
> +{
> +	int __err;

No need for __ in inlines

> +/* The paravirtualized I/O functions */
> +static inline void slow_down_io(void) {

I doubt this needs to be inline and it's large

> +	__asm__ __volatile__(paravirt_alt(PARAVIRT_CALL)

No __*__ in new code please

> +			     : "=a"(f)
> +			     : paravirt_type(save_fl),
> +			       paravirt_clobber(CLBR_RAX)
> +			     : "memory", "cc");
> +	return f;
> +}
> +
> +static inline void raw_local_irq_restore(unsigned long f)
> +{
> +	__asm__ __volatile__(paravirt_alt(PARAVIRT_CALL)
> +			     :
> +			     : "D" (f),

Have you investigated if a different input register generates better/smaller 
code? I would assume rdi to be usually used already for the caller's 
arguments so it will produce spilling

Similar for the rax return in the other functions.



-Andi
