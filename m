Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A06442111
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059399; cv=none; b=V6WaIrpzVaSzT2ADgNR6wVRdAs5kh+tAFYOj28jHl0igAYfyw/fjetzrFYbQKptrMXiKSxpMlyM0tu5kHFhkhpumRP0XhQBnYO+RjKbwQgRUyTICn+cFgm/CO72zoOtx0e1FqrJdRM2wjw/onpAhwDSaFTZ58x8c0tC6haQI0uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059399; c=relaxed/simple;
	bh=Ip3+9AZjdh0bvA2Vl8RDcUNvlhnW8rCYLw17acrPYF0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z/yq+CgbSi9QQRYZwSzHW5Ou7oepL2ediE0ehUHibIDL2qGoALMh8Cta1aWOFe+WvSDiOqlRh4yXknq2RHIrjynHGc1BEIFCP6IjORlwWgFQ2pPGi4KHlHaD60iEZbBqHog/UhcEGbqISXZvJO9AHcdsYLKYKPZ00nAUwR5oMCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PF0kt/B5; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PF0kt/B5"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so4350054a91.1
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059395; x=1786664195; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rOLPH8cbFzmNmyBMg+VXArbJGugFBL/MCFG1XvEwkdc=;
        b=PF0kt/B58DTIcV0Jzi7cikZ4cLCIY1Nepiz93k5Oejp9CsENB6P6zuFpCfVHZZsaPA
         hcyYS2wNlLPQSxFb7SeQ7azuesQ/DLhU/zXaPGCF6Tle63swq6r+yWYSY3YVJxVBaU2A
         7KtqZZdgc1gNE5a7kozdNF7ixW+mzIW6aUHbtpYP+ZQjmvioQEVz3i2Bj6gJA9irvEVh
         gLOjbonAH4T5fh07X1QrmNbjDMiIzcSsGJnJnlXGxQOu1nVJ2n3W+WU9RsdsheiD8bvN
         7MZwZWtQ0LQ6RIEI8Vgkwp0fVSi41VScZBFVOOo04bxZVQYULLCh8U16asj1w9m4ITqd
         WCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059395; x=1786664195;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rOLPH8cbFzmNmyBMg+VXArbJGugFBL/MCFG1XvEwkdc=;
        b=GCi1t8sm9pzG6qxAwy4GFxTk39u0BqL5UF1E+54cCOCWUOMOJgQAGgE5BXwzN4WOVd
         s0i2ryrUoFI2+fOiQffmQtLLQkXhJjWTA/yJ/XAvTrf4E4mfZgy9oOeVxb6DJqfeFrXj
         QCxwUVIvxsbpCA5kgVyHI00XALBMzvgOpZm0FkuX/uhSA6jRm4w1llXM6oQJJW1Qh6GH
         1wjUslTzVTDQuQ+zA6krX2Z9HrRLTjYsCv+Rn18FYYcOyjSEBlye0859TF59jwHqifgP
         0HnmQS0cFJRtRezR6B5fgeWanuVhnkfFeIDrnehVLXQFt2fHNfIV7xqnueqiz4P35Xbl
         /TRw==
X-Forwarded-Encrypted: i=1; AHgh+RrU42Uaz5toxMgEDqwm4LJvetLx61oDFhBurePBFulSyhMUzwGzkBnec7t+E1dlUEgk8UYo4wP6/RLQpF5scw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpDG9s1VlLdTSe1XJg4plqVXLPNy7lh2jnBPtpjOqcGuFdTlgX
	n6TfWPOXJmkb3hMy1V56BDJhqHlVPf/ztEgvnelNotqNAsqi1Dud4sJcNwcTcWXfvuM2kQmlYLy
	PPf4t/Q==
X-Received: from pjte20.prod.google.com ([2002:a17:90a:c214:b0:38e:7f69:82cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5683:b0:38e:6aa7:68ad
 with SMTP id 98e67ed59e1d1-3903c54fbc4mr18735745a91.5.1786059395009; Thu, 06
 Aug 2026 16:36:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:26 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-10-seanjc@google.com>
Subject: [PATCH v6 09/51] x86/tsc: Add a standalone helper for getting TSC
 info from CPUID.0x15
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

Extract retrieval of TSC frequency information from CPUID into a standalone
helper so that TDX guest support can reuse the logic.

Opportunistically drop native_calibrate_tsc()'s "== 0" and "!= 0" checks
in favor of the kernel's preferred style.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/tsc.c | 61 +++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6898584610a7..d405ff4e45e0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -645,46 +645,62 @@ static unsigned long quick_pit_calibrate(void)
 	return delta;
 }
 
+struct cpuid_tsc_info {
+	unsigned int denominator;
+	unsigned int numerator;
+	unsigned int crystal_khz;
+};
+
+static int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
+{
+	unsigned int ecx_hz, edx;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
+		return -ENOENT;
+
+	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
+	cpuid(CPUID_LEAF_TSC, &info->denominator, &info->numerator, &ecx_hz, &edx);
+
+	if (!info->denominator || !info->numerator)
+		return -ENOENT;
+
+	/*
+	 * Note: some CPUs provide the multiplier information, but not the core
+	 * crystal frequency.  The multiplier information is still useful for
+	 * such CPUs, as the crystal frequency can be gleaned from CPUID.0x16.
+	 */
+	info->crystal_khz = ecx_hz / 1000;
+	return 0;
+}
+
 /**
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
  */
 unsigned long native_calibrate_tsc(void)
 {
-	unsigned int eax_denominator, ebx_numerator, ecx_hz, edx;
-	unsigned int crystal_khz;
+	struct cpuid_tsc_info info;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_TSC)
+	if (cpuid_get_tsc_info(&info))
 		return 0;
 
-	eax_denominator = ebx_numerator = ecx_hz = edx = 0;
-
-	/* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
-	cpuid(CPUID_LEAF_TSC, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
-
-	if (ebx_numerator == 0 || eax_denominator == 0)
-		return 0;
-
-	crystal_khz = ecx_hz / 1000;
-
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
 	 * CPUID_LEAF_FREQ for the calculation below, so hardcode the 25MHz
 	 * crystal clock.
 	 */
-	if (crystal_khz == 0 &&
-			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
-		crystal_khz = 25000;
+	if (!info.crystal_khz && boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
+		info.crystal_khz = 25000;
 
 	/*
 	 * TSC frequency reported directly by CPUID is a "hardware reported"
 	 * frequency and is the most accurate one so far we have. This
 	 * is considered a known frequency.
 	 */
-	if (crystal_khz != 0)
+	if (info.crystal_khz)
 		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 
 	/*
@@ -692,15 +708,14 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
+	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
 		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		crystal_khz = eax_base_mhz * 1000 *
-			eax_denominator / ebx_numerator;
+		info.crystal_khz = eax_base_mhz * 1000 * info.denominator / info.numerator;
 	}
 
-	if (crystal_khz == 0)
+	if (!info.crystal_khz)
 		return 0;
 
 	/*
@@ -716,9 +731,9 @@ unsigned long native_calibrate_tsc(void)
 	 * lapic_timer_period here to avoid having to calibrate the APIC
 	 * timer later.
 	 */
-	apic_set_timer_frequency_khz(crystal_khz, "CPUID 0x15/0x16");
+	apic_set_timer_frequency_khz(info.crystal_khz, "CPUID 0x15/0x16");
 
-	return crystal_khz * ebx_numerator / eax_denominator;
+	return info.crystal_khz * info.numerator / info.denominator;
 }
 
 static unsigned long cpu_khz_from_cpuid(void)
-- 
2.55.0.679.g6767b8d81c-goog

