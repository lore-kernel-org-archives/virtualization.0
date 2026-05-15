Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C062400145
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872874; cv=none; b=iK0YGSdjEtKdfe7AnHHuUJUpMh1hMM1eo8RvuGfn9BVYg8nJPOJC+3FLXvge2lj4zJpiptQw/EivmWj7zBpPlzk6JxIZUixUcozZGjj5OZCyyZBUNsqFT2G6JhFPgSTRFb5icv7uk2s4q76BnWAFDNAATbMkf6tvFCJsVhUP/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872874; c=relaxed/simple;
	bh=aDdzPwKH5mlXfE5QjpaWfAhYaCF3O4EfHaFLXFBr3HA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Br6vySmx5+F8tB8yZjArTg1TN2Thz1UItCSzpQCnF0syQjhJdg/v9OwhFxdFIgm2JUgklbXHNv18stz02a0Lf65rBt1VC+PwFq4g1i4FfIQrexxMr6DVRjd6mCwydooaoIz+kan6kywSf60J1u3WIUPrj2tMTuaaAbpk/948U8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I0lMl3LM; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I0lMl3LM"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c82c84be9c3so74085a12.0
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872870; x=1779477670; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=GynyMcltCamU1dXPXnRIm6lqrNcs78pXek2ggzODYGc=;
        b=I0lMl3LMDo7Dc2azhe6z1BS2pJ/Z6UCtSGeT67MKMpmx94ECtXtTBuy+P3Zod+1cRw
         +QaTgvGh9gw6BVLOASGUkoOijxV8bXV2ORgRfjWgr5KOrlmNHwWc0NaohsDRF9C98Cji
         xxRQ0QBZdRcltd4NW1RKyVDjn57nyw+I7027Ps007ToOHBPqaH1Krz780j2uM05XmR23
         KYqI5NO8CnwDPJkDi5S5UsaiorBWLVLQ16ccpiFWai5zcHPPqK4bp6ZCTd5LPFZZ/D5z
         Uf/X5kOzTFCsLRsfDMDcuQ4keYr3O3Ih9rGTcL8fpOsOc8P3EqgbNzfpnPFpjdd70bK2
         kgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872870; x=1779477670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GynyMcltCamU1dXPXnRIm6lqrNcs78pXek2ggzODYGc=;
        b=Ar9925DNAxnFYbGxArHqxrvniZlDnd5UwUKwPmwQLkYkOi3ZIKBayZuDAOAoFdrxWH
         3EcicSZ9k1OJOfEmv/BpdjaT4N77/u4bsZhMmgTCRNaVJfQm/G2nPmhs/kA7gNEGCCJC
         2/4q7OoiddAAuQJiz+I7xvD4L+AGKzjRTuB6VAjzSE3dJY/RmtLCRxXcgXzoEflVuWJE
         yr7y3u2Rg+dOTsVLUqjeBeZRZOULeqNrVizYRCdK9ZHtVwS+F5mvyAih2bV16RSTmfJ8
         /NDoHWbfFfWJpj9ECsTt7TXTTP6u1cpApHY+N5rHzuN4oZWM6hpcqRRLPwmonAFhGXIE
         nwnw==
X-Forwarded-Encrypted: i=1; AFNElJ/aTNczqsdTxh7nTqv74FVgXucWqPJV5lI6hg2nEvnpESlIXaMCbB5rhJVGfcaQY6Wuw/L1huVUmmGFd/ylPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyShLXy1I4rOu6a5rJclINGZTiGU6QY1+KvP8nfcYVB3vwDAnpi
	Qxg1B39Z8doIn4bod9h53JAH4iOuhC8rnPrvy/ebn1ZTDwb+gNwIRXNdEeFYj00IjS+IiuyYk0D
	b6jKxGw==
X-Received: from pgbfm5.prod.google.com ([2002:a05:6a02:4985:b0:c82:7df9:8c21])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9985:b0:39b:e1e5:a101
 with SMTP id adf61e73a8af0-3b22ec7d04bmr6317771637.43.1778872870066; Fri, 15
 May 2026 12:21:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:32 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-32-seanjc@google.com>
Subject: [PATCH v3 31/41] x86/tsc: Pass KNOWN_FREQ and RELIABLE as params to registration
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

