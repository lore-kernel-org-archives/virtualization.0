Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39E34F278
	for <virtualization@lists.linux.dev>; Fri,  6 Feb 2026 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770369841; cv=none; b=MmHK3x2ZGHQxeCn5kxU7P1xcxGzL1J68oe88Gf2crpzktJ2nfNgWHCFjozrB8Naz7mCuCU4iXhPneavySwOo+BbdkDTJXZl2jBZif2UyRycVjbZf0rmB2mF7mYSbpBvDMjjHLSB+5nI5U232uLrvckgqbF5eoba7gmTxTlMYavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770369841; c=relaxed/simple;
	bh=/fkg3oWtZbf+Ill12UaORFsm14SxpgtZUZX+OeaDvMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5Uc2+TeaqW1DAMVlADhVAiGGCDp/ADEqdiXt6baGoF/OrL4pannFH2AXar6mK9nQNcs/x9hgFgWqRG+6q/5Lz0TB9jOky80nzWCPC4hthrjE0qFRHVjmQCi/cDRIDZRcyBdlN4DyoewjLC4Pi1V8yCexvmbBtr1ZyHqBxHnyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=UO01GlL8; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="UO01GlL8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1770369841; x=1801905841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPZfRdP+k5tHXCWNK6Ygu9GCntNiGeUU6L8G+KPNkCQ=;
  b=UO01GlL8+p6kdCa0z58rj/qZwEcJMQoQVlX6ajM8hS0scGQM8WytWSht
   RpR6uA2sch2fEwvWSSjKlADRJ4TD/SXkoX5c3JLYyyiml78J3DzlJ6qcq
   ZSQCYnjE7bolYUDVjXS8MhQ1Q4FYfI1DJ8ZkUboqp171tb3x309JEwRhR
   VnJh9p9GGYJQzQEYQrMZdb6dIZsrE3KBY7nSjYeaF3AuMmZiqGXdijaXb
   Ew2xvmZBFCBhe9TJI2mYl/KEZTGs51sT3GxeLGPfhp211zzKhv75J22IF
   4SFBgBJAKcIg2Jetosk/zUiv1JjpheSuIHfFVHTgXIHP47u5v8Z3ryka6
   Q==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 18:24:00 +0900
X-IronPort-AV: E=Sophos;i="6.21,276,1763391600"; 
   d="scan'208";a="578889420"
Received: from unknown (HELO JPC00244420) ([IPv6:2001:cf8:1:573:0:dddd:6b3e:119e])
  by jpmta-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 18:23:56 +0900
Date: Fri, 6 Feb 2026 18:23:53 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, jailhouse-dev@googlegroups.com,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
	Rahul Bukte <rahul.bukte@sony.com>,
	Daniel Palmer <daniel.palmer@sony.com>,
	Tim Bird <tim.bird@sony.com>
Subject: Re: [PATCH 3/3] x86/virt: rename x2apic_available to
 x2apic_without_ir_available
Message-ID: <aYWzKQQTyTZpMAme@JPC00244420>
References: <20260202-x2apic-fix-v1-0-71c8f488a88b@sony.com>
 <20260202-x2apic-fix-v1-3-71c8f488a88b@sony.com>
 <ab7f5935-fd5e-4ba5-a97d-5433f241a089@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab7f5935-fd5e-4ba5-a97d-5433f241a089@intel.com>

On Thu, Feb 05, 2026 at 04:10:37PM -0800, Sohil Mehta wrote:
> On 2/2/2026 1:51 AM, Shashank Balaji wrote:
> > No functional change.
> > 
> > x86_init.hyper.x2apic_available is used only in try_to_enable_x2apic to check if
> > x2apic needs to be disabled if interrupt remapping support isn't present. But
> > the name x2apic_available doesn't reflect that usage.
> > 
> 
> I don't understand the premise of this patch. Shouldn't the variable
> name reflect what is stored rather than how it is used?

Sorry about the confusion, I should have used '()'.
x86_init.hyper.x2apic_available() is called only in
try_to_enable_x2apic(). Here's the relevant snippet:

	static __init void try_to_enable_x2apic(int remap_mode)
	{
		if (x2apic_state == X2APIC_DISABLED)
			return;

		if (remap_mode != IRQ_REMAP_X2APIC_MODE) {
			u32 apic_limit = 255;

			/*
			 * Using X2APIC without IR is not architecturally supported
			 * on bare metal but may be supported in guests.
			 */
			if (!x86_init.hyper.x2apic_available()) {
				pr_info("x2apic: IRQ remapping doesn't support X2APIC mode\n");
				x2apic_disable();
				return;
			}

So the question being asked is, "can x2apic be used without IR?", but
the name "x2apic_available" signals "is x2apic available?". I found this
confusing while going through the source.

Most hypervisors set their x2apic_available() implementation to
essentially return if the CPU supports x2apic or not, which is valid
given the name "x2apic_available", but x2apic availability is not what's in
question at the callsite.

> > This is what x2apic_available is set to for various hypervisors:
> > 
> > 	acrn		boot_cpu_has(X86_FEATURE_X2APIC)
> > 	mshyperv	boot_cpu_has(X86_FEATURE_X2APIC)
> > 	xen		boot_cpu_has(X86_FEATURE_X2APIC) or false
> > 	vmware		vmware_legacy_x2apic_available
> > 	kvm		kvm_cpuid_base() != 0
> > 	jailhouse	x2apic_enabled()
> > 	bhyve		true
> > 	default		false
> > 
> 
> If both interrupt remapping and x2apic are enabled, what would the name
> x2apic_without_ir_available signify?

If IR is enabled, then the branch to call x2apic_available() wouldn't be taken :)
So the meaning of x2apic_without_ir_available wouldn't be relevant
anymore.

> A value of "true" would mean x2apic is available without IR. But that
> would be inaccurate for most hypervisors. A value of "false" could be
> interpreted as x2apic is not available, which is also inaccurate.
> 
> To me, x2apic_available makes more sense than
> x2apic_without_ir_available based on the values being set by the
> hypervisors.
 
I agree with you, and I think therein lies the problem. Most hypervisors
are answering the broader question "is x2apic available?", so the name
"x2apic_available" makes sense.

I think further work is required to check if various implementations of
x2apic_available() also need to be changed to reflect the "x2apic
without IR?" semantic, but I don't know enough to do that myself. Maybe
I should have added TODOs above the implementations.

I would like the feedback of the virt folks too on all this, maybe I'm
misinterpreting what's going on here.

> > Bare metal and vmware correctly check if x2apic is available without interrupt
> > remapping. The rest of them check if x2apic is enabled/supported, and kvm just
> > checks if the kernel is running on kvm. The other hypervisors may have to have
> > their checks audited.
> > 
> AFAIU, the value on bare metal is set to false because this is a
> hypervisor specific variable. Perhaps I have misunderstood something?
