Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81202580E4
	for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204514; cv=none; b=OzHg0r+5gUOURNEaOYy88W5t4QHmhuoTnkn6tROSb3D6xhBdgts9P/TtWJD00nrQ16tPwqpBRSRdZHaAmnwx59TvkCkRU1c9wGwsSDj5YJADvANKdCxRBZGseBm5EOGgAG13z93EOYA5ACxL+9E/3vyHB8BDSJuKgjuqMnat55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204514; c=relaxed/simple;
	bh=F1uW5ma3fdeyn5aBjyxZoVhGgZVM2t/lrZtQqYD9Oew=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=paKKqaPekYby0JbSQzeFsWuEm0fxDN6yv7ozW4W4T+wiDg1ceBBzlcZN+7SK7ZhtKfL/+KfqPuLeXYxvTEHhkPVt1yo6K1tSeq/zRa164EZ5oznLof2IjUe5SAe/0dYZT3j547sO9Nnbo9CACzvRDX+jVYmQ3DP4UmSxhosILz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KCfAsL2B; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KCfAsL2B"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso14860218a91.2
        for <virtualization@lists.linux.dev>; Mon, 10 Feb 2025 08:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739204511; x=1739809311; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gjevNOj/bkd1TGaPwATIjylcH4KclWeK6tRAdAb+PbI=;
        b=KCfAsL2B8oB94cuDJOZ8k5SnTsT6Q7UZwkTaP4LsWEyIlfCCf2PDhSFUhTJJ1Fh2TR
         BRYpucCn9uuzStaG7Bf1zNd4F7Y3CjBPw4j6Z2IZDOSyDg0AJbztQQjDYuLAhw/dOB4j
         OtOSgB93SSxyBoFhUj1ZFxpMlpInc5tTFzsZtD/RKOxQ9ARsovW7JLtN+/i75eq64b6L
         JQY3bT3l4ychKLt/QroJ2PSe99OSsgGzAf+dmdjX7533ZwCSyEUGL+ELhkB2wJLINd/w
         sxM4J6kNgBsYxaLRCS0PzfETyyP3Zp2wM2BpYwMk7YHd2PtYbctmzubVZyhaKnixj1GF
         i7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739204511; x=1739809311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjevNOj/bkd1TGaPwATIjylcH4KclWeK6tRAdAb+PbI=;
        b=mu6Lcgd0BrBz502/I7Q6N0zboUL834QUKIxtQ68nafLq/361oT4UfD2aRzYRgc3gAX
         8wmolIwz213jlKo1nCpzJKuVghMgq1lZ2MJ6cKNP1S0FoCI5PVbrb+KRfaIPuVgTxkid
         Y+DPRONmKSQx32mRA3lUUOlE3bAA5dx4vfLYMzeS4GXx0NGn7dw2ajH4fWEXdxqPtg7n
         2cw4QRzxBkRgZWyW6rnUzevMcDopwxNw6qsJuEs8bvw/iqvcn44H5H9vCARTKZljYC6i
         cUFdghyYpzvmcBZOzEYGjdTe1DMDacydBYHy6odibp0gkw94uJTdnzGWaHW1phBmxBjE
         aJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWbTzl3sa2FqaW4TvrYQTu0a6daYdhiO2XN9A3UODYhBrwhOZpYhfz5Ry7nO5aJpQr72elagwSWzQn5OjSyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPOKRuwVyZPzvxhCoMD69ZmUymEM+9TkvJlpOKYyawc6ssCyQ9
	xNKHOYkiGl7kye8paqESqB/1815tAf2PMtLOgfUtaMVXB1MGvfOI8yfKsXvsNRr/mmWiiu6fz58
	59g==
