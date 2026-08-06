Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4F3494253
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059404; cv=none; b=ofmN0gLlRGyL7e+L5Lao0mxOjvOXKtN34gJhjpG3ckrBjadOUKNwVm2fUDgPyEWXY46kfhzd0jkpWRRBx+Jt0tWNb2UQAx/s+HH2XDkjUmtcjnT3J6EjaZ/qxUlL4iDUYdM+h7VhJ3E0/bdGK9qXkZwhH3N8koEF8DWLne63F1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059404; c=relaxed/simple;
	bh=M65IyX8rm7dTt45KlwDHi8ahXU+KWS/raGfMe6r6K7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vAd0c+0Zw8JNB1YSUfDgd6UiocM1eii89ReogL9QSP2lcIUMRWLvPsPXiIhTtPL8Aj7MIorGFRSiuE0sL3oUnl2wyF2Per2W3R+6hQNJI5ew6ufqSZNTbA0xlXRVUynLMafKryiRFfuXKHeR/Fw1T2k6AWg3ZVcDs+80zSEndaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJCHvnhJ; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJCHvnhJ"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-848860def2cso3141377b3a.2
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059401; x=1786664201; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xHY7WhZzoR4x+WtFqsSoEfBU4PaM9Rhz3R83jbux6ZU=;
        b=bJCHvnhJNCTiMVAucBuVNVfK3/o81CLC1xA8F52jplatsMTI8LSkAj+1hVnh8m64rY
         Kol9FIa++MFHhWkEZiJeN2smmZW8MR1Tm91qKZ1i1DbJibTeXADQhMTnwwSB2efB1u3Y
         pxop4HCcyOabz13amBBbvqGsHjimX/9jkgzuBEhM2NKUsvO7I39CC2AOP0qQMWywRaB7
         Nn2DX0I7YVo6Wp+NBUbtBbBHAfTl7bmmJBqp2wbKqZy8fUvXaAM0fjJdzQCSJAOLvSJj
         +EbAuUBnXvnmm0uQfBdJbx22hXTt47ZDhc6JbY3coVPSV4e0HJNBDkd5fPIo446CglEF
         zJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059401; x=1786664201;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xHY7WhZzoR4x+WtFqsSoEfBU4PaM9Rhz3R83jbux6ZU=;
        b=k9Pr29JsDYwKuBV8N3s/Tv5LYFGlOKnq3kDVJz4KDmANuweXiU0hlRtMXmD6rJHexw
         X6+RX3OXryuKMnVSeKS/uXcziLcZk6wdVLkMKOP4Pn1HAprqtHSuVpzkPFKrx8Nu/GwA
         Pj54sjIF30umSLkdAWf5QU6G6Oxu48anEq53HXNQKiWjAratmAZKrKqBSetzSTw3dcd9
         9DeIGnxn7ogJw7r0IAs8KV3ZWdZ0/avhnuJJIqek/qy2FCNdOTUMIz/zANsWJqJLWMO/
         INWiM0d+X8oIcSHoQtPGQOQaWDpwHQeOCwNG2X+2Vdxu5BumcXk9W9qhoDIRyIoNWR0a
         LSZQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro0yX4NN82PuC/92Ym1fCo2dH8VrH5JO+e6aINvNeZzlbtsBN9ZSRzB4J2LlNcSion4MwlUpsmFEwrw8c8pvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxX7isC5KnDY7Q/P9pzH8zERU/7BVPF8+Lyqs0atHq6G08O5j5p
	NqbcFlEld1drix22DwAFcK5YPmXylqPms91ZhmzwuoMlcbQcR7F/yFWql3QeNJSajj9PWnAjbyV
	iNik3NA==
