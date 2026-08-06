Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD474A6543
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059423; cv=none; b=ckKniwo0c0YMkeps5h5uz7HwMYlcXaSEGgUJx1hj1s/ZUfmZLCUy5NC2jBR40xjB8Z05larMC1qO/VVRy3SWZ23J+cWJL1qEa2WanzkdRfV7TJA80VaFhjxoUsB89OwFqXMqJ8nnNCRGoIkUOcMtNGUBuifsHogn8tPJJwiyUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059423; c=relaxed/simple;
	bh=rWbS/5EcUfIGw+MDz630kobNACYbTmDG/E889zv4mS0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tEvkYpL5PCX5i+/5kohulcOivbtYJQFv5xtlM5mTbkwAAr2xiLi284Uvm4yGS9ngCxL8/a9n32gIATe4T0ltQoaDIfzKqFAmlULQOlUASHfqf6C0lwmRnvEWjAsVqzNYgUgGx+RwZrrkBxSh/bNT9dz2MA7uZjsXs2OBQM1RGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q2y723gH; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q2y723gH"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84a67b16217so4508397b3a.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059421; x=1786664221; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=o8F+mGATSkCnO7RB7Nrhalcr3db+GPA7pyXAMrOPMa0=;
        b=Q2y723gHTgHmzd3p1+kIbsMpg78L2mhcycZPGZ9Yo9BnLmU+a2XSI52mvqyG3nGigg
         lkLpf3hR43hvK5iggolEoSsIWeoUBhqPWqAz3+WZEUbeVn5vv7L1NXtuhTRUKmJ7y3Xh
         a+McO/J4O63nY4l0Bz04Cwug/t0/xErbshhk+0W0AMZz4Yw0e9qhkV1weAEPK7Ymy/hC
         kQ3nWhjefwza14C/1v/jVJXz3a27hZVFEqvDZ1O/OthqQGZ/US2PM42TORwMqLlp+n5M
         fzdrLxFZwKJVg9FrjXKfkeGXhQ4opkfPKPsVRVTEMfVdqD2V0dbjgFcbxO3/UrQJcY99
         2muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059421; x=1786664221;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o8F+mGATSkCnO7RB7Nrhalcr3db+GPA7pyXAMrOPMa0=;
        b=Ppd38RWgGucm0TtpOapvHRCr5uZ1xasD8JobFMmNl20RDMb2gaiYnjlaqfYq1Wh5oD
         k51uDtgD2R0voDrS0wWP+OxUcAtm5G++e2Dv3Ego7A+7fAzN6SeWbiKoC1HENowDczez
         MeR3qgm0f2YRU5T/BfbnrfcOMicRfGphxuano6urc4W43NTOdx11x48+0q12GY67XPpI
         K/PQkqPDXkYqA9e/1cpr6dsAnmyrOq6Qg5yS4G6u+vn968ifusTMbRW8LyuSghqYRLuR
         tYGmCHWY7xhti+AsgkK/88ydRrLOPkq/Q3r/FTjFg74H+hOaTniiZvEGW9ztJRYttxMM
         6sRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnLn/v3cPsZ1vAsFGXALGRPIqxpmPBv3QPpGueSgl6kFj2yUI2Cat6/PlB3doXdp/LN+Q2CV9KfXbEYc1W7A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfVXEEInN5FQ0FVkFrIWUBmc+/sZXra7CvDXhEggI4I9LLAhNN
	ipnnyzaesjvOGoPC1PGjHXt75ZbEL9gmFdAC6DhhzRlatHjfeko/Al5NKLSuZDeA0tAWxwkC9wR
	cev3qmQ==