Add a "tsc_properties" set of flags and use it to annotate whether the
TSC operates at a known and/or reliable frequency when registering a
paravirtual TSC calibration routine.  Currently, each PV flow manually
sets the associated feature flags, but often in haphazard fashion that
makes it difficult for unfamiliar readers to see the properties of the
TSC when running under a particular hypervisor.

The other, bigger issue with manually setting the feature flags is that
it decouples the flags from the calibration routine.  E.g. in theory, PV
code could mark the TSC as having a known frequency, but then have its
PV calibration discarded in favor of a method that doesn't use that known
frequency.  Passing the TSC properties along with the calibration routine
will allow adding sanity checks to guard against replacing a "better"
calibration routine with a "worse" routine.

As a bonus, the flags also give developers working on new PV code a heads
up that they should at least mark the TSC as having a known frequency.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c       |  6 ++----
 arch/x86/coco/tdx/tdx.c        |  7 ++-----
 arch/x86/include/asm/tsc.h     |  8 +++++++-
 arch/x86/kernel/cpu/acrn.c     |  4 ++--
 arch/x86/kernel/cpu/mshyperv.c | 10 +++++++---
 arch/x86/kernel/cpu/vmware.c   |  7 ++++---
 arch/x86/kernel/jailhouse.c    |  4 ++--
 arch/x86/kernel/kvmclock.c     |  4 ++--
 arch/x86/kernel/tsc.c          |  8 +++++++-
 arch/x86/xen/time.c            |  4 ++--
 10 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 39fb50697542..822a2a0f1a2f 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2037,9 +2037,6 @@ void __init snp_secure_tsc_init(void)
 
 	secrets = (__force struct snp_secrets_page *)mem;
 
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
 
 	/* Extract the GUEST TSC MHZ from BIT[17:0], rest is reserved space */
@@ -2048,7 +2045,8 @@ void __init snp_secure_tsc_init(void)
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
 	tsc_register_calibration_routines(securetsc_get_tsc_khz,
-					  securetsc_get_tsc_khz);
+					  securetsc_get_tsc_khz,
+					  TSC_FREQ_KNOWN_AND_RELIABLE);
 
 	early_memunmap(mem, PAGE_SIZE);
 }
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 26890cea790b..7050f3ee6593 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -1208,14 +1208,11 @@ static unsigned long tdx_get_tsc_khz(void)
 
 void __init tdx_tsc_init(void)
 {
-	/* TSC is the only reliable clock in TDX guest */
-	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
-
 	/*
 	 * Override the PV calibration routines (if set) with more trustworthy
 	 * CPUID-based calibration.  The TDX module emulates CPUID, whereas any
 	 * PV information is provided by the hypervisor.
 	 */
-	tsc_register_calibration_routines(tdx_get_tsc_khz, NULL);
+	tsc_register_calibration_routines(tdx_get_tsc_khz, NULL,
+					  TSC_FREQ_KNOWN_AND_RELIABLE);
 }
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index bae709f5f44d..f458be688512 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -95,8 +95,14 @@ extern int cpuid_get_tsc_freq(struct cpuid_tsc_info *info);
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 #if defined(CONFIG_HYPERVISOR_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
+enum tsc_properties {
+	TSC_FREQUENCY_KNOWN	= BIT(0),
+	TSC_RELIABLE		= BIT(1),
+	TSC_FREQ_KNOWN_AND_RELIABLE = TSC_FREQUENCY_KNOWN | TSC_RELIABLE,
+};
 extern void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
-					      unsigned long (*calibrate_cpu)(void));
+					      unsigned long (*calibrate_cpu)(void),
+					      enum tsc_properties properties);
 #endif
 extern void mark_tsc_unstable(char *reason);
 extern int unsynchronized_tsc(void);
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 2da3de4d470e..4f2f4f7ec334 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -29,9 +29,9 @@ static void __init acrn_init_platform(void)
 	/* Install system interrupt handler for ACRN hypervisor callback */
 	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	tsc_register_calibration_routines(acrn_get_tsc_khz,
-					  acrn_get_tsc_khz);
+					  acrn_get_tsc_khz,
+					  TSC_FREQUENCY_KNOWN);
 }
 
 static bool acrn_x2apic_available(void)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5ca139ae50b4..734d79c10ae5 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -516,8 +516,13 @@ static void __init ms_hyperv_init_platform(void)
 
 	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
