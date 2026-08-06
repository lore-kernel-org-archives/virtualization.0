Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EBF4AE640
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059449; cv=none; b=opUaEBNWsLbkrBJ1ovL1Z9f9j9qzHrxI6RgHDvhiOuzq9Zk36xkKa1WvCe8DUQ4xn4sSW1EcOLSGCYHGWvBD3pgEUPf79UKm4TqTw4OKmDeOr2YoyvUp3G4fkq4gH6RF59ZApJ7t73KA+HBrvUSxFZzO60VQC6Bb57WXk1fnv8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059449; c=relaxed/simple;
	bh=DotEodtP+5nx+qQ2PED5Az3WVrkKwKmbTzb/y5Tt2sE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oqd3HTjEuAtJ4tdAeJa868URvOH2XkIkCr6ZfkJ/Owv2YitvgmoRKgN4Kc8GSrSJpgU0iVLMEjEiDAhnSbOLTDVjYgLnCK1koaHUT7yfZ2KRlRNUgl16wALzkWO+5n6WTkml6QU9AJ/cM1w2VyQkZNTeDSf4aiMhXcRfg4uiBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sh3dyMZq; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sh3dyMZq"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfa55c9430so27862215ad.0
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059445; x=1786664245; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/TxUyuE9/koLQyW6zcM5dMaQ+pcBou93eYQoJAAWN+E=;
        b=sh3dyMZqa82EP+7hk4DvkMrXRt7qO6rY86gbtPCnha6WZKN5L/7iHDD4+sT+n8ifYB
         14RHb6TLkOYLaMNvZavxheTw3c7Zf97zO3MRzkcxc67bq7PeCelVburs1rvYe+VH39Bp
         LjEokFVrfZh8vp4jhkqKk90fUQMVv+dtP+mO6hY1wPF5HtaUTD1B49wpYTMlEce2DyeN
         4Eu+DWbGeV6b0UBwmIFaDN87JHRm53qdB230BVr1guHc4dDlRVQOWQOrS77hRP4lId5N
         LF6IbyXjn7r9TJXXZrujGZLih+mbYdQbI/0+OW6O0ZChBqO1EyiXd//+UT7MK9yVcD9i
         M0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059445; x=1786664245;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/TxUyuE9/koLQyW6zcM5dMaQ+pcBou93eYQoJAAWN+E=;
        b=MJ2h6z9R7lKFuyBOl7DdURN0+F64imBOPqAnwFlf94SSE2R4L8fRmARgyeyH/D9e/2
         Krpa2b8LaAiLBeIAJ4uS+wtVhJUNEZtY3LR8T6WxYuMtauvvO5eHS+/GQ726RPIBD3WF
         abSSgrOJcW6oheCCM/PeWWBScqA8rRjS9+j6QNcQq88pZEgyT0O32ED+49aGvro97HZs
         zpchUpST4cXWA0+xoB/Q28UjaXBGf1nBhLfVmYB9gv2wgZdc9CEYAQ8VnhYoumqMcurO
         UXHf+dc9SocIjgpaZiUUPIbQZQiUpvkGvkrhw/o2YawmhDIrNElm2vTHJHOSHnMRM9vY
         Jm8g==
X-Forwarded-Encrypted: i=1; AHgh+RpYHI6jwR5O6pEcxNRutemP5mHiPuNogf84I3mOKVdXzGRc1Xk4NGM/Q6LwYP2KThqd4UMx3r60HfFBqWwqPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwApXEFcNuiZ8KqdeqZ0ujUBT767NSVWJAI0D3Br6oo56QHzWla
	YibS6siyjh3bIAIh4sb2bp0524QlEh5vkCuf+EOcYUAd0o+E5wcbInTA1mfOnls955tAIeZ4b3i
	YKENHZg==
