Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6C6230D0A
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622792; cv=none; b=sR482UgO3jS/M4oh5W02Jyogb6EOz11OKG0fMwEEr5BepR8Y9JZxRXgYOO2IVSTfkIF9ZNs8OL0ZwLsmExueNUeTPvgMOk81MvrVpOkMEsq4Bkgw3mPapP6unS1LJAEgyZdXMQdVi1snMw0mi2sokbjHJWbLYJadishtLTV1pZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622792; c=relaxed/simple;
	bh=qxvHP66lsjRniK4FyS4w/nVcINWk6vqDJhVEUffkgUc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R7qWyjKcileF5Tn3Q7WeeqJ+rD/+MQeuNyIC+dYXki/TZ2WtpZ5YzgodWmGL74XPRI99pVfkHh+0pTxdRvvQOMgARen+Mj0THAbK59FNNDO+LskrHPq1VJh3P6RtBfKlQQvU2c9eMWI0luq6SFkuDRci6JYjrkQLOmbPvWV3vHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nCartQjV; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nCartQjV"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f81a0d0a18so1091738a91.3
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622790; x=1741227590; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QzXAit3+eiuwe2E434PEIcPVDj3bfcCBW02+u03qap4=;
        b=nCartQjVL16urzSCYWT/FK+Zkiry3KLVGx3fxbY7vH5lUAtKKofYTUDcqUMpY7G3L9
         e2BkF7zixJWybQ2C9Wlb33BDAzp+PMs/l/GRZcaZHkC4YDPgIolzSaoLoVLlJf1zMPqk
         KHrujYR5AfdaGdRkELVQxO0ArslqVT2/oYFwX8tRxoO5T1FXOjx3azqdqBcRhKnYlLz1
         1GsGUkdl0Ut+uiRh9nGB3rmeveOQsV+EQWLvVA2eJiIwJd6lr19K6szSO5YIUlwHJxd/
         VpcdeZ7Wk/5+5p8QvGc+YqC9eAnlC5HBXkss1dEocYHO5Cd37xJ79TWnw21cy5ONUNLh
         Cwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622790; x=1741227590;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QzXAit3+eiuwe2E434PEIcPVDj3bfcCBW02+u03qap4=;
        b=QGka778Ya76Q+87IyCvbqfqzp4bBtKm7bUCscBDeoXplzWAHdAru7bpRiYilZYwWAa
         7t1MwusFDFlXoZ0kFWDAUVFjyhHAIQ4kyyioBOgvUtDd7hOZcANkDwdYq7dfPLIuVTGk
         yzntLbE8YIgESPpA3CmggiIBX78Fl5fEPnzmttnPIzWWHu89wNKwtxDRgBVbu7q4xkzy
         leAGcBGCFkBzmb7qH3e2v+rcJKN/tTx3f+J94uys2fagG36vZmf5oDgKmE9dN479TpjO
         eEAw5yTQ41fupGgER6vnVojRtMTtAQuw7KSghDzz/idxUIcK+wLrZGdm6xWql28nUlnS
         PETg==
X-Forwarded-Encrypted: i=1; AJvYcCXcDBMSfJEg+mtuG4pqCdzJBiG24KxjBqvJEtmAfQuUiJufZ9L7US+3EREnXqDa+70tJBvbVdp7GBAbVEV/fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YytqtsvCXlIRf4zf3a8lQoZly04qIew9Dbg4+5cRA/imcigDgPS
	OaZe6IGBmWRcubVISslgZIci9/IkZ3Wf+yFo+7zel2tF9n5vVSGl+DZazfjj1MENPgk9YZBLyTP
	FDQ==
