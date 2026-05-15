Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1923B2FFD
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872875; cv=none; b=gT7zjpbmaaVzNRMf+XxMKsnujR+PIJmfM4I9xldgoh3mR75XzeaNau3dbExdmdZYFmYhTNut8wHOPjFMJDiWzujvUPFWpMkwjXIpAyEFYotE+tKZF+lcMw0i+zj7iOb+Xelhcf/8ZMv54Swd0Z8iv4x2scy1xXS8AA2pq2WJP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872875; c=relaxed/simple;
	bh=oS9aSnkApcPsOGR1rkhF7MOLa9irLvbbIXlzkW7Bx9o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N8ivWcrOX8YHreiOKiF1BFwvRtHCfl+fkpSo34fXs65ol0N+CpVhZjGVXNCHdOKetbYtLqMMU2up/cxa23Ftp+oDHt65AeowsOOVoJu0RCGCFiaJ7oXaB6kqRIFk3rzQ3olYU/5P7AN4KttlWHVINEyiQ9UePxnpxv83QUR0LWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8K2D9B/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8K2D9B/"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-366122e01fcso83776a91.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872873; x=1779477673; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=POYAFJXhX15R3hmqAgfLZg3VsZ+0XFpd3jcwWXWllKs=;
        b=O8K2D9B/eFrcfpBSbkxmb8SsQnJfbDyoWlPbk7t5qxOmk+p2dmbz7hBG3/wRc5su+W
         A+6u+1TsoRqc4ZCPugfCjYjynIt6zMcPzYG4o5rlWnaQ42Rbg8Hv+bFYfGLKoa6KuWPE
         K+Uqbzw1tBK1ttgwA6nbR+T8GySYucmAJOvR1Z4K9c47pudubAV0guYP9ASt9rxbBT9w
         +Z+7jWdd73gvr+As1tH6wT9RjLO6nwq4JZMsYWfQ51PvisZV/Rs8E42WrApMba0+7T+I
         ewsJfXbLsWq0VNq3tsPtX9jKwb25CjmilF5RZGV+ed/IoO7SNxi//T9lr+zrOY030veN
         mmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872873; x=1779477673;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POYAFJXhX15R3hmqAgfLZg3VsZ+0XFpd3jcwWXWllKs=;
        b=NOT+Ppwtj18q7mmSqW6z/RqwYsZ2eF9rwbD21VsGo1W1fl3153xH2Et4F7qK4cM/lE
         rPqUm4kVYntVhAt2cvPQs60Z/4HQ8Su1ZRUmUd6lB2TuxbzIlm7k7GYB2ziMI3Mvs0cy
         vtHhzCvJgaVGY/mKGt18PBeS1Rusor3KpK2dSDgWIyAWWS4GYLH3qqtwXn5V50UkhAlB
         wexBedHQx/McM9dTrO7N4sZnIGfviANF5qNSzMhE7wHc/UfDqQc/3uRnvefR03I58ed8
         9gsead1i4xlEBXLiF0qSXUvWOPI1O5YCNP/20d0sseeAqyUJQgfZevvYcyjbdGXmfZOS
         26pA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ol+NPRzykpzdtVKwDyz76TmXqRwFk1SjbEFlRpz1FXr8waT+E6sTao0hvVIcNZ/7SEXMlO3yebiI45U52Pg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSiu/TjMjNWU0ORvHX+K0yvvxJmt90A07zdsr9jvq5SezNnPVA
	l7AJrbpwXZIRj5PtjrTceLcUFIIntmryn21mPGeB/yFUGeSzLgW/8KG/X4dj+UYDTv6Z2izdRoz
	i6iExbg==
X-Received: from pgla17.prod.google.com ([2002:a63:b51:0:b0:c82:2e5b:8f33])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3505:b0:364:edd2:812
 with SMTP id 98e67ed59e1d1-36951cb3086mr5037302a91.25.1778872872299; Fri, 15
 May 2026 12:21:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:34 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-34-seanjc@google.com>
Subject: [PATCH v3 33/41] x86/kvmclock: Mark TSC as reliable when it's
 constant and nonstop
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Mark the TSC as reliable if the hypervisor (KVM) has enumerated the TSC
as constant and nonstop, and the admin hasn't explicitly marked the TSC
as unstable.  Like most (all?) virtualization setups, any secondary
clocksource that's used as a watchdog is guaranteed to be less reliable
than a constant, nonstop TSC, as all clocksources the kernel uses as a
watchdog are all but guaranteed to be emulated when running as a KVM
guest.  I.e. any observed discrepancies between the TSC and watchdog will
be due to jitter in the watchdog.

This is especially true for KVM, as the watchdog clocksource is usually
emulated in host userspace, i.e. reading the clock incurs a roundtrip
cost of thousands of cycles.

Marking the TSC reliable addresses a flaw where the TSC will occasionally
be marked unstable if the host is under moderate/heavy load.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index b6b2018c51db..47f7df1e81a0 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -363,6 +363,7 @@ static __init void kvm_sched_clock_init(bool stable)
 
 void __init kvmclock_init(void)
 {
+	enum tsc_properties tsc_properties = TSC_FREQUENCY_KNOWN;
 	bool stable = false;
 
 	if (!kvm_para_available() || !kvmclock)
@@ -401,18 +402,6 @@ void __init kvmclock_init(void)
 			 PVCLOCK_TSC_STABLE_BIT;
 	}
 
-	kvm_sched_clock_init(stable);
-
-	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
-					  TSC_FREQUENCY_KNOWN);
-
-	x86_platform.get_wallclock = kvm_get_wallclock;
-	x86_platform.set_wallclock = kvm_set_wallclock;
-#ifdef CONFIG_SMP
-	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
-#endif
-	kvm_get_preset_lpj();
-
 	/*
 	 * X86_FEATURE_NONSTOP_TSC is TSC runs at constant rate
 	 * with P/T states and does not stop in deep C-states.
@@ -423,8 +412,22 @@ void __init kvmclock_init(void)
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
-	    !check_tsc_unstable())
+	    !check_tsc_unstable()) {
 		kvm_clock.rating = 299;
+		tsc_properties = TSC_FREQ_KNOWN_AND_RELIABLE;
+	}
+
+	kvm_sched_clock_init(stable);
+
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
+					  tsc_properties);
+
+	x86_platform.get_wallclock = kvm_get_wallclock;
+	x86_platform.set_wallclock = kvm_set_wallclock;
+#ifdef CONFIG_SMP
+	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
+#endif
+	kvm_get_preset_lpj();
 
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 	pv_info.name = "KVM";
-- 
2.54.0.563.g4f69b47b94-goog

