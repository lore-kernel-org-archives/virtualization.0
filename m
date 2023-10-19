Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7B3C41513
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 11:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2CB36FB66;
	Thu, 19 Oct 2023 11:55:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F2CB36FB66
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOudsoRw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H9PC7JVLGzsc; Thu, 19 Oct 2023 11:55:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 357E26FB5F;
	Thu, 19 Oct 2023 11:55:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 357E26FB5F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D11CC0039;
	Thu, 19 Oct 2023 11:55:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00D76C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF931410E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:55:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CF931410E5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gOudsoRw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7vH-GFuQtgwl
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:55:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8824E4174A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 11:55:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8824E4174A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697716537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JG4lTBZAdQNjQdsOUJfgsaU+O9WpyXKgw/EAl16ov/Y=;
 b=gOudsoRwwVFKdJpvQ+05OK4tNUuOPajXCuhfdvcrX/PTywGA74oQWp+7nhcnufefKnO1FM
 RxFKuTNXaL3KYa4pGH/maZOY9ThlsfcohQHKHpM2r5qieh3WV3UGu78gR6vGNP1WewQ0Ut
 AlJeM9wqSkJWze/7YqduHLv9P67aBSk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-SDUA4Cs9MA2tuY_qdELJUA-1; Thu, 19 Oct 2023 07:55:35 -0400
X-MC-Unique: SDUA4Cs9MA2tuY_qdELJUA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae57d8b502so580291966b.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 04:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697716534; x=1698321334;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JG4lTBZAdQNjQdsOUJfgsaU+O9WpyXKgw/EAl16ov/Y=;
 b=cTKnipWswIVxBU15NYblnGiSthxWDLRKmyk1co29LvpoB9/2aB6jzt8NaDFy7KhFEQ
 Pt5IuJ3qjs4DQuu20dNMA5AchArwDZKIINRHmr9c2UfcRPzB8Ol/GJFRgp+vrwp1MbEE
 /b4Owanga3oluc0MGh0f5blvFJSRarbF8ulYpy1WrlYfHsTXIp7oI1YjMKnubzjmN6IC
 akypoIRY4yffTNXbN4arxm7/ISmp9YHl2BKWS3gMagKSta57eYGmcyRjvxTi6btat/O+
 XJAYItuLg/1WYLSB3UqC73W1r09jHrCNEOwJFg7VjS1MEnQsunS1vd5IDVXkAHvhqko4
 xEVg==
X-Gm-Message-State: AOJu0Yy98+AqdqTuVtYD2QBi7gicmlN7w43Eq96efozu7eFwQqFCSchG
 HoV48JggsBcEZyOebldMrSd43lWDuLHSzcskWhZTU8nmyjtNQckFWWZU9VUD9MckwrPttBckYLI
 847ul/lZQ8uFS4BpadvuVikO1beOlLsEl7+FqFSDYUw==
X-Received: by 2002:a17:907:7f0f:b0:9c4:d19:4a6a with SMTP id
 qf15-20020a1709077f0f00b009c40d194a6amr1860682ejc.53.1697716534559; 
 Thu, 19 Oct 2023 04:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9mIPgfvn9ZU7nuvj7xbGgy8xMbs+UZxNrZmJKG1kLP0WAJ1c7LQRgVQvXQZF9O5leQxJekQ==
X-Received: by 2002:a17:907:7f0f:b0:9c4:d19:4a6a with SMTP id
 qf15-20020a1709077f0f00b009c40d194a6amr1860648ejc.53.1697716534168; 
 Thu, 19 Oct 2023 04:55:34 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 hb6-20020a170906b88600b009b8dbdd5203sm3372788ejb.107.2023.10.19.04.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:55:33 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>, x86@kernel.org,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
 pv-drivers@vmware.com, xen-devel@lists.xenproject.org,
 linux-hyperv@vger.kernel.org
Subject: Re: [PATCH RFC 1/1] x86/paravirt: introduce param to disable pv
 sched_clock
In-Reply-To: <20231018221123.136403-1-dongli.zhang@oracle.com>
References: <20231018221123.136403-1-dongli.zhang@oracle.com>
Date: Thu, 19 Oct 2023 13:55:32 +0200
Message-ID: <87ttqm6d3f.fsf@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: jgross@suse.com, wanpengli@tencent.com, hpa@zytor.com, peterz@infradead.org,
 seanjc@google.com, dave.hansen@linux.intel.com, joe.jin@oracle.com,
 linux-kernel@vger.kernel.org, akaher@vmware.com, mingo@redhat.com,
 bp@alien8.de, amakhalov@vmware.com, pbonzini@redhat.com, tglx@linutronix.de,
 dwmw2@infradead.org, boris.ostrovsky@oracle.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Dongli Zhang <dongli.zhang@oracle.com> writes:

