Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3631E51FD
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622766; cv=none; b=bJsQ/0+zeDKIWEB10x2pC7ci7b1PIqjlWbqXYVr5NoqTwzLaOvGmj0D2Cr4FmvRn3ZAZKNLMGDjMqr/bybDwJa/YQDcA7iOdjCouV3DHutWKGUWh/HZETzbSthkJICYvXd4j/IxJZkKBc6g3AY6xGF6Lby4x/syj78HUAk54xGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622766; c=relaxed/simple;
	bh=pVoicbIwuy1mW6yiJjZE1VBeAcXEO4G9pyLaBIqAzFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LZHSP+qSOwMRvGqc+Ra5JHQomzxad1IazLB4clOXPj/pZRgdge6a7T1KyBONVGFfM98V1xTjfXYBs0pR/ahkIrNvbuKRtWxlOKXKa/GvE9JaLMv1xQplGM+a6K280+uA3Qwnvo+BBSqIpDvjtNPVwfLYNk81A4XvfP6UxrlBzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SnHTMkPo; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnHTMkPo"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220d8599659so8015605ad.0
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622764; x=1741227564; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=pWgviwpmhKNHN5XYXpAWmYugB+1r1OlVvpsKGRVLlVs=;
        b=SnHTMkPomcjHcBbbbYjTjduKB4poaYg6PvhH8OEYW8AevqJJBZ8GpUpZ6FrzNLMakK
         dBzIdq7gw+HIU0jQwd9YI6m5kppXLMzqpSTsDHbT+DzmJbU7ZiHWwxYuXZfJLaobC9en
         w/euwgwgLd4toRJ0K+oXcEBQnhWHAsvUhl9OIl+bx5W5dp/aG1GyHC4BQ2uxScEnBDRs
         d9IDj9nUCETjRxzKLGeBitQCaD/Ot4Wm108EItx/NT1oKsrJwrwA62vi/WNZK3JJ/QGE
         lZzCc0U4VXfdpaN0PxgGrGJzCHNgGVIJAp00CknVNo3MI6ijqdgLpcdsVFrafPqIGhbP
         7KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622764; x=1741227564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWgviwpmhKNHN5XYXpAWmYugB+1r1OlVvpsKGRVLlVs=;
        b=df3KkcCfeRBHlcSQ9aZh1doPWBP5GjK8AJdxx90wcxERTIx1+v4Bn9jb0x75uIgL5t
         Y7iKyWzvmZTvnuT+Z3xRb8Kedw4lsqx4WUYaB8MlOdn0Jld/n//PcQErIi72tHRBjJi8
         abSXF5354fcF1glb4TmUgBaILUNk6g0kQ2+t0y2FtTSTDYarlfPH9+N2BLDS6k/wCFKu
         6IuRKRxCh/96nVEnjWvXLnMIAmEuYXjz4lSfkxQ7Q/KK/APcRjLrycU5UYmbwp4ASdRA
         Z3pnmGCr3o9Slh1XTAwAXooMkSgGT2cMEM4z2o50nK7uwykngKUvDqFyI9zrWa0wH6uR
         +enA==
X-Forwarded-Encrypted: i=1; AJvYcCUSwfpW1bPksbSQCk0ZrmlSjT34ouhbyLAf65myIkh23uFDTtAwWtB7ywr+VC/4pwpYUQtNcFtyeff80Z971Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwUdMxgUTJROO3LYYUEiOL5c23Fe/2A45I2YmL9fVZ3AV8tJCSZ
	BZnE/RkA/rHF3VTI5Xqy6VRKLArixHGnrq6YatOevrZHzvsTMlWi/x/XGcBbCbkSrodKAuLke55
	Epw==
X-Google-Smtp-Source: AGHT+IGQazOm0zxmui59w45JCda9qTDjxRSvZp9ylt3tyNT0rDqeQIE65vrdsSLJOsVjaLh1NupfPRbt/dc=
X-Received: from plblo7.prod.google.com ([2002:a17:903:4347:b0:21f:429a:36ae])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ecca:b0:220:f06b:318
 with SMTP id d9443c01a7336-22320080b32mr91766195ad.14.1740622763961; Wed, 26
 Feb 2025 18:19:23 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:28 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-13-seanjc@google.com>
