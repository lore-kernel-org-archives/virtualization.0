Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9C49A22D
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059405; cv=none; b=UtgYNvBF6cKGuLkh/WSVYgdKUVRb/4szY2DNpaP1PGQTxwR+sBvubJbHDYAJDFvJT6oAhZw5w2FJlIn4obbiSiO/+29cvhe4ZOSonI1Bvl51Hrl4iIyr0mRf/B+/9IOCT+cyNy6+DG6TdlnlpnRJuvwmcuglReCgX644TRzj+oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059405; c=relaxed/simple;
	bh=5EQ2Y/7/FNva86+E9j6gKcmQXh6x7dP7WF5CCExJXh8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ye8a+A9SD8ropn+kNPbVt5t4m48aU0LUFKUMQjLdG0qIXB6TY36kbC0H7DjbZhkhrURHYV5/S0cAPBJ0RTTrjrwAHO+tJmhlJN10E7Y04VQXzjqfPZETx+g27n6QNNMKSd758Baaf9WKnpwhwcTBuR54IHU6KJPAVGz0MSug6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4esT6cd; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4esT6cd"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e7621655eso4064616a91.0
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059402; x=1786664202; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wbY0NuQ4jmVaTb967BiKKQEFZ81rzIFWsnI6s/GLKnk=;
        b=g4esT6cdXWazcsVgmHtlQJqFlnwPUDXfra67MFvHrIz2DMiCZcH82QuBV28Unl+JZy
         GZcmINnPpXAq67W7X5HolNqbmhLUjon6uQRDiDqhcfv63e2wE0mrdf9M0EWgV9dSslRX
         a9VskRDf2QvkpqVZz2eZ5A0A2wzWKo2JEq1YujOovRke109EKv9OIqn0CuNqCXxTMGBQ
         EPfrxNCsP5mQlDxY5HrdzLopqkRbiRya3RTYKhMyP6r3Bb+Ik8OYjAewcgBaflL3kWaN
         aPt/E1RphQ9CpI/gF4/E+FNVCBU/hnTXr52tV4pLvKv/Gs0KSRgOpMX8UpRO4lFJaJH+
         ppAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059402; x=1786664202;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wbY0NuQ4jmVaTb967BiKKQEFZ81rzIFWsnI6s/GLKnk=;
        b=Ss8F8xqxj2B+Khu3RgXOCVgIJMcM97ktmFGclf25z+GS+ffa3hJUweAMSCHL18eU+G
         kCByya3jZmQ9+yUXJ3BoUSjHxUbrzPXjC2Y9JsT94g1v1BUsOnptlhtj+BXj3tjZvcUZ
         tkUXeVHl/Es50rarba2QxCvILzE3v4E00SpbBN2iSnfq82n0yw2AxqBqZFogJfnZ72yN
         /WClMkELUQP3WanPAJYuEtvNmeQ6BK0f4o3mFw6v6MfZ708ikjg7RSWJtjs9sQ/1iIHM
         Rp1gSNMMj7WWJkDSCFMRZiqy3OFs+2RqeM5EofK7G2KGRJX5Mcj4CyeBPOQ853tkon3T
         PTtw==
X-Forwarded-Encrypted: i=1; AHgh+RqCg69309ADZxC9pXtoHXGXzvqF0+3Ps5wPs3C2TmiTJiAci11CABpbTTGnTJOnR0JE/JW1JktaDHrqDrvkvg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7pjAoKEYzcDYt355bLLArKvfiX+zgw+dZDcSiGSHvtDT2f+Am
	2rt5ZXy7KsliCYZ1ZIMckz8LjcRIRpVSJbywfzIYuL7DNp+YNog5L5NYMpz3yXR6lyvd5UyW4GZ
	in/TlLw==
