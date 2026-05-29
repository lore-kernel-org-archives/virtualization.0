Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79940801D
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067317; cv=none; b=V5nj3xvWylgBabDB0doiT58PVZXOMMrL0y8FcLOr2W9YffjGHrc7eOnAQOIO32LjPMqAXGe8FTTZExL32tbnepgUWMT5byBGJTqzaKO1HYLj/Y0Pzq5eWa7XB5+v8KMjF7T3z5/+cReZuW4EwdVpb/qyUcO3VnVnKDLhQLkKYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067317; c=relaxed/simple;
	bh=LpZswxQcTpWpwllCQjxqETaNWjtDeaq0T2fKUuy7APw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TsRrwKQBlMEXs12hbIrUkIKBp7GCZ2JTAr9ZfERL44Jd8C2kGvTyRqHyv8YPdC9tXdP23dhiRr30sdfStmkeTDPy6MnCg/TGpnJeIy6UjjStWc4yWlmSzFbif7TDZgahWoaUA+K85cy4HiLUMYusIqcLy3f57xPWdBWJYBvSts8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWy9b4aE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWy9b4aE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2baedd2fd43so100030655ad.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067315; x=1780672115; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NsWUFw3C//DyVpAd+DrRqJ7N44+Z3glyMOS0MZwC4vY=;
        b=mWy9b4aEmrHImjqEIeCyZLcPxIz54oAMJQ5f2iQ/QxlxJHzDCnq6IJDfHvq6mPH5l6
         VZMV03iSM8QVHtPMBxgmzCwK1r+xORCSZjmp7UPuCgqV2+RBt3f2ci2/qfdj72pWIC1o
         zY7OO/O5KPIbpj45QWdtVU8vP/DobKc6uDWkYk5VyDxWCGOmVQlNGh7yxn8MjnR1fw+i
         mVmpXA6yN6IR6QUwR9NsA/1TnCYOXHbnqAuKCUkP6134NzpGE0G6Yn+YYX2GkK8pKb9Q
         LzPhqLJlfp13Xijz9c3n9oOlaXepoucJZRLdqnJRRZET0wr+uzuE4+bWSGdfqTmfwcTA
         LQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067315; x=1780672115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NsWUFw3C//DyVpAd+DrRqJ7N44+Z3glyMOS0MZwC4vY=;
        b=sMrRHlyYlE1grTsLP6+t4pkQ1yb3OSIXRGYFOJP74wf5dC8dpea8QU+XCTpAgzvRvu
         VbYVP5HL9EUAmLobxjJD354Nq+QqEI0MbFLGednFG+eDa5aMQac3rt1KRkszsSLYpZMA
         F+9E5y2PJZUanQnRqCNZaxU+DLbzNNAi4/U7RxrCZ5/qGRCPufMitVJlz4VVFlGjhInW
         xp5vsiGA2wJWt1+o2WGMcagWR64llasIJn9QJ19OfjDPZfWQBcyVtibMLOAsbcMsmC+y
         Txf9L+vl9oH8syQdJKGMbUc+t6W7YmXu1QPS66QutYU1LI5SsJQpOkSPeaTugh2JvHN/
         QwFg==
X-Forwarded-Encrypted: i=1; AFNElJ9tvT1p9R2FgMKpHoo33Vw+pi0VAQKab8GC2zxZfwDu0g+vvVLrFce9RhpGhJCaVZg5SE5XeAgHYKXNQb8Nrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxpwHmNknVrPPntHvDraDLEld4GcAjPRwIV9obTWvMVm39GQKOA
	haofw5mevDk4lFE9ksnq93kT4Y3yn7ghgzUAYJb5YrSW3xAu1esILDt1dHoz+qQ2TggX2zuqZ6U
	d29qfcA==
X-Received: from ploo20.prod.google.com ([2002:a17:902:e014:b0:2ba:41dd:4a8e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2bce:b0:2b4:5f96:184d
 with SMTP id d9443c01a7336-2bf3679ebb8mr2933525ad.5.1780067315192; Fri, 29
 May 2026 08:08:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:08:33 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150833.715042-1-seanjc@google.com>
Subject: [PATCH v4 46/47] x86/kvmclock: Plumb in AP-online and BSP-resume to
 kvmlock, for documentation
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Invoke kvmclock_cpu_action() with AP_ONLINE and BSP_RESUME, even though
kvmclock doesn't need to do anything in either case, so that the asymmetry
of kvmclock is a detail buried in kvmclock, and to explicitly document
that doing nothing during those phases is intentional and correct.

For all intents and purposes, no functional change intended.

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
index fd1c417b4f9b..2ed4bf13e3ed 100644
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
@@ -750,7 +756,7 @@ static int kvm_suspend(void *data)
 
 static void kvm_resume(void *data)
 {
-	kvm_cpu_online(raw_smp_processor_id());
+	__kvm_cpu_online(raw_smp_processor_id(), KVM_GUEST_BSP_RESUME);
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL) && has_guest_poll)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index cd65ad328637..d122912b8856 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -129,7 +129,7 @@ static void kvm_save_sched_clock_state(void)
 #ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
-	kvm_register_clock("secondary cpu clock");
+	kvm_register_clock("secondary cpu, startup");
 }
 #endif
 
@@ -153,13 +153,34 @@ static void kvmclock_resume(struct clocksource *cs)
 
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
@@ -360,7 +381,7 @@ void __init kvmclock_init(bool prefer_tsc)
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
 	this_cpu_write(hv_clock_per_cpu, &hv_clock_boot[0]);
-	kvm_register_clock("primary cpu clock");
+	kvm_register_clock("primary cpu, online");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
-- 
2.54.0.823.g6e5bcc1fc9-goog

