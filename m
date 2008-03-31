From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC/PATCH 05/15 v3] kvm-s390: s390 arch backend for the kvm
	kernel module
Date: Mon, 31 Mar 2008 07:36:56 +0200
Message-ID: <200803310736.58001.arnd__32052.3610957482$1206942098$gmane$org@arndb.de>
References: <1206030270.6690.51.camel@cotte.boeblingen.de.ibm.com>
	<1206458154.6217.12.camel@cotte.boeblingen.de.ibm.com>
	<1206467240.6507.41.camel@cotte.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1206467240.6507.41.camel@cotte.boeblingen.de.ibm.com>
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
To: Carsten Otte <cotte@de.ibm.com>
Cc: aliguori@us.ibm.com, EHRHARDT@de.ibm.com, hollisb@us.ibm.com, kvm-devel@lists.sourceforge.net, heiko.carstens@de.ibm.com, jeroney@us.ibm.com, virtualization@lists.linux-foundation.org, borntraeger@de.ibm.com, oliver.paukstadt@millenux.com, schwidefsky@de.ibm.com, rvdheij@gmail.com, os@de.ibm.com, jblunck@suse.de, "Zhang, Xiantao" <xiantao.zhang@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tuesday 25 March 2008, Carsten Otte wrote:

> +
> +static inline void __user *__guestaddr_to_user(struct kvm_vcpu *vcpu,
> +					       u64 guestaddr)
> +{
> +	u64 prefix  = vcpu->arch.sie_block->prefix;
> +	u64 origin  = vcpu->kvm->arch.guest_origin;
> +	u64 memsize = vcpu->kvm->arch.guest_memsize;
> +
> +	if (guestaddr < 2 * PAGE_SIZE)
> +		guestaddr += prefix;
> +	else if ((guestaddr >= prefix) && (guestaddr < prefix + 2 * PAGE_SIZE))
> +		guestaddr -= prefix;

What happens if prefix is set to 4096? Does this do the right thing
according to the architecture definition?

> +	if (guestaddr & 7)
> +		BUG();

BUG_ON(guestaddr & 7);

same for the others.

> +static inline int copy_to_guest(struct kvm_vcpu *vcpu, u64 guestdest,
> +				const void *from, unsigned long n)
> +{
> +	u64 prefix  = vcpu->arch.sie_block->prefix;
> +	u64 origin  = vcpu->kvm->arch.guest_origin;
> +	u64 memsize = vcpu->kvm->arch.guest_memsize;
> +
> +	if ((guestdest < 2 * PAGE_SIZE) && (guestdest + n > 2 * PAGE_SIZE))
> +		goto slowpath;
> +
> +	if ((guestdest < prefix) && (guestdest + n > prefix))
> +		goto slowpath;
> +
> +	if ((guestdest < prefix + 2 * PAGE_SIZE)
> +	    && (guestdest + n > prefix + 2 * PAGE_SIZE))
> +		goto slowpath;
> +
> +	if (guestdest < 2 * PAGE_SIZE)
> +		guestdest += prefix;
> +	else if ((guestdest >= prefix) && (guestdest < prefix + 2 * PAGE_SIZE))
> +		guestdest -= prefix;
> +
> +	if (guestdest + n > memsize)
> +		return -EFAULT;
> +
> +	if (guestdest + n < guestdest)
> +		return -EFAULT;
> +
> +	guestdest += origin;
> +
> +	return copy_to_user((void __user *) guestdest, from, n);
> +slowpath:
> +	return __copy_to_guest_slow(vcpu, guestdest, from, n);
> +}

I assume that the call to copy_to_user is performance critical. Therefore, I'd
reorder the code to handle the common case inline:

extern inline int __copy_to_guest(u64 guestdest, const void *from, unsigned long n,
				unsigned long origin, unsigned long prefix);

static inline int copy_to_guest(struct kvm_vcpu *vcpu, u64 guestdest,
				const void *from, unsigned long n)
{
	u64 prefix  = vcpu->arch.sie_block->prefix;
	u64 origin  = vcpu->kvm->arch.guest_origin;
	u64 memsize = vcpu->kvm->arch.guest_memsize;

	if (n <= 0 || (guestdest + n > memsize))
		return -EFAULT;

	if (guestdest >= prefix + 2 * PAGE_SIZE) ||
           ((guestdest >= 2 * PAGE_SIZE) && (guestdest + n < prefix)))
		/* no translation needed */
		return copy_to_user((void __user *) guestdest + origin, from, n);
	else
		/* target needs to be translated */
		return __copy_to_guest(guestdest, from, n, origin, prefix);

This should make the inline version shorter and faster and keep most
of the interesting bits out-of-line.

> +	try_module_get(THIS_MODULE);

Shouldn't you check the return value of this?

> +static int __guestcopy(struct kvm_vcpu *vcpu, u64 guestdest, const void *from,
> +		       unsigned long n, int prefix)
> +{
> +	if (prefix)
> +		return copy_to_guest(vcpu, guestdest, from, n);
> +	else
> +		return copy_to_guest_absolute(vcpu, guestdest, from, n);
> +}

If you pass the vcpu->prefix or 0 in the prefix argument, you can always
call __copy_to_guest() directly.

> Index: linux-host/arch/s390/kvm/sie64a.S
> ===================================================================
> --- /dev/null
> +++ linux-host/arch/s390/kvm/sie64a.S
> @@ -0,0 +1,47 @@
> +/*
> + * sie64a.S - low level sie call
> + *
> + * Copyright IBM Corp. 2008

I would guess that this file has some bits in it that are older than
2008. How about

	Copyright IBM Corp. 2004-2008

> +
> +SP_R5 =	5 * 8	# offset into stackframe
> +SP_R6 =	6 * 8
> +
> +/*
> + * sie64a calling convention:
> + * %r2 pointer to sie control block
> + * %r3 guest register save area
> + */
> +	.globl	sie64a
> +sie64a:
> +	lgr	%r5,%r3
> +	stmg	%r5,%r14,SP_R5(%r15)	# save register on entry
> +	lgr	%r14,%r2		# pointer to sie control block
> +	lmg	%r0,%r13,0(%r3)		# load guest gprs 0-13
> +sie_inst:
> +	sie	0(%r14)
> +	lg	%r14,SP_R5(%r15)
> +	stmg	%r0,%r13,0(%r14)	# save guest gprs 0-13
> +	lghi	%r2,0
> +	lmg	%r6,%r14,SP_R6(%r15)
> +	br	%r14
> +
> +sie_err:
> +	lg	%r14,SP_R5(%r15)
> +	stmg	%r0,%r13,0(%r14)	# save guest gprs 0-13
> +	lghi	%r2,-EFAULT
> +	lmg	%r6,%r14,SP_R6(%r15)
> +	br	%r14
> +
> +	.section __ex_table,"a"
> +	.quad	sie_inst,sie_err
> +	.previous

EFAULT looks a bit too specific here, maybe EINVAL would be better?


> +/* for KVM_GET_REGS and KVM_SET_REGS */
> +struct kvm_regs {
> +	/* general purpose regs for s390 */
> +	__u64 gprs[16];
> +};
> +
> +/* for KVM_GET_SREGS and KVM_SET_SREGS */
> +struct kvm_sregs {
> +	__u32 acrs[16];
> +	__u64 crs[16];
> +};

Shouldn't that contain the PSW as well? Or is the PSW part of the
16 CRS?

> +/* for KVM_GET_FPU and KVM_SET_FPU */
> +struct kvm_fpu {
> +	__u32 fpc;
> +	__u64 fprs[16];
> +};

What about decimal floating point, does that use the same registers?

	Arnd <><