> As mentioned in the linux kernel development document, "sched_clock() is
> used for scheduling and timestamping". While there is a default native
> implementation, many paravirtualizations have their own implementations.
>
> About KVM, it uses kvm_sched_clock_read() and there is no way to only
> disable KVM's sched_clock. The "no-kvmclock" may disable all
> paravirtualized kvmclock features.
>
>  94 static inline void kvm_sched_clock_init(bool stable)
>  95 {
>  96         if (!stable)
>  97                 clear_sched_clock_stable();
>  98         kvm_sched_clock_offset = kvm_clock_read();
>  99         paravirt_set_sched_clock(kvm_sched_clock_read);
> 100
> 101         pr_info("kvm-clock: using sched offset of %llu cycles",
> 102                 kvm_sched_clock_offset);
> 103
> 104         BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
> 105                 sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
> 106 }
>
> There is known issue that kvmclock may drift during vCPU hotplug [1].
> Although a temporary fix is available [2], we may need a way to disable pv
> sched_clock. Nowadays, the TSC is more stable and has less performance
> overhead than kvmclock.
>
> This is to propose to introduce a global param to disable pv sched_clock
> for all paravirtualizations.
>
> Please suggest and comment if other options are better:
>
> 1. Global param (this RFC patch).
>
> 2. The kvmclock specific param (e.g., "no-vmw-sched-clock" in vmware).
>
> Indeed I like the 2nd method.
>
> 3. Enforce native sched_clock only when TSC is invariant (hyper-v method).
>
> 4. Remove and cleanup pv sched_clock, and always use pv_sched_clock() for
> all (suggested by Peter Zijlstra in [3]). Some paravirtualizations may
> want to keep the pv sched_clock.

Normally, it should be up to the hypervisor to tell the guest which
clock to use, i.e. if TSC is reliable or not. Let me put my question
this way: if TSC on the particular host is good for everything, why
does the hypervisor advertises 'kvmclock' to its guests? If for some
'historical reasons' we can't revoke features we can always introduce a
new PV feature bit saying that TSC is preferred.

1) Global param doesn't sound like a good idea to me: chances are that
people will be setting it on their guest images to workaround problems
on one hypervisor (or, rather, on one public cloud which is too lazy to
fix their hypervisor) while simultaneously creating problems on another.

2) KVM specific parameter can work, but as KVM's sched_clock is the same
as kvmclock, I'm not convinced it actually makes sense to separate the
two. Like if sched_clock is known to be bad but TSC is good, why do we
need to use PV clock at all? Having a parameter for debugging purposes
may be OK though...

3) This is Hyper-V specific, you can see that it uses a dedicated PV bit
(HV_ACCESS_TSC_INVARIANT) and not the architectural
CPUID.80000007H:EDX[8]. I'm not sure we can blindly trust the later on
all hypervisors.

4) Personally, I'm not sure that relying on 'TSC is crap' detection is
100% reliable. I can imagine cases when we can't detect that fact that
while synchronized across CPUs and not going backwards, it is, for
example, ticking with an unstable frequency and PV sched clock is
supposed to give the right correction (all of them are rdtsc() based
anyways, aren't they?).

>
> To introduce a param may be easier to backport to old kernel version.
>
> References:
> [1] https://lore.kernel.org/all/20230926230649.67852-1-dongli.zhang@oracle.com/
> [2] https://lore.kernel.org/all/20231018195638.1898375-1-seanjc@google.com/
> [3] https://lore.kernel.org/all/20231002211651.GA3774@noisy.programming.kicks-ass.net/
>
> Thank you very much for the suggestion!
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  arch/x86/include/asm/paravirt.h |  2 +-
>  arch/x86/kernel/kvmclock.c      | 12 +++++++-----
>  arch/x86/kernel/paravirt.c      | 18 +++++++++++++++++-
>  3 files changed, 25 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 6c8ff12140ae..f36edf608b6b 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -24,7 +24,7 @@ u64 dummy_sched_clock(void);
>  DECLARE_STATIC_CALL(pv_steal_clock, dummy_steal_clock);
>  DECLARE_STATIC_CALL(pv_sched_clock, dummy_sched_clock);
>  
> -void paravirt_set_sched_clock(u64 (*func)(void));
> +int paravirt_set_sched_clock(u64 (*func)(void));
>  
>  static __always_inline u64 paravirt_sched_clock(void)
>  {
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index fb8f52149be9..0b8bf5677d44 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -93,13 +93,15 @@ static noinstr u64 kvm_sched_clock_read(void)
>  
>  static inline void kvm_sched_clock_init(bool stable)
>  {
> -	if (!stable)
> -		clear_sched_clock_stable();
>  	kvm_sched_clock_offset = kvm_clock_read();
> -	paravirt_set_sched_clock(kvm_sched_clock_read);
>  
> -	pr_info("kvm-clock: using sched offset of %llu cycles",
> -		kvm_sched_clock_offset);
> +	if (!paravirt_set_sched_clock(kvm_sched_clock_read)) {
> +		if (!stable)
> +			clear_sched_clock_stable();
> +
> +		pr_info("kvm-clock: using sched offset of %llu cycles",
> +			kvm_sched_clock_offset);
> +	}
>  
>  	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
>  		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 97f1436c1a20..2cfef94317b0 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -118,9 +118,25 @@ static u64 native_steal_clock(int cpu)
>  DEFINE_STATIC_CALL(pv_steal_clock, native_steal_clock);
>  DEFINE_STATIC_CALL(pv_sched_clock, native_sched_clock);
>  
> -void paravirt_set_sched_clock(u64 (*func)(void))
> +static bool no_pv_sched_clock;
> +
> +static int __init parse_no_pv_sched_clock(char *arg)
> +{
> +	no_pv_sched_clock = true;
> +	return 0;
> +}
> +early_param("no_pv_sched_clock", parse_no_pv_sched_clock);
> +
> +int paravirt_set_sched_clock(u64 (*func)(void))
>  {
> +	if (no_pv_sched_clock) {
> +		pr_info("sched_clock: not configurable\n");
> +		return -EPERM;
> +	}
> +
>  	static_call_update(pv_sched_clock, func);
> +
> +	return 0;
>  }
>  
>  /* These are in entry.S */

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
