Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E783ED5B6
	for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 22:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787005575; cv=pass; b=Vu/LYZgt1TLv/3V8dAREnco3L3aSLLEwqQen5nWmLuToaPWzh04Y10kSCMYltNLwH8BIcUZzp8dd/K0PlZAoyhDjQcaN0w21G4mnnrWHYZs4baqm/SYTrXDF175B7YfEHdbzwRujAAXoo1poDt44jC/XHCmjTncWwxoMcGctLi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787005575; c=relaxed/simple;
	bh=DKrK8uziOsnu81Z21mMms2SVn4MRmNDPf9W6rlN6ndc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1LeC8Wt5DmioixR/53CgYPv6OUhq971LuLSzBQxydsKooxQQyo0DkkIur9NU+L1niZ+aAWeAbtScAwU8Ngpz2aMS5uy/CksgI/Z2BoH+opgUjxreBW2pVW/0lC7hl3vjbUw8K2vmI6ErJoBiI3KKDuNPnY5vHMMBPDfpqjbN2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XB9JniD9; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XB9JniD9"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so3702a12.0
        for <virtualization@lists.linux.dev>; Mon, 17 Aug 2026 15:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787005562; cv=none;
        d=google.com; s=arc-20260327;
        b=C/8iAy3VdRXlbwUYkliw9U59pkhMNv0j+mrPb47WVQ4FIzXec8QzFFUBKTqmQVAZzU
         btetMUFHBDYacJw4W2GPka/19zc1ggVeIcL2haBlHfk+Ql9JvSvFzsOc4MNlGLLITM3M
         MxwCaplEtpIalwohkKOlSeiCP/QMICTJ/Q09IILZ64uYwzUS5tA7/oh+8lASvDBCyM3o
         DHkPNNqlWZ3kriM1YLS1DG3Keaqo29IVS/l9nixloQvcFB2z2Ts9yHW6Xq2BLw7C5fbg
         vI0vkaCycM3+MKpis2jxh9C6djXbGaaSZYYs9h+aXFBtTd7UNUrp4TG82olkkw/y8fIB
         d9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hENxuN5mzaES0wxF2BepwjZBV79XeYKjjyJElzU8XaI=;
        fh=4eGG4nlqM6ou1Y5pdqFaSvY53ZZo+M0toadD0lGm5yU=;
        b=EYAMkHg/V8KiQmkSVaK7P9UP+fLdhdQAzI7qPm+4nBLsldh+OpFLpSwgc4CoeKSdiR
         C/Ac1a5SYDa8iOLWPIz5NSxhlOSYBrIXOHIhiivXf61aKignsdlLX/wc1khY9IRjiwda
         jn+5bw8OJIIkVa4430IHClmjD9u6DmDGx/8iKmonEaB2HSWia6kzuLHtGIRv6FQcHm/L
         4lPuw2Ymdhq6LZNXHma+GsXa1mKeZlUmifIaOWlpUnYoUfHobj7K37uC7qsYdqgxBbHT
         TydI5Y9YNRETpsw/UCMX7k2gUJmxWI5bCr4nmVoQGJVCzsflfILYV88ojULfAuGcze+F
         61WA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787005562; x=1787610362; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hENxuN5mzaES0wxF2BepwjZBV79XeYKjjyJElzU8XaI=;
        b=XB9JniD9+Oy9X4VdCYpkmuh1wcG1spAMOHmcrJ9Fh/WA5sCuAQPKXs3GT7rIJ6ZjsK
         i/VFHAPl4BbfAsZ3KkneL0/9vlbukXp7WAFyBBt9Hw/RgGHCTZG5qN/jmBVSmN3A1YKJ
         oDm4YQ5xCDvyEy4zvvlcphMfsp2Rq4ydsSmhn4G6k9LDskV9fFJAG+GjkMV33/BBPkjA
         IwR2CNH2PGIN27b/oaBP1vGl7ldD9z3DB1uaCR2BvK670iXu075fb5MrLJcqd/SZLTw5
         flsDTDj/e11ngK4n6woGj3zV8Vj66LbCsLF326RxiaU3kACnmbooDOMaW6+11SePDIvs
         WxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787005562; x=1787610362;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hENxuN5mzaES0wxF2BepwjZBV79XeYKjjyJElzU8XaI=;
        b=MxpbpsZKDSBvrtVqx5DMK8AyQGBxhDyLmgx8dBMrR8EBgbwCndVO2eZ901DGwVYcuX
         UOU7PtPw0ko5qeh9NEECK4ESUpANxp451XdTEG0e1YjwlAdGcB5I4P5NNS8kru0s+Y+t
         PljsKekqggYYpghXDXC1oLBjfg4+3Dn7fP0x6PIpguAcDvOg9leuVvIyktbODCt2Hli1
         mUYrXYkDzOjSKQ10rOc72TnusubR2f64J8VrEpNZNrAuHu7zk4zGaRxYJYkG7FsDCdWB
         cPyQx4JTvq5vu66aaoTiCjUHDZdCmLSto6DB4L0TOBL1yUdZAHqcAELnVYlYJTBqKkGs
         Jxgg==
