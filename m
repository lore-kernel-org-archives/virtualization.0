Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5C3F58D1
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067282; cv=none; b=lMST+rlThoixmIwksw0X2Xq2uZWWumJlGayi4314HTZ3sASzrgmAUIywtWL0/jQxx/zfqDM7hsrJYmwt0rn8IZHyY0+dsqZ8voqv0QF+jbDSGJl9qxUNERl1T++Lxzgd2UNu7+pGQDcwj952zb6J828h1SlHOoWvIaMGmV9BQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067282; c=relaxed/simple;
	bh=vgkgKjbJSAxudvNSvuXfvrLz/+GKydFGbDPMXU1N0T0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nBPkjYaPT8kai6xMKl96HTIRarpnwXX87qSRQXz8LJmw1u7zqKAtpjolHoCPTrEZ7QrW3HQq4fyO9xecNU7rd5WFYFbSuhjj2DMpgrD7g6UVL6xw8HsJoot6Qpu/H0RZ0PD+gpg8U1TwboO2gjdLv0vBYifpJfIREsTgRtCAo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYhPOoJ9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYhPOoJ9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc6899bfb1so152290535ad.2
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067280; x=1780672080; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=x48EAn3xKSGkzUgWryz9swjOD88igI5uWtnxtPJbQF4=;
        b=VYhPOoJ9es/QTVVQb6PaQQXTAeGJgqn1EeKH06vUzupWgo8eHOeSoXrBhXmhBhmbGv
         LZ1r1ynGYTSBjtR9zBBfE+Nnp6qKSP2jgVLpzyR9MCEUQadHTna1fq9IDxMw6q6nRjzc
         iuF3KFPujsmvMdw3GStu31xWX3GlZHVmJJMFsfcSAwRG8W8f0TbEGIqeCwcUgFfUJmIl
         5xoCWUeoDCju6i9cdsVz67qSbZgePrMoTUIWRBNB/XTfSjs4kOG+R1/NQ345vsgwlZyP
         cBVEX2AXOp+kTR58Rnp0k56ggebvgUfwhGIHLM81h1/EbmKEqDvgXRZLB1OWeE9kHvfH
         zsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067280; x=1780672080;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x48EAn3xKSGkzUgWryz9swjOD88igI5uWtnxtPJbQF4=;
        b=R1yMFstGcxdb789iUeQbgx4RvLTBmwlhyXhQpb2IG5fZdwXfYIcIF9H6gCxyQVEqte
         ezTdyYOwZeHMveTnL0/FsygsLKK7UlNw9+tCEuLJt3B66NPsM765F2/qoDLlUY6upwsI
         SncnJdf85X5b8i/OiysGNBxxgrmjzbgH/xE1XeYGtztwzf2GgHAQZTKyon/3gLEx/PF8
         cbsgwKsh8k/DM/CTFE34BP+l/zhEbrMdImPF0JTzH4MSCfw3gTgn/fMmMy1X0WdJLE8k
         5cMsfkHEQpSWA+n5xBMVTuaRl8NCxbn9SFb6fIm0m0z0kHqxEPTiIXjSpM6liHJwRteG
         tpqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Kv6RK8Yc2hrhUbYABHzxKv1wm/u7FYXF1oTcLOY9V+LOTdoMRzUhgOjc30Kc9Nc1X1z995LzdDy46KAwPNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0BjEz7g8WzNFLNPg8OWFzo7ySIdn9lQDE0tCje8DVR+7EdaY7
	uyIUHydv4BFAD3oy65I+PmDYT4Zl6RVVxbUBb5J698IvdezapJvrkmIZbQ7kvnyRMpOgrcpLTiy
	cCg8m/Q==