X-Received: from pfbbu11.prod.google.com ([2002:a05:6a00:410b:b0:848:8b16:23d6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2383:b0:842:5b66:3c7f
 with SMTP id d2e1a72fcca58-84f2dedf356mr20263411b3a.0.1786059400868; Thu, 06
 Aug 2026 16:36:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:31 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-15-seanjc@google.com>
Subject: [PATCH v6 14/51] x86/tsc: Consolidate forcing of X86_FEATURE_TSC_KNOWN_FREQ
 for PV code
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

Now that all paravirt code that explicitly specifies the TSC frequency
also sets X86_FEATURE_TSC_KNOWN_FREQ, replace all of the one-off code
and simply set X86_FEATURE_TSC_KNOWN_FREQ if the TSC frequency is known.

Do NOT force set TSC_KNOWN_FREQ if the "known" TSC frequency was provided
by the user.  Per commit bd35c77e32e4 ("x86/tsc: Add tsc_early_khz command
line parameter"), one of the goals of the param is to allow the refined
calibration work "to do meaningful error checking".

No functional change intended.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/sev/core.c       |  1 -
 arch/x86/coco/tdx/tdx.c        |  1 -
 arch/x86/kernel/cpu/acrn.c     |  1 -
 arch/x86/kernel/cpu/mshyperv.c |  1 -
 arch/x86/kernel/cpu/vmware.c   |  2 --
 arch/x86/kernel/jailhouse.c    |  1 -
 arch/x86/kernel/kvmclock.c     |  1 -
 arch/x86/kernel/tsc.c          | 13 ++++++++++---
 arch/x86/xen/time.c            |  1 -
 9 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index bc5ae9ef74da..72313b36b6f5 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -2027,7 +2027,6 @@ unsigned int __init snp_secure_tsc_init(void)
 
 	secrets = (__force struct snp_secrets_page *)mem;
 
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 	rdmsrq(MSR_AMD64_GUEST_TSC_FREQ, tsc_freq_mhz);
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index ec28a15e26ac..21a574e60e0f 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -1203,7 +1203,6 @@ unsigned int __init tdx_tsc_init(void)
 
 	/* TSC is the only reliable clock in TDX guest */
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	return info.crystal_khz * info.numerator / info.denominator;
 }
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index 3818f6ae0629..dc71a6fdd461 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -40,7 +40,6 @@ static void __init acrn_init_platform(void)
 	if (acrn_tsc_khz_cpuid) {
 		x86_init.hyper.get_tsc_khz = acrn_get_tsc_khz;
 		x86_init.hyper.get_cpu_khz = acrn_get_tsc_khz;
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4a0cdda0c49e..3bca987e05c3 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -575,7 +575,6 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_init.hyper.get_tsc_khz = hv_get_tsc_khz;
 		x86_init.hyper.get_cpu_khz = hv_get_tsc_khz;
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 3f1dab69d90e..cbe8b59ab79f 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -390,8 +390,6 @@ static void __init vmware_set_capabilities(void)
 {
 	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	if (vmware_tsc_khz)
-		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
 		setup_force_cpu_cap(X86_FEATURE_VMCALL);
 	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index 595cd28f9a9f..8107c28eb2bc 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -255,7 +255,6 @@ static void __init jailhouse_init_platform(void)
 	pr_debug("Jailhouse: PM-Timer IO Port: %#x\n", pmtmr_ioport);
 
 	precalibrated_tsc_khz = setup_data.v1.tsc_khz;
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	pci_probe = 0;
 
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 4f8299303a19..35a879d33e9e 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -138,7 +138,6 @@ static inline void kvm_sched_clock_init(bool stable)
  */
 static unsigned int __init kvm_get_tsc_khz(void)
 {
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(this_cpu_pvti());
 }
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7f1ca6df0004..f42872c9ae99 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1541,11 +1541,18 @@ void __init tsc_early_init(void)
 	if (!known_tsc_khz && x86_init.hyper.get_tsc_khz)
 		known_tsc_khz = x86_init.hyper.get_tsc_khz();
 
+	/*
+	 * Mark the TSC frequency as known if it was obtained from a hypervisor
+	 * or trusted firmware.
+	 */
+	if (known_tsc_khz)
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
 	/*
 	 * Ignore the user-provided TSC frequency if the exact frequency was
-	 * obtained from trusted firmware or the hypervisor, as the user-
-	 * provided frequency is intended as a "starting point", not a known,
-	 * guaranteed frequency.
+	 * obtained from trusted firmware or the hypervisor, and don't mark the
+	 * frequency as known, as the user-provided frequency is intended as a
+	 * "starting point", not a known, guaranteed frequency
 	 */
 	if (!known_tsc_khz)
 		known_tsc_khz = tsc_early_khz;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 1adb44fdddb2..487ad838c441 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -43,7 +43,6 @@ static unsigned int __init xen_tsc_khz(void)
 	struct pvclock_vcpu_time_info *info =
 		&HYPERVISOR_shared_info->vcpu_info[0].time;
 
-	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	return pvclock_tsc_khz(info);
 }
 
-- 
2.55.0.679.g6767b8d81c-goog