X-Forwarded-Encrypted: i=1; AHgh+RpPFwUqNoidWomKrnTFHjPATl55ra5s6G3h+QaZcVIcYsqi4C7tioIOGmFm7Flbn8X8755Us0RHMMJQjNctwg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8cc8H3O75Dj7huYoIMmKroW115NqnSQasB4jgEksgfeKD1Idb
	j1fgeMJORkewdprzjNspGBMinbI8MnXsKelZbuQMJCVab8i4MSULmTcjOb2+WRes9O+MiI2CN6C
	LA0r0vYM7UJfYM/mg/OTCPCYxrytHwmzluBXYrq2a
X-Gm-Gg: AR+sD13hB9+g3LB0TltPf5xYRCGgEGlNtYdAL6vtAQ4hswTBSOoHjw3g5Ua5CoRTAli
	iDIHWYpsZhrWdGjueNgr6X4p0dm5rUdx3tk2YdTcOXwHrn9ofP5iFPSilV7ywDbOz1AN9/lOGYf
	N7mSEmyQGIeFX6jpLzQP8Z4ggMzRGBPnnduOpq9o2P5qqTctqaYvYKN95BGOU2NsOxKkpeqByLL
	4e+p3bvHIMojll5SR5NV1s4Ud6ng1lzT7Y1ZkbUW4JfG8hENPR2mPPus4w4imPtvJ12FxSYs97l
	NN8yfD4ivfAU0MQdJEIiInVgp3gbABbaT4QWgP8lZCiQ
X-Received: by 2002:aa7:db55:0:b0:698:ac70:31b9 with SMTP id
 4fb4d7f45d1cf-6a3eb34835bmr2896a12.5.1787005561938; Mon, 17 Aug 2026 15:26:01
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com> <20260806233609.212337-22-seanjc@google.com>
 <ef3b56bf-8df0-4a40-82c7-bd2d65eec71e@yandex-team.ru> <aoMVy4VB1sq4T-ys@google.com>
 <0d1f0afe-74f0-4adb-a7cf-2d4efd001de3@yandex-team.ru>