X-Received: from plbkk16.prod.google.com ([2002:a17:903:710:b0:2b4:62bc:c2a9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:903:b0:2bf:2e9:bd6d
 with SMTP id d9443c01a7336-2bf367be098mr3118615ad.12.1780067280044; Fri, 29
 May 2026 08:08:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:58 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150758.714420-1-seanjc@google.com>
Subject: [PATCH v4 33/47] x86/paravirt: Pass sched_clock save/restore helpers
 during registration
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

Pass in a PV clock's save/restore helpers when configuring sched_clock
instead of relying on each PV clock to manually set the save/restore hooks.
In addition to bringing sanity to the code, this will allow gracefully
"rejecting" a PV sched_clock, e.g. when running as a CoCo guest that has
access to a "secure" TSC.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h       | 9 ++++++---
 arch/x86/kernel/cpu/vmware.c       | 8 +++-----
 arch/x86/kernel/kvmclock.c         | 6 +++---
 arch/x86/kernel/tsc.c              | 5 ++++-
 arch/x86/xen/time.c                | 5 ++---
 drivers/clocksource/hyperv_timer.c | 6 ++----
 6 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index fe41d40a9ae6..e97cd1ae03d1 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,11 +14,14 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable);
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				void (*save)(void), void (*restore)(void));
 
-static inline void paravirt_set_sched_clock(u64 (*func)(void))
+static inline void paravirt_set_sched_clock(u64 (*func)(void),
+					    void (*save)(void),
+					    void (*restore)(void))
 {
-	__paravirt_set_sched_clock(func, true);
+	__paravirt_set_sched_clock(func, true, save, restore);
 }
 #endif
 
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 051ef89029a7..f3ffc05c7c53 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -347,11 +347,9 @@ static void __init vmware_paravirt_ops_setup(void)
 
 	vmware_cyc2ns_setup();
 
-	if (vmw_sched_clock) {
-		paravirt_set_sched_clock(vmware_sched_clock);
-		x86_platform.save_sched_clock_state = x86_init_noop;
-		x86_platform.restore_sched_clock_state = x86_init_noop;
-	}
+	if (vmw_sched_clock)
+		paravirt_set_sched_clock(vmware_sched_clock,
+					 x86_init_noop, x86_init_noop);
 
 	if (vmware_is_stealclock_available()) {
 		has_steal_clock = true;
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0d4f2cf97246..05bca2be0df3 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -137,7 +137,9 @@ static void kvm_restore_sched_clock_state(void)
 static inline void kvm_sched_clock_init(bool stable)
 {
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
@@ -345,8 +347,6 @@ void __init kvmclock_init(bool prefer_tsc)
 #ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
-	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-	x86_platform.restore_sched_clock_state = kvm_restore_sched_clock_state;
 	kvm_get_preset_lpj();
 
 	/*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 19da1a3d2126..7fbcfc2efd1d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,12 +280,15 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable,
+				void (*save)(void), void (*restore)(void))
 {
 	if (!stable)
 		clear_sched_clock_stable();
 
 	static_call_update(pv_sched_clock, func);
+	x86_platform.save_sched_clock_state = save;
+	x86_platform.restore_sched_clock_state = restore;
 }
 #else
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 640b71d22d97..91ef83b1e540 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -577,13 +577,12 @@ static void __init xen_init_time_common(void)
 {
 	xen_sched_clock_offset = xen_clocksource_read();
 	static_call_update(pv_steal_clock, xen_steal_clock);
-	paravirt_set_sched_clock(xen_sched_clock);
+
 	/*
 	 * Xen has paravirtualized suspend/resume and so doesn't use the common
 	 * x86 sched_clock save/restore hooks.
 	 */
-	x86_platform.save_sched_clock_state = x86_init_noop;
-	x86_platform.restore_sched_clock_state = x86_init_noop;
+	paravirt_set_sched_clock(xen_sched_clock, x86_init_noop, x86_init_noop);
 
 	x86_init.hyper.get_tsc_khz = xen_tsc_khz;
 	x86_platform.get_wallclock = xen_get_wallclock;
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ac1d9f9c381c..dee59ce61c29 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -553,10 +553,8 @@ static void hv_restore_sched_clock_state(void)
 static __always_inline void hv_setup_sched_clock(void *sched_clock)
 {
 	/* We're on x86/x64 *and* using PV ops */
-	paravirt_set_sched_clock(sched_clock);
-
-	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
-	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
+	paravirt_set_sched_clock(sched_clock, hv_save_sched_clock_state,
+				 hv_restore_sched_clock_state);
 }
 #else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
-- 
2.54.0.823.g6e5bcc1fc9-goog

