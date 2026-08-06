Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D14A970D
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059432; cv=none; b=V9k4ud3UqWncYaG8/90i1BKvtN0u3zUDWJJb+hMINr6eq2rnE6CdMIwyhfSjf+Iwctzu5h9L6jUx9fh1gizHPWNzTCd9ge8s1DC8MH3DmJC50g+HWkFzwdwLjHd+Zbo4Yp4p/SpGDmLqucAB6DD8CcVTMMJg9EhQ48IZ0775k/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059432; c=relaxed/simple;
	bh=YgMzpUMx8xHWU9hl5Ir/Bh8NISf16vz/qFAMq5wPe60=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bnvjk36s/XjzTNwiAEOFJPgD2jCeOyvR4aVj7qSDFx0KJc0NZ5wdJ9Su3TZyYW8uYIuEuFNviJkBcn+COpTTlKgCzi09dE4FRmHcORb8YCoj0v3WL9Nl62qiOB5Ui5P1O3UkSpatCiwluSl6pwU1hi5daP/2R6G/f9PtFXUyh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nnvZtL3/; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nnvZtL3/"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc6dd43737so50911285ad.2
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059429; x=1786664229; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bZd2/vTLw6kP6aan4oVP2ByAHPA3GmOMxUTn1c9gmLc=;
        b=nnvZtL3/MJvb/mPddsQfq9Dvom4WM+tRFsBC+V3JrYh8XppsLAO6UBQSPCWCumAKYp
         3yJlPms/FaliqZ/uz+QZUAunpssClbbRxUrZ2MSiEYiMAERGydNsO4ibjhMt3ovyQSgr
         8cI0U8GGeF6snyXMjFZ11Pe4cCNYI/ckIL0x3VbUl1bPgCcMNHcuAlA9DDEGXWDQk/Ra
         937m/kIcFCXLqX8Iv7EcsltKLDBw7t7CPgd+u1ZjfFQdkA/q8jWZmByoGvMiUIUWUHWT
         feQ2Ei0nQ1HApeOlZoZ83GXm5d7zi35LaIhmshsGIDpXej03PRuborEVGfaH1FoT8BB1
         UkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059429; x=1786664229;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZd2/vTLw6kP6aan4oVP2ByAHPA3GmOMxUTn1c9gmLc=;
        b=rctF3LoE6JTgKxOCIugFSbWaVUpJxg3B7p8cdHrJxlcIJOnb9OG7YT4OvlFiiDfk79
         hXm1hG6m1+HL6gp0qtMGYFLoRxh5ni4Au17We0V95y3U69gH4g0Ic0nmX7zhuRGUL5Yu
         pjsP30F5YnPPd8PlOmnZsVXMT4Hm1vtlMto6zy8r2D9jB1mD0mMGseHhp9i1cAVRYyBC
         PW/8/NQlhY9qXz0vH1LWN72X6RFPh/Spl1QNjfnUjOzIfx+VLB4czEbXkXhLuxgsJuTy
         Eqii8CqBRsAKQq+tb6sqEi86OCY4uutRH41Gbogx7HuCWz0LQddhvEsvdjNMrYApYeee
         b2Vg==
X-Forwarded-Encrypted: i=1; AHgh+RpccgjDV+DDz16A2WtLjMYyGO35BbWsUdQoJvk4E/QbEZMtMY0H5foA+pmRRObiYC0jeq8vs8eYykuaVzpX1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyjt9QG4dAoNdMqGZqnkDFjD7NCbjdRylAK6b/pm5MKEjhMHHjQ
	4w2Ei3w4NKQt6NH7JOohFPJ2tqyigBnTxYd5eWmAbLi0phS+x3AaQtPffPxpvQ/4HBvhQ4ErgFJ
	PYGKmww==
X-Received: from pjtz20.prod.google.com ([2002:a17:90a:cb14:b0:36b:7f07:6fcd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c84:b0:38f:1e1a:515e
 with SMTP id 98e67ed59e1d1-3903c5b1688mr16494071a91.14.1786059429092; Thu, 06
 Aug 2026 16:37:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:53 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-37-seanjc@google.com>
Subject: [PATCH v6 36/51] x86/paravirt: Pass sched_clock save/restore helpers
 during registration
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

Pass in a PV clock's save/restore helpers when configuring sched_clock
instead of relying on each PV clock to manually set the save/restore hooks.
In addition to bringing sanity to the code, this will allow gracefully
"rejecting" a PV sched_clock, e.g. when running as a CoCo guest that has
access to a "secure" TSC.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
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
index 94fec990a02c..3598de5297f8 100644
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
index 07e875738c39..5b9955343199 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -158,7 +158,9 @@ static void kvm_restore_sched_clock_state(void)
 static inline void kvm_sched_clock_init(bool stable)
 {
 	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
@@ -367,8 +369,6 @@ void __init kvmclock_init(bool prefer_tsc)
 #ifdef CONFIG_SMP
 	x86_cpuinit.early_percpu_clock_init = kvm_setup_secondary_clock;
 #endif
-	x86_platform.save_sched_clock_state = kvm_save_sched_clock_state;
-	x86_platform.restore_sched_clock_state = kvm_restore_sched_clock_state;
 	kvm_get_preset_lpj();
 
 	/*
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 60fcc3020792..d4f7cb127235 100644
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
index 477441752f40..8cd8bfaf1320 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -566,13 +566,12 @@ static void __init xen_init_time_common(void)
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
index 220668207d19..8ee7a9de0f4f 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -570,10 +570,8 @@ static void hv_restore_sched_clock_state(void)
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
2.55.0.679.g6767b8d81c-goog

