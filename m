Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671554DBD6D
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934369; cv=none; b=YLkkM1IUBY7PJXqdVfQyY0IP+PoROzynvQCRkBGX+E+4Gx8USPiz3l94YIu5LHuc3N0hrdaxS5VBP+6EQPBoXevMMYrOFZNsJNRhzmudo+NPaMb8c0B1WJNW428kBbWzKX+le5xJK8IwjXTvLD2UmugZlU+ZZgNWTSYpqjynaSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934369; c=relaxed/simple;
	bh=ywVnek+cEVC2k/cuJ8ePvC3c7xcwJ3EFd7KuSRcxIA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AHiGBgE3t1gPszGwg8GEYCC0VKkMs+MStF4v2tfkkeimd5ZHhsQW+BL3At8gtZOQw52R6229hlwFvRajurE5Cd4rweZX11Zt+fCEyRvGohBG6zOXbF3grybCzTTUf8ecFSb3avikoqQ4khxaxqAGBlWAGnjjhg/pgyuIIxCktVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RhDd8tdm; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RhDd8tdm"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847a5f03ff9so1061142b3a.0
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934365; x=1783539165; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zvn0qgJXD+EEALhwTLcptmf75deD5j2rYJRr5T7GtTU=;
        b=RhDd8tdmWIDZ77l+QnZU8tdLjbnMzpGumNmr51M99G+qi7Rh1YrWaq/QyGBr+gx3ev
         TyS9UrSOr0YyWh5+9HsSzO05mMR/ymVOvwAAL7xKOHp190mLBv3kEhJKwHu9JCoy/2hc
         FenBhUKDoy2VJwPeXCJxsIK/7cXz67kLwtQrmDkEBGfWR0FK5lwy3eNOTm1FPcdge+Fu
         j93/pKXMdYLgzz6GeqmNiQOqyWn/0WD5cPa3SyFTmWUqX3cFd/PYMXDUEI8FdQVmGySN
         bytJArwxqavUE0pDvpvLb36lHm6NFMPPWYKTGU+tq3MgtnEVTwMGkxZ/tTH6tHW3IqwC
         8lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934365; x=1783539165;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvn0qgJXD+EEALhwTLcptmf75deD5j2rYJRr5T7GtTU=;
        b=BtW4jySGj/2Xj2+XCcPA5yBeBc617FAsPM5jBgJxwEJ2urQ9Q8OpHTzUD67jJwPsMR
         oLhTYXbX+iBWj71CRWyPOMTgxCPTCy1UwyHdlOKdjHK/GROFkx2uDkstLWLayzPjH+6+
         SG+njxqbhreGYpVnflk8SHlyLyvrFzb/rC8E2+I4rGo8ossrbWRBR/EZGVKiG9te8Et3
         QAOzwjwShR/nf9Wxf5VBD/2vupK8j10Z53+dHCunHe9QoLbbLn9MgvJKDE1x11zXjD5v
         njMexa9FIU3pkWyV2HGwS9YtN91LxZRAF6h9e6oJ1EXjdZQgPlJXQuXbd/Mh8wDWxi4I
         P8Zw==
X-Forwarded-Encrypted: i=1; AHgh+RpN377zq+SPkFaUIjes06a7+IJi3TzoQ29XBb4xfN+bf/6D25A4YZBV2NZsMnJVyrZ12l4UF23P/aOHPkrGSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIEqpXTAJR0Q+nqlgVjsnEO/+JzTwsw5JfkBPF+PtJM6dCSJG8
	2Sm6ZH55SY2RCxP+tkLxrJOwu1BqE0qJz6R1SDOEpUDuGCGbvjoHf8a+2VJehivpNUejIa3uRqv
	jzM2m1g==
X-Received: from pgkz20.prod.google.com ([2002:a63:a54:0:b0:c9a:8872:2a15])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:181b:b0:847:9226:e7be
 with SMTP id d2e1a72fcca58-847c03a60f4mr2814234b3a.0.1782934364356; Wed, 01
 Jul 2026 12:32:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:36 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-16-seanjc@google.com>
Subject: [PATCH v5 15/51] x86/tsc: Kill off x86_platform_ops.calibrate_{cpu,tsc}()
 hooks
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
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
index 676910292af7..a877b82d0991 100644
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
2.55.0.rc0.799.gd6f94ed593-goog

