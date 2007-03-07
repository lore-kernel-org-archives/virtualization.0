From: Dan Hecht <dhecht@vmware.com>
Subject: Re: + stupid-hack-to-make-mainline-build.patch added to -mm tree
Date: Wed, 07 Mar 2007 15:52:41 -0800
Message-ID: <45EF5049.3060902@vmware.com>
References: <200703060654.l266sVxr014860@shell0.pdx.osdl.net>	 <45ED16D2.3000202@vmware.com> <20070306084258.GA15745@elte.hu>	 <20070306084647.GA16280@elte.hu> <45ED2C82.3080008@vmware.com>	 <1173178774.24738.311.camel@localhost.localdomain>	 <45EDD82F.90204@vmware.com>	 <1173225182.24738.507.camel@localhost.localdomain>	 <45EE0628.1080108@goop.org> <45EE08E8.2020008@vmware.com>	 <1173228544.24738.514.camel@localhost.localdomain>	 <45EE0D10.7070807@vmware.com>	 <1173230305.24738.529.camel@localhost.localdomain>	 <45EE1EA3.90803@vmware.com>	 <1173256666.24738.576.camel@localhost.localdomain>	 <45EEF966.6060902@goop.org>	<Line.LNX.4.64.0703071304080.1851@d.namei>	 <45EF0CF5.5090305@goop.org>  <45EF175D.6030609@vmware.com>	 <1173302503.24738.795.camel@localhost.localdomain>	 <45EF372E.7030600@goop.org> <1173308717.24738.898.camel@localhost.localdomain> <45EF4BD7.7060400@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S2992776AbXCGX5I@vger.kernel.org>
In-Reply-To: <45EF4BD7.7060400@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: tglx@linutronix.de, James Morris <jmorris@namei.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, akpm@linux-foundation.org, john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Dan Hecht <dhecht@vmware.com>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 03/07/2007 03:33 PM, Jeremy Fitzhardinge wrote:
> I know the vmi time code has coloured your view here, but I surely hope
> it can be got into a better state before posting.  I'm biased of course,
> but I would rather hope that all these drivers we're talking about will
> be as stylistically clean as the Xen time code (which has room for
> improvement, of course).
> 

Could you send us comments on where you feel the style needs some fixing 
up?

VMI encapsulates all the implementation details away from the kernel, 
whereas the Xen time code puts it all out there in the kernel (see 
snippet below).  What happens when Xen wants to change the way it 
implements "system time"?  It looses compatibility with all existing 
kernels....

In VMI terms, the code to read "system time" from the hypervisor is this 
one-liner (it can be written in any "style" you want; the fact is, it's 
just an interface call to the VMI-layer):

vmi_timer_ops.get_cycle_counter(VMI_CYCLES_REAL);

In Xen terms, the same code to accomplish that is:

/*
  * Scale a 64-bit delta by scaling and multiplying by a 32-bit fraction,
  * yielding a 64-bit result.
  */
static inline u64 scale_delta(u64 delta, u32 mul_frac, int shift)
{
	u64 product;
#ifdef __i386__
	u32 tmp1, tmp2;
#endif

	if (shift < 0)
		delta >>= -shift;
	else
		delta <<= shift;

#ifdef __i386__
	__asm__ (
		"mul  %5       ; "
		"mov  %4,%%eax ; "
		"mov  %%edx,%4 ; "
		"mul  %5       ; "
		"xor  %5,%5    ; "
		"add  %4,%%eax ; "
		"adc  %5,%%edx ; "
		: "=A" (product), "=r" (tmp1), "=r" (tmp2)
		: "a" ((u32)delta), "1" ((u32)(delta >> 32)), "2" (mul_frac) );
#elif __x86_64__
	__asm__ (
		"mul %%rdx ; shrd $32,%%rdx,%%rax"
		: "=a" (product) : "0" (delta), "d" ((u64)mul_frac) );
#else
#error implement me!
#endif

	return product;
}

static u64 get_nsec_offset(struct shadow_time_info *shadow)
{
	u64 now, delta;
	rdtscll(now);
	delta = now - shadow->tsc_timestamp;
	return scale_delta(delta, shadow->tsc_to_nsec_mul, shadow->tsc_shift);
}

static cycle_t xen_clocksource_read(void)
{
	struct shadow_time_info *shadow = &get_cpu_var(shadow_time);
	cycle_t ret;

	get_time_values_from_xen();

	ret = shadow->system_timestamp + get_nsec_offset(shadow);

	put_cpu_var(shadow_time);

	return ret;
}