X-Received: from pfwp49.prod.google.com ([2002:a05:6a00:26f1:b0:84a:894f:23f2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1daa:b0:848:401c:98e
 with SMTP id d2e1a72fcca58-84f2e0432a7mr20883725b3a.15.1786059420393; Thu, 06
 Aug 2026 16:37:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:46 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-30-seanjc@google.com>
Subject: [PATCH v6 29/51] x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
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

Don't disable kvmclock on the BSP during syscore_suspend(), as the BSP's
clock is NOT restored during syscore_resume(), but is instead restored
earlier via the sched_clock restore callback.  If suspend is aborted, e.g.
due to a late wakeup, the BSP will run without its clock enabled, which
"works" only because KVM-the-hypervisor is kind enough to not clobber the
shared memory when the clock is disabled.  But over time, the BSP's view
of time will drift from APs.

Plumb in an "action" to KVM-as-a-guest and kvmclock code in preparation
for additional cleanups to kvmclock's suspend/resume logic.

Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
Cc: stable@vger.kernel.org
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  8 +++++++-
 arch/x86/kernel/kvm.c           | 15 ++++++++-------
 arch/x86/kernel/kvmclock.c      | 31 +++++++++++++++++++++++++------
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 4a49fc286b4c..08686ff19caa 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -118,8 +118,14 @@ static inline long kvm_sev_hypercall3(unsigned int nr, unsigned long p1,
 }
 
 #ifdef CONFIG_KVM_GUEST
+enum kvm_guest_cpu_action {
+	KVM_GUEST_BSP_SUSPEND,
+	KVM_GUEST_AP_OFFLINE,
+	KVM_GUEST_SHUTDOWN,
+};
+
 void kvmclock_init(bool prefer_tsc);
-void kvmclock_disable(void);
+void kvmclock_cpu_action(enum kvm_guest_cpu_action action);
 bool kvm_para_available(void);
 unsigned int kvm_arch_para_features(void);
 unsigned int kvm_arch_para_hints(void);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 83b9351f2810..9c0b2fc98cc9 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -460,7 +460,7 @@ static void __init sev_map_percpu_data(void)
 	}
 }
 
-static void kvm_guest_cpu_offline(bool shutdown)
+static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
 {
 	kvm_disable_steal_time();
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
@@ -468,9 +468,10 @@ static void kvm_guest_cpu_offline(bool shutdown)
 	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
 		wrmsrq(MSR_KVM_MIGRATION_CONTROL, 0);
 	kvm_pv_disable_apf();
-	if (!shutdown)
+	if (action != KVM_GUEST_SHUTDOWN)
 		apf_task_wake_all();
-	kvmclock_disable();
+
+	kvmclock_cpu_action(action);
 }
 
 static int kvm_cpu_online(unsigned int cpu)
@@ -728,7 +729,7 @@ static int kvm_cpu_down_prepare(unsigned int cpu)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	kvm_guest_cpu_offline(false);
+	kvm_guest_cpu_offline(KVM_GUEST_AP_OFFLINE);
 	local_irq_restore(flags);
 	return 0;
 }
@@ -739,7 +740,7 @@ static int kvm_suspend(void *data)
 {
 	u64 val = 0;
 
-	kvm_guest_cpu_offline(false);
+	kvm_guest_cpu_offline(KVM_GUEST_BSP_SUSPEND);
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL))
@@ -770,7 +771,7 @@ static struct syscore kvm_syscore = {
 
 static void kvm_pv_guest_cpu_reboot(void *unused)
 {
-	kvm_guest_cpu_offline(true);
+	kvm_guest_cpu_offline(KVM_GUEST_SHUTDOWN);
 }
 
 static int kvm_pv_reboot_notify(struct notifier_block *nb,
@@ -794,7 +795,7 @@ static struct notifier_block kvm_pv_reboot_nb = {
 #ifdef CONFIG_CRASH_DUMP
 static void kvm_crash_shutdown(struct pt_regs *regs)
 {
-	kvm_guest_cpu_offline(true);
+	kvm_guest_cpu_offline(KVM_GUEST_SHUTDOWN);
 	native_machine_crash_shutdown(regs);
 }
 #endif
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index b0c871ba8232..a3ec298d56d7 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -199,8 +199,22 @@ static void kvm_register_clock(char *txt)
 	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
 }
 
+static void kvmclock_disable(void)
+{
+	if (msr_kvm_system_time)
+		native_write_msr(msr_kvm_system_time, 0);
+}
+
 static void kvm_save_sched_clock_state(void)
 {
+	/*
+	 * Stop host writes to kvmclock immediately prior to suspend/hibernate.
+	 * If the system is hibernating, then kvmclock will likely reside at a
+	 * different physical address when the system awakens, and host writes
+	 * to the old address prior to reconfiguring kvmclock would clobber
+	 * random memory.
+	 */
+	kvmclock_disable();
 }
 
 static void kvm_restore_sched_clock_state(void)
@@ -208,6 +222,17 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
+void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
+{
+	/*
+	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
+	 * being used for sched_clock, then it needs to be kept alive until the
+	 * last minute, and restored as quickly as possible after resume.
+	 */
+	if (action != KVM_GUEST_BSP_SUSPEND)
+		kvmclock_disable();
+}
+
 #ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
@@ -215,12 +240,6 @@ static void kvm_setup_secondary_clock(void)
 }
 #endif
 
-void kvmclock_disable(void)
-{
-	if (msr_kvm_system_time)
-		native_write_msr(msr_kvm_system_time, 0);
-}
-
 static void __init kvmclock_init_mem(void)
 {
 	unsigned long ncpus;
-- 
2.55.0.679.g6767b8d81c-goog