X-Received: from plgi9.prod.google.com ([2002:a17:902:cf09:b0:2c7:e06e:86f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c402:b0:2c9:c952:6e9
 with SMTP id d9443c01a7336-2d0ca7b024fmr202039245ad.2.1786059444816; Thu, 06
 Aug 2026 16:37:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:06 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-50-seanjc@google.com>
Subject: [PATCH v6 49/51] x86/kvmclock: Plumb in AP-online and BSP-resume to
 kvmlock, for documentation
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
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

Invoke kvmclock_cpu_action() with AP_ONLINE and BSP_RESUME, even though
kvmclock doesn't need to do anything in either case, so that the asymmetry
of kvmclock is a detail buried in kvmclock, and to explicitly document
that doing nothing during those phases is intentional and correct.

For all intents and purposes, no functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  2 ++
 arch/x86/kernel/kvm.c           | 22 +++++++++++++-------
 arch/x86/kernel/kvmclock.c      | 37 ++++++++++++++++++++++++++-------
 3 files changed, 45 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 08686ff19caa..763ed017738a 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -120,6 +120,8 @@ static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
 #ifdef CONFIG_KVM_GUEST
 enum kvm_guest_cpu_action {
 	KVM_GUEST_BSP_SUSPEND,
+	KVM_GUEST_BSP_RESUME,
+	KVM_GUEST_AP_ONLINE,
 	KVM_GUEST_AP_OFFLINE,
 	KVM_GUEST_SHUTDOWN,
 };
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 9c0b2fc98cc9..b954238b09fc 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -474,18 +474,24 @@ static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
 	kvmclock_cpu_action(action);
 }
 
+static void __kvm_cpu_online(unsigned int cpu, enum kvm_guest_cpu_action action)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	kvmclock_cpu_action(action);
+	kvm_guest_cpu_init();
+	local_irq_restore(flags);
+}
+
+#ifdef CONFIG_SMP
+
 static int kvm_cpu_online(unsigned int cpu)
 {
-	unsigned long flags;
-
-	local_irq_save(flags);
-	kvm_guest_cpu_init();
-	local_irq_restore(flags);
+	__kvm_cpu_online(cpu, KVM_GUEST_AP_ONLINE);
 	return 0;
 }
 
-#ifdef CONFIG_SMP
-
 static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
 
 static bool pv_tlb_flush_supported(void)
@@ -752,7 +758,7 @@ static int kvm_suspend(void *data)
 
 static void kvm_resume(void *data)
 {
-	kvm_cpu_online(raw_smp_processor_id());
+	__kvm_cpu_online(raw_smp_processor_id(), KVM_GUEST_BSP_RESUME);
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL) && has_guest_poll)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index bc98ebb8587d..842f38c5f6ca 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -150,7 +150,7 @@ static void kvm_save_sched_clock_state(void)
 #ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
-	kvm_register_clock("secondary cpu clock");
+	kvm_register_clock("secondary cpu, startup");
 }
 #endif
 
@@ -174,13 +174,34 @@ static void kvmclock_resume(struct clocksource *cs)
 
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
-	/*
-	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
-	 * being used for sched_clock, then it needs to be kept alive until the
-	 * last minute, and restored as quickly as possible after resume.
-	 */
-	if (action != KVM_GUEST_BSP_SUSPEND)
+	switch (action) {
+		/*
+		 * The BSP's clock is managed via clocksource suspend/resume,
+		 * to ensure it's enabled/disabled when timekeeping needs it
+		 * to be, e.g. before reading wallclock (which uses kvmclock).
+		 */
+	case KVM_GUEST_BSP_SUSPEND:
+	case KVM_GUEST_BSP_RESUME:
+		break;
+	case KVM_GUEST_AP_ONLINE:
+		/*
+		 * Secondary CPUs use a dedicated hook to enable kvmclock early
+		 * during bringup, there's nothing to be done during CPU online
+		 * (which runs at CPUHP_AP_ONLINE_DYN).  When kvmclock is being
+		 * used as sched_clock, kvmclock must be enabled *very* early,
+		 * and even when kvmclock is "only" being used for the main
+		 * clocksource, it still needs to be enabled long before the
+		 * dynamic CPUHP calls are made.
+		 */
+		break;
+	case KVM_GUEST_AP_OFFLINE:
+	case KVM_GUEST_SHUTDOWN:
 		kvmclock_disable();
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
 }
 
 /*
@@ -382,7 +403,7 @@ void __init kvmclock_init(bool prefer_tsc)
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
 	this_cpu_write(hv_clock_per_cpu, &hv_clock_boot[0]);
-	kvm_register_clock("primary cpu clock");
+	kvm_register_clock("primary cpu, online");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
-- 
2.55.0.679.g6767b8d81c-goog