-		tsc_register_calibration_routines(hv_get_tsc_khz, hv_get_tsc_khz);
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+		enum tsc_properties tsc_properties = TSC_FREQUENCY_KNOWN;
+
+		if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
+			tsc_properties = TSC_FREQ_KNOWN_AND_RELIABLE;
+
+		tsc_register_calibration_routines(hv_get_tsc_khz, hv_get_tsc_khz,
+						  tsc_properties);
 	}
 
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
@@ -629,7 +634,6 @@ static void __init ms_hyperv_init_platform(void)
 		 * is called.
 		 */
 		wrmsrq(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_TSC);
-		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 	}
 
 	/*
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 968de002975f..c19fa4471800 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -388,10 +388,10 @@ static void __init vmware_paravirt_ops_setup(void)
  */
 static void __init vmware_set_capabilities(void)
 {
+	/* TSC is non-stop and reliable even if the frequency isn't known. */
 	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	if (vmware_tsc_khz)
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
 	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
 		setup_force_cpu_cap(X86_FEATURE_VMCALL);
 	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
@@ -420,7 +420,8 @@ static void __init vmware_platform_setup(void)
 
 		vmware_tsc_khz = tsc_khz;
 		tsc_register_calibration_routines(vmware_get_tsc_khz,
-						  vmware_get_tsc_khz);
+						  vmware_get_tsc_khz,
+						  TSC_FREQ_KNOWN_AND_RELIABLE);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 		/* Skip lapic calibration since we know the bus frequency. */
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index db8f31fdb480..1bdc9ab321e0 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -219,7 +219,8 @@ static void __init jailhouse_init_platform(void)
 
 	machine_ops.emergency_restart		= jailhouse_no_restart;
 
-	tsc_register_calibration_routines(jailhouse_get_tsc, jailhouse_get_tsc);
+	tsc_register_calibration_routines(jailhouse_get_tsc, jailhouse_get_tsc,
+					  TSC_FREQUENCY_KNOWN);
 
 	while (pa_data) {
 		mapping = early_memremap(pa_data, sizeof(header));
@@ -257,7 +258,6 @@ static void __init jailhouse_init_platform(void)
 	pr_debug("Jailhouse: PM-Timer IO Port: %#x\n", pmtmr_ioport);
 
 	precalibrated_tsc_khz = setup_data.v1.tsc_khz;
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	pci_probe = 0;
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 9b3d1ed1a96d..b6b2018c51db 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -200,7 +200,6 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
  */
 static unsigned long kvm_get_tsc_khz(void)
 {
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
 
@@ -404,7 +403,8 @@ void __init kvmclock_init(void)
 
 	kvm_sched_clock_init(stable);
 
-	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz);
+	tsc_register_calibration_routines(kvm_get_tsc_khz, kvm_get_tsc_khz,
+					  TSC_FREQUENCY_KNOWN);
 
 	x86_platform.get_wallclock = kvm_get_wallclock;
 	x86_platform.set_wallclock = kvm_set_wallclock;
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index ac4abfec1f05..98bef1d06fa9 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1311,11 +1311,17 @@ static void __init check_system_tsc_reliable(void)
  */
 #if defined(CONFIG_HYPERVISOR_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
 void tsc_register_calibration_routines(unsigned long (*calibrate_tsc)(void),
-				       unsigned long (*calibrate_cpu)(void))
+				       unsigned long (*calibrate_cpu)(void),
+				       enum tsc_properties properties)
 {
 	if (WARN_ON_ONCE(!calibrate_tsc))
 		return;
 
+	if (properties & TSC_FREQUENCY_KNOWN)
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+	if (properties & TSC_RELIABLE)
+		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+
 	x86_platform.calibrate_tsc = calibrate_tsc;
 	if (calibrate_cpu)
 		x86_platform.calibrate_cpu = calibrate_cpu;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index f087bb76457d..c04548641558 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -43,7 +43,6 @@ static unsigned long xen_tsc_khz(void)
 	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
 
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(info);
 }
 
@@ -574,7 +573,8 @@ static void __init xen_init_time_common(void)
 	 */
 	paravirt_set_sched_clock(xen_sched_clock, NULL, NULL);
 
-	tsc_register_calibration_routines(xen_tsc_khz, NULL);
+	tsc_register_calibration_routines(xen_tsc_khz, NULL,
+					  TSC_FREQUENCY_KNOWN);
 	x86_platform.get_wallclock = xen_get_wallclock;
 }
 
-- 
2.54.0.563.g4f69b47b94-goog