In-Reply-To: <0d1f0afe-74f0-4adb-a7cf-2d4efd001de3@yandex-team.ru>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 17 Aug 2026 15:25:50 -0700
X-Gm-Features: AcwNN1WdnB6ezAOkUjWvrMa9sQkEiE5NQZNmLUZ6exeGRBIrQHFr5mGJRwWtIb4
Message-ID: <CALMp9eQRW22S6zSrhkxc+8PgSuOJJOB-jh_W1iyr7c0j5SBLow@mail.gmail.com>
Subject: Re: [PATCH v6 21/51] x86/kvm: Obtain TSC frequency from PV CPUID if present
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: Sean Christopherson <seanjc@google.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:20=E2=80=AFPM Maksim Davydov
<davydov-max@yandex-team.ru> wrote:
>
>
>
> On 8/17/26 17:08, Sean Christopherson wrote:
> > On Mon, Aug 17, 2026, Maksim Davydov wrote:
> >> On 8/7/26 02:35, Sean Christopherson wrote:
> >>> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> >>> index 29ca37e9a3bc..f55d0305d1f3 100644
> >>> --- a/arch/x86/kernel/kvmclock.c
> >>> +++ b/arch/x86/kernel/kvmclock.c
> >>> @@ -342,8 +342,10 @@ void __init kvmclock_init(void)
> >>>     flags =3D pvclock_read_flags(&hv_clock_boot[0].pvti);
> >>>     kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
> >>>
> >>> -   x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
> >>> -   x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
> >>> +   if (!x86_init.hyper.get_tsc_khz)
> >>> +           x86_init.hyper.get_tsc_khz =3D kvmclock_get_tsc_khz;
> >>> +   if (!x86_init.hyper.get_cpu_khz)
> >>> +           x86_init.hyper.get_cpu_khz =3D kvmclock_get_tsc_khz;
> >>>     x86_platform.get_wallclock =3D kvm_get_wallclock;
> >>>     x86_platform.set_wallclock =3D kvm_set_wallclock;
> >>>  #ifdef CONFIG_X86_LOCAL_APIC
> >>
> >>
> >> I cannot test this right now as I lack two servers with different CPU
> >> base frequencies, but it seems that this patch might break something i=
n
> >> guests:
> >> After migrating a VM (QEMU + KVM) from a host with one base frequency =
to
> >> another host with a different base frequency, the value in CPUID leaf
> >> 0x40000010 EAX changes and becomes the same as the destination host ba=
se
> >> frequency instead of remaining the source base frequency.
> >
> > That's a bug in whatever is orchestrating the migration, and/or QEMU if=
 QEMU is
> > handing the upper layers a loaded footgun.
> >
> >> The main reason for this behaviour is that setting the TSC frequency v=
ia
> >> ioctl(KVM_SET_TSC_KHZ) doesn't change the value in CPUID leaf 0x400000=
10
> >> EAX and these two entities are still not connected.
> >
> > And they never will be.  It's userspace's responsibility to fill the co=
rrect
> > values for 0x40000010.
> >
> > But AFAICT, QEMU does the right thing.  env->tsc_khz is used for both t=
he CPUID
> > leaf and for KVM_SET_TSC_KHZ.
> >
> > kvm_arch_init_vcpu():
> >
> >         c =3D &cpuid_data.entries[cpuid_i++];
> >         c->function =3D KVM_CPUID_SIGNATURE | 0x10;
> >         c->eax =3D env->tsc_khz;
> >         c->ebx =3D env->apic_bus_freq / 1000; /* Hz to KHz */
> >         c->ecx =3D c->edx =3D 0;
> >
> > kvm_arch_set_tsc_khz():
> >
> >     r =3D set_ioctl ?
> >         kvm_vcpu_ioctl(cs, KVM_SET_TSC_KHZ, env->tsc_khz) :
> >         -ENOTSUP;
> >
>
> Agreed.
> However, kvm_arch_set_tsc_khz() is also used at the end of migration
> (qemu_loadvm_state -> cpu_synchronize_post_init).
> So, the new value of env->tsc_khz from the source host can be loaded
> during migration via KVM_SET_TSC_KHZ. However, the frequency in CPUID
> leaf 0x40000010 remains the same as on the destination host (the TSC
> frequency can differ from the source host's frequency). Thus, it's
> possible to have unsynchronized CPUID leaf 0x40000010 when using default
> QEMU parameters.

I don't use qemu, but isn't the qemu solution for this general
situation to mark leaf 40000010H as 'unmigratable'?