Subject: [PATCH v2 12/38] x86/kvm: Don't disable kvmclock on BSP in syscore_suspend()
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	John Stultz <jstultz@google.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>
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
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  8 +++++++-
 arch/x86/kernel/kvm.c           | 15 ++++++++-------
 arch/x86/kernel/kvmclock.c      | 31 +++++++++++++++++++++++++------
 3 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 57bc74e112f2..8708598f5b8e 100644
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
 void kvmclock_init(void);
-void kvmclock_disable(void);
+void kvmclock_cpu_action(enum kvm_guest_cpu_action action);
 bool kvm_para_available(void);
 unsigned int kvm_arch_para_features(void);
 unsigned int kvm_arch_para_hints(void);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7a422a6c5983..866b061ee0d9 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -447,7 +447,7 @@ static void __init sev_map_percpu_data(void)
 	}
 }
 
-static void kvm_guest_cpu_offline(bool shutdown)
+static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
 {
 	kvm_disable_steal_time();
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
@@ -455,9 +455,10 @@ static void kvm_guest_cpu_offline(bool shutdown)
 	if (kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
 		wrmsrl(MSR_KVM_MIGRATION_CONTROL, 0);
 	kvm_pv_disable_apf();
-	if (!shutdown)
+	if (action != KVM_GUEST_SHUTDOWN)
 		apf_task_wake_all();
-	kvmclock_disable();
+
+	kvmclock_cpu_action(action);
 }
 
 static int kvm_cpu_online(unsigned int cpu)
@@ -713,7 +714,7 @@ static int kvm_cpu_down_prepare(unsigned int cpu)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	kvm_guest_cpu_offline(false);
+	kvm_guest_cpu_offline(KVM_GUEST_AP_OFFLINE);
 	local_irq_restore(flags);
 	return 0;
 }
@@ -724,7 +725,7 @@ static int kvm_suspend(void)
 {
 	u64 val = 0;
 
-	kvm_guest_cpu_offline(false);
+	kvm_guest_cpu_offline(KVM_GUEST_BSP_SUSPEND);
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL))
@@ -751,7 +752,7 @@ static struct syscore_ops kvm_syscore_ops = {
 
 static void kvm_pv_guest_cpu_reboot(void *unused)
 {
-	kvm_guest_cpu_offline(true);
+	kvm_guest_cpu_offline(KVM_GUEST_SHUTDOWN);
 }
 
 static int kvm_pv_reboot_notify(struct notifier_block *nb,
@@ -775,7 +776,7 @@ static struct notifier_block kvm_pv_reboot_nb = {
 #ifdef CONFIG_CRASH_DUMP
 static void kvm_crash_shutdown(struct pt_regs *regs)
 {
-	kvm_guest_cpu_offline(true);
+	kvm_guest_cpu_offline(KVM_GUEST_SHUTDOWN);
 	native_machine_crash_shutdown(regs);
 }
 #endif
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 80d1a06609c8..223e5297f5ee 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -177,8 +177,22 @@ static void kvm_register_clock(char *txt)
 	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
 }
 
+static void kvmclock_disable(void)
+{
+	if (msr_kvm_system_time)
+		native_write_msr(msr_kvm_system_time, 0, 0);
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
@@ -186,6 +200,17 @@ static void kvm_restore_sched_clock_state(void)
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
@@ -193,12 +218,6 @@ static void kvm_setup_secondary_clock(void)
 }
 #endif
 
-void kvmclock_disable(void)
-{
-	if (msr_kvm_system_time)
-		native_write_msr(msr_kvm_system_time, 0, 0);
-}
-
 static void __init kvmclock_init_mem(void)
 {
 	unsigned long ncpus;
-- 
2.48.1.711.g2feabab25a-goog