X-Received: from pjbcv18.prod.google.com ([2002:a17:90a:fd12:b0:38e:7f2c:2c4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:264c:b0:37f:e326:6557
 with SMTP id 98e67ed59e1d1-3903c598e8amr20096574a91.4.1786059402046; Thu, 06
 Aug 2026 16:36:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:32 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-16-seanjc@google.com>
Subject: [PATCH v6 15/51] x86/tsc: Kill off x86_platform_ops.calibrate_{cpu,tsc}()
 hooks
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

Now that getting the CPU and/or TSC frequencies from the hypervisor uses
dedicated hooks, drop x86_platform_ops.calibrate_{cpu,tsc}() and instead
directly invoke the correct helper at each phase of (re)calibration.  In
addition to eliminating unnecessary code, this makes it a bit more obvious
when the "late" path invokes pit_hpet_ptimer_calibrate_cpu() instead of
x86_platform_ops.calibrate_cpu().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h      |  2 --
 arch/x86/include/asm/x86_init.h |  4 ----
 arch/x86/kernel/tsc.c           | 28 ++++++++++++----------------
 arch/x86/kernel/x86_init.c      |  2 --
 4 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index b6b86e24e1bf..c09ec485abcd 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -95,8 +95,6 @@ extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
 extern void mark_tsc_async_resets(char *reason);
-extern unsigned long native_calibrate_cpu_early(void);
-extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
 
 extern int tsc_clocksource_reliable;
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 0c89bf40f507..e879e6e83428 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -295,8 +295,6 @@ struct x86_hyper_runtime {
 
 /**
  * struct x86_platform_ops - platform specific runtime functions
- * @calibrate_cpu:		calibrate CPU
- * @calibrate_tsc:		calibrate TSC, if different from CPU
  * @get_wallclock:		get time from HW clock like RTC etc.
  * @set_wallclock:		set time back to HW clock
  * @iommu_shutdown:		set by an IOMMU driver for shutdown if necessary
@@ -320,8 +318,6 @@ struct x86_hyper_runtime {
  * @guest:			guest incarnations callbacks
  */
 struct x86_platform_ops {
-	unsigned long (*calibrate_cpu)(void);
-	unsigned long (*calibrate_tsc)(void);
 	void (*get_wallclock)(struct timespec64 *ts);
 	int (*set_wallclock)(const struct timespec64 *ts);
 	void (*iommu_shutdown)(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index f42872c9ae99..1d41ef1db27c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -672,7 +672,7 @@ int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
-unsigned long native_calibrate_tsc(void)
+static unsigned long native_calibrate_tsc(void)
 {
 	struct cpuid_tsc_info info;
 
@@ -904,7 +904,7 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 /**
  * native_calibrate_cpu_early - can calibrate the cpu early in boot
  */
-unsigned long native_calibrate_cpu_early(void)
+static unsigned long native_calibrate_cpu_early(void)
 {
 	unsigned long flags, fast_calibrate = cpu_khz_from_cpuid();
 
@@ -918,7 +918,7 @@ unsigned long native_calibrate_cpu_early(void)
 	return fast_calibrate;
 }
 
-
+#ifndef CONFIG_SMP
 /**
  * native_calibrate_cpu - calibrate the cpu
  */
@@ -931,6 +931,7 @@ static unsigned long native_calibrate_cpu(void)
 
 	return tsc_freq;
 }
+#endif
 
 void recalibrate_cpu_khz(void)
 {
@@ -943,8 +944,8 @@ void recalibrate_cpu_khz(void)
 	if (WARN_ON_ONCE(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ)))
 		return;
 
-	cpu_khz = x86_platform.calibrate_cpu();
-	tsc_khz = x86_platform.calibrate_tsc();
+	cpu_khz = native_calibrate_cpu();
+	tsc_khz = native_calibrate_tsc();
 	if (tsc_khz == 0)
 		tsc_khz = cpu_khz;
 	else if (abs(cpu_khz - tsc_khz) * 10 > tsc_khz)
@@ -1458,17 +1459,19 @@ static bool __init determine_cpu_tsc_frequencies(bool early,
 	WARN_ON(cpu_khz || tsc_khz);
 
 	if (early) {
+		/*
+		 * Early CPU calibration can only use methods that are available
+		 * early in boot (obviously).
+		 */
 		if (known_cpu_khz)
 			cpu_khz = known_cpu_khz;
 		else
-			cpu_khz = x86_platform.calibrate_cpu();
+			cpu_khz = native_calibrate_cpu_early();
 		if (known_tsc_khz)
 			tsc_khz = known_tsc_khz;
 		else
-			tsc_khz = x86_platform.calibrate_tsc();
+			tsc_khz = native_calibrate_tsc();
 	} else {
-		/* We should not be here with non-native cpu calibration */
-		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
 		cpu_khz = pit_hpet_ptimer_calibrate_cpu();
 	}
 
@@ -1571,13 +1574,6 @@ void __init tsc_init(void)
 		return;
 	}
 
-	/*
-	 * native_calibrate_cpu_early can only calibrate using methods that are
-	 * available early in boot.
-	 */
-	if (x86_platform.calibrate_cpu == native_calibrate_cpu_early)
-		x86_platform.calibrate_cpu = native_calibrate_cpu;
-
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
 		if (!determine_cpu_tsc_frequencies(false, 0, 0)) {
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 252c5827d063..b7a48e622f48 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -147,8 +147,6 @@ static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
-	.calibrate_cpu			= native_calibrate_cpu_early,
-	.calibrate_tsc			= native_calibrate_tsc,
 	.get_wallclock			= mach_get_cmos_time,
 	.set_wallclock			= mach_set_cmos_time,
 	.iommu_shutdown			= iommu_shutdown_noop,
-- 
2.55.0.679.g6767b8d81c-goog