X-Google-Smtp-Source: AGHT+IEy19UXAGhpZ6BooyEkiFGbgvHpy57ZvxRHzoGzPaLhW9PSe6CovWEb42HIAZDNRdCcii7axkfnXfc=
X-Received: from pjbsh13.prod.google.com ([2002:a17:90b:524d:b0:2ee:53fe:d0fc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5385:b0:2f5:63a:449c
 with SMTP id 98e67ed59e1d1-2fe68cf4000mr14888818a91.28.1740622789852; Wed, 26
 Feb 2025 18:19:49 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:43 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-28-seanjc@google.com>
Subject: [PATCH v2 27/38] x86/kvmclock: Enable kvmclock on APs during onlining
 if kvmclock isn't sched_clock
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

In anticipation of making x86_cpuinit.early_percpu_clock_init(), i.e.
kvm_setup_secondary_clock(), a dedicated sched_clock hook that will be
invoked if and only if kvmclock is set as sched_clock, ensure APs enable
their kvmclock during CPU online.  While a redundant write to the MSR is
technically ok, skip the registration when kvmclock is sched_clock so that
it's somewhat obvious that kvmclock *needs* to be enabled during early
bringup when it's being used as sched_clock.

Plumb in the BSP's resume path purely for documentation purposes.  Both
KVM (as-a-guest) and timekeeping/clocksource hook syscore_ops, and it's
not super obvious that using KVM's hooks would be flawed.  E.g. it would
work today, because KVM's hooks happen to run after/before timekeeping's
hooks during suspend/resume, but that's sheer dumb luck as the order in
which syscore_ops are invoked depends entirely on when a subsystem is
initialized and thus registers its hooks.

Opportunsitically make the registration messages more precise to help
debug issues where kvmclock is enabled too late.

Opportunstically WARN in kvmclock_{suspend,resume}() to harden against
future bugs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  2 ++
 arch/x86/kernel/kvm.c           | 24 +++++++++++-------
 arch/x86/kernel/kvmclock.c      | 44 +++++++++++++++++++++++++++------
 3 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 8708598f5b8e..42d90bf8fde9 100644
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
index 866b061ee0d9..5f093190df17 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -461,18 +461,24 @@ static void kvm_guest_cpu_offline(enum kvm_guest_cpu_action action)
 	kvmclock_cpu_action(action);
 }
 
+static int __kvm_cpu_online(unsigned int cpu, enum kvm_guest_cpu_action action)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	kvmclock_cpu_action(action);
+	kvm_guest_cpu_init();
+	local_irq_restore(flags);
+	return 0;
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
-	return 0;
+	return __kvm_cpu_online(cpu, KVM_GUEST_AP_ONLINE);
 }
 
-#ifdef CONFIG_SMP
-
 static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
 
 static bool pv_tlb_flush_supported(void)
@@ -737,7 +743,7 @@ static int kvm_suspend(void)
 
 static void kvm_resume(void)
 {
-	kvm_cpu_online(raw_smp_processor_id());
+	__kvm_cpu_online(raw_smp_processor_id(), KVM_GUEST_BSP_RESUME);
 
 #ifdef CONFIG_ARCH_CPUIDLE_HALTPOLL
 	if (kvm_para_has_feature(KVM_FEATURE_POLL_CONTROL) && has_guest_poll)
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 0ce23f862cbd..76884dfc77f4 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -52,6 +52,7 @@ static struct pvclock_vsyscall_time_info *hvclock_mem;
 DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
 
+static bool kvmclock_is_sched_clock;
 static bool kvmclock_suspended;
 
 /*
@@ -128,7 +129,7 @@ static void kvm_save_sched_clock_state(void)
 #ifdef CONFIG_SMP
 static void kvm_setup_secondary_clock(void)
 {
-	kvm_register_clock("secondary cpu clock");
+	kvm_register_clock("secondary cpu, sched_clock setup");
 }
 #endif
 
@@ -140,25 +141,51 @@ static void kvm_restore_sched_clock_state(void)
 
 static void kvmclock_suspend(struct clocksource *cs)
 {
+	if (WARN_ON_ONCE(kvmclock_is_sched_clock))
+		return;
+
 	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
 static void kvmclock_resume(struct clocksource *cs)
 {
+	if (WARN_ON_ONCE(kvmclock_is_sched_clock))
+		return;
+
 	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, clocksource resume");
 }
 
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
+		 * Secondary CPUs use dedicated sched_clock hooks to enable
+		 * kvmclock early during bringup, there's nothing to be done
+		 * when during CPU online.
+		 */
+		if (kvmclock_is_sched_clock)
+			break;
+		kvm_register_clock("secondary cpu, online");
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
@@ -313,6 +340,7 @@ static void __init kvm_sched_clock_init(bool stable)
 	kvm_sched_clock_offset = kvm_clock_read();
 	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
 				   kvm_save_sched_clock_state, kvm_restore_sched_clock_state);
+	kvmclock_is_sched_clock = true;
 
 	/*
 	 * The BSP's clock is managed via dedicated sched_clock save/restore
@@ -356,7 +384,7 @@ void __init kvmclock_init(void)
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
 	this_cpu_write(hv_clock_per_cpu, &hv_clock_boot[0]);
-	kvm_register_clock("primary cpu clock");
+	kvm_register_clock("primary cpu, online");
 	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT)) {
-- 
2.48.1.711.g2feabab25a-goog