X-Google-Smtp-Source: AGHT+IHvA6NXtBXVEFbtZeSWagFJPoake9uFGdSEz34GpfES659xPG5GoxHcGoeeTGEESr/Dcqf76t3tOTs=
X-Received: from pjbsp15.prod.google.com ([2002:a17:90b:52cf:b0:2ee:53fe:d0fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4cd1:b0:2fa:b84:b304
 with SMTP id 98e67ed59e1d1-2fa243db921mr18907344a91.22.1739204511253; Mon, 10
 Feb 2025 08:21:51 -0800 (PST)
Date: Mon, 10 Feb 2025 08:21:49 -0800
In-Reply-To: <SN6PR02MB4157A85EC0B1B2D45CB611FAD4F02@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com> <20250201021718.699411-17-seanjc@google.com>
 <Z6ZBjNdoULymGgxz@google.com> <SN6PR02MB4157A85EC0B1B2D45CB611FAD4F02@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <Z6onnUthSBUVAklf@google.com>
Subject: Re: [PATCH 16/16] x86/kvmclock: Use TSC for sched_clock if it's
 constant and non-stop
From: Sean Christopherson <seanjc@google.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Nikunj A Dadhania <nikunj@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Feb 08, 2025, Michael Kelley wrote:
> From: Sean Christopherson <seanjc@google.com> Sent: Friday, February 7, 2025 9:23 AM
> > 
> > Dropping a few people/lists whose emails are bouncing.
> > 
> > On Fri, Jan 31, 2025, Sean Christopherson wrote:
> > > @@ -369,6 +369,11 @@ void __init kvmclock_init(void)
> > >  #ifdef CONFIG_X86_LOCAL_APIC
> > >  	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
> > >  #endif
> > > +	/*
> > > +	 * Save/restore "sched" clock state even if kvmclock isn't being used
> > > +	 * for sched_clock, as kvmclock is still used for wallclock and relies
> > > +	 * on these hooks to re-enable kvmclock after suspend+resume.
> > 
> > This is wrong, wallclock is a different MSR entirely.
> > 
> > > +	 */
> > >  	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
> > >  	x86_platform.restore_sched_clock_state = kvm_restore_sched_clock_state;
> > 
> > And usurping sched_clock save/restore is *really* wrong if kvmclock isn't being
> > used as sched_clock, because when TSC is reset on suspend/hiberation, not doing
> > tsc_{save,restore}_sched_clock_state() results in time going haywire.
> > 
> > Subtly, that issue goes all the way back to patch "x86/paravirt: Don't use a PV
> > sched_clock in CoCo guests with trusted TSC" because pulling the rug out from
> > under kvmclock leads to the same problem.
> > 
> > The whole PV sched_clock scheme is a disaster.
> > 
> > Hyper-V overrides the save/restore callbacks, but _also_ runs the old TSC callbacks,
> > because Hyper-V doesn't ensure that it's actually using the Hyper-V clock for
> > sched_clock.  And the code is all kinds of funky, because it tries to keep the
> > x86 code isolated from the generic HV clock code, but (a) there's already x86 PV
> > specific code in drivers/clocksource/hyperv_timer.c, and (b) splitting the code
> > means that Hyper-V overides the sched_clock save/restore hooks even when
> > PARAVIRT=n, i.e. when HV clock can't possibly be used as sched_clock.
> 
> Regarding (a), the one occurrence of x86 PV-specific code hyperv_timer.c is
> the call to paravirt_set_sched_clock(), and it's under an #ifdef sequence so that
> it's not built if targeting some other architecture. Or do you see something else
> that is x86-specific?
> 
> Regarding (b), in drivers/hv/Kconfig, CONFIG_HYPERV always selects PARAVIRT.
> So the #else clause (where PARAVIRT=n) in that #ifdef sequence could arguably
> have a BUILD_BUG() added. If I recall correctly, other Hyper-V stuff breaks if
> PARAVIRT is forced to "n". So I don't think there's a current problem with the
> sched_clock save/restore hooks. i

Oh, there are no build issues, and all of the x86 bits are nicely cordoned off.
My complaint is essentially that they're _too_ isolated; putting the sched_clock
save/restore setup in arch/x86/kernel/cpu/mshyperv.c is well-intentioned, but IMO
it does more harm than good because the split makes it difficult to connect the
dots to hv_setup_sched_clock() in drivers/clocksource/hyperv_timer.c.

> But I would be good with some restructuring so that setting the sched clock
> save/restore hooks is more closely tied to the sched clock choice,

Yeah, this is the intent of my ranting.  After the dust settles, the code can
look like this.

---
#ifdef CONFIG_GENERIC_SCHED_CLOCK
static __always_inline void hv_setup_sched_clock(void *sched_clock)
{
	/*
	 * We're on an architecture with generic sched clock (not x86/x64).
	 * The Hyper-V sched clock read function returns nanoseconds, not
	 * the normal 100ns units of the Hyper-V synthetic clock.
	 */
	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
}
#elif defined CONFIG_PARAVIRT
static u64 hv_ref_counter_at_suspend;
/*
 * Hyper-V clock counter resets during hibernation. Save and restore clock
 * offset during suspend/resume, while also considering the time passed
 * before suspend. This is to make sure that sched_clock using hv tsc page
 * based clocksource, proceeds from where it left off during suspend and
 * it shows correct time for the timestamps of kernel messages after resume.
 */
static void hv_save_sched_clock_state(void)
{
	hv_ref_counter_at_suspend = hv_read_reference_counter();
}

static void hv_restore_sched_clock_state(void)
{
	/*
	 * Adjust the offsets used by hv tsc clocksource to
	 * account for the time spent before hibernation.
	 * adjusted value = reference counter (time) at suspend
	 *                - reference counter (time) now.
	 */
	hv_sched_clock_offset -= (hv_ref_counter_at_suspend - hv_read_reference_counter());
}

static __always_inline void hv_setup_sched_clock(void *sched_clock)
{
	/* We're on x86/x64 *and* using PV ops */
	paravirt_set_sched_clock(sched_clock, hv_save_sched_clock_state,
				 hv_restore_sched_clock_state);
}
#else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
#endif /* CONFIG_GENERIC_SCHED_CLOCK */
---

> as long as the architecture independence of hyperv_timer.c is preserved.

LOL, ah yes, the architecture independence of MSRs and TSC :-D

Teasing aside, the code is firmly x86-only at the moment.  It's selectable only
by x86:

  config HYPERV_TIMER
	def_bool HYPERV && X86
 
and since at least commit e39acc37db34 ("clocksource: hyper-v: Provide noinstr
sched_clock()") there are references to symbols/functions that are provided only
by x86.

I assume arm64 support is a WIP, but keeping the upstream code arch independent
isn't very realistic if the code can't be at least compile-tested.  To help
drive-by contributors like myself, maybe select HYPER_TIMER on arm64 for
COMPILE_TEST=y builds?

  config HYPERV_TIMER
	def_bool HYPERV && (X86 || (COMPILE_TEST && ARM64))

I have no plans to touch code outside of CONFIG_PARAVIRT, i.e. outside of code
that is explicitly x86-only, but something along those lines would help people
like me understand the goal/intent, and in theory would also help y'all maintain
the code by detecting breakage.
