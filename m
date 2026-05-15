Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4337DACE
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872811; cv=none; b=D8tBaRZVt5t9+liOC2Rg2fq3wzNWQyq9QwGzpDQkCzDP1yTUyDv1sS+Brcdo0K14Vu9dUByqpdbf370RYr4NfXaHIRjdEnWKbIuH96krLYWwWAxQgNs1nx3aYLa/DEcLcdnoPdA2uwJOvcAMTPYq4TEg4paMKlw1Ep/wa/SyFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872811; c=relaxed/simple;
	bh=0ICEAogrRng9j6ucJ2Nqpe68+xsxzYI5Dnfjq30YBzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PfTLmczGMf/ALFxvzJnFyts+IT1ZrV6XkXNEkgpg6Os0iazmZZqLOmeKc6xffsDcDMTxj1laqDh2d8ghRd16f/9qVTOuHYA6mPWKM/mIs7qpXL+NFr5z/FbcWJYc7CJgCr9W1Q9G7UE7w+6ouljCZqb74JHaDgshjDILTM3tGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRD+Mgcz; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRD+Mgcz"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-837d43e9ff3so94772b3a.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872809; x=1779477609; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jST9oUAeGChZmjVu7tMLxKyDKtrkhYcd1woip2cswJk=;
        b=IRD+Mgcz7ljKHe0CvkyJjxe9ClMfLfeJ51tal3ApQjZjHq0x8kryETS3M1NroLxQag
         PWbzS6dEitG0E/UXJuw/Jjlen0L9het/2UjL6t7tGUmYXkN7X7FvLROrMUeaTl943JAL
         76zrOkkpyL7ZtbTQ6qaE3XXWL/dqKw71Ti3rrpBRWIVH+A020XWSz7QGj8UeQalHBjtT
         2fCBC9AGsUIu5j3eF9RiOQtO2ReoXNbApe+Sqq6ZewU6DAxDJA5m26eW16iOonQmpOwC
         Xq368ODXE/tDRESBqSmw8hDhBSbAQ8zRl9md4EhnyHS7jZouV89wW3A3m+WdjPkEywPw
         5/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872809; x=1779477609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jST9oUAeGChZmjVu7tMLxKyDKtrkhYcd1woip2cswJk=;
        b=s7FCpcKzf1nzRNt+6Z1WNkmnKA96qtwBXO+hD46ZG9dPE+4ghnJBpJKSt2AncGTV89
         h0hITMtvWKKX4P+DOiGrxnZwxcBRqJy5XTLkHGwiqGXYpUDn+2PMMK1Ck4EPMRlN16ds
         Mth7qqi6QnLSyqVORqr7bgUfgZvz+4l/+2MMhiLebE2bGSSVrmFtJl+MnMw8xPyZyEo0
         YBDme5ZhQMii3br0w3VYwEM+uofiivcQd0DtIv0xad0X58X9ED6PeD1FWCeVWKjTmtxo
         zWkGOg3rQYdoFddGirIMjVJ0AoFWXzGaqWjGW8gwR1tJJRn6ucLPu9NT1Z+V6MY19unX
         AjPA==
X-Forwarded-Encrypted: i=1; AFNElJ//0+10+DpuhllP4GmnxyHq0Jci1DM9dS4XMb9rLdDY7f+eNBke2Vq6aE6GLedXkutjvAJQ3bJel+jMv/ZYKA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3/WmSXYuQL0U49U63zwbHw8Rle4gVgS5gcMa9UdSqX/MnsnlV
	sxJOINCz2ED9YSSnMn1Gesj+C7SZ3vNbszaW1iYpBseBuVGPsVzmy2RQpjzZk9Vs1qnonVVM0/2
	Lbhnr1g==
X-Received: from pfbfc32.prod.google.com ([2002:a05:6a00:2e20:b0:82f:96ee:b9ab])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3004:b0:838:a932:de26
 with SMTP id d2e1a72fcca58-83f33bca63emr5607513b3a.1.1778872808989; Fri, 15
 May 2026 12:20:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:02 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-2-seanjc@google.com>
Subject: [PATCH v3 01/41] x86/tsc: Add a standalone helpers for getting TSC
 info from CPUID.0x15
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

Extract retrieval of TSC frequency information from CPUID into standalone
helpers so that TDX guest support can reuse the logic.  Provide a version
that includes the multiplier math as TDX does NOT want to use
native_calibrate_tsc()'s fallback logic that derives the TSC frequency
based on CPUID.0x16, when the core crystal frequency isn't known.

Opportunsitically drop native_calibrate_tsc()'s "== 0" and "!= 0" checks
in favor of the kernel's preferred style.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h |  9 +++++
 arch/x86/kernel/tsc.c      | 67 +++++++++++++++++++++++++-------------
 2 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 4f7f09f50552..0c57fadc4a39 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -83,6 +83,15 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
+struct cpuid_tsc_info {
+	unsigned int denominator;
+	unsigned int numerator;
+	unsigned int crystal_khz;
+	unsigned int tsc_khz;
+};
+extern int cpuid_get_tsc_info(struct cpuid_tsc_info *info);
+extern int cpuid_get_tsc_freq(struct cpuid_tsc_info *info);
+
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c5110eb554bc..f92236f40cbc 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -658,46 +658,67 @@ static unsigned long quick_pit_calibrate(void)
 	return delta;
 }
 
+int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
+{
+	unsigned int ecx_hz, edx;
+
+	memset(info, 0, sizeof(*info));
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
+	 * Note, some CPUs provide the multiplier information, but not the core
+	 * crystal frequency.  The multiplier information is still useful for
+	 * such CPUs, as the crystal frequency can be gleaned from CPUID.0x16.
+	 */
+	info->crystal_khz = ecx_hz / 1000;
+	return 0;
+}
+
+int cpuid_get_tsc_freq(struct cpuid_tsc_info *info)
+{
+	if (cpuid_get_tsc_info(info) || !info->crystal_khz)
+		return -ENOENT;
+
+	info->tsc_khz = info->crystal_khz * info->numerator / info->denominator;
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
@@ -705,15 +726,15 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
+	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
 		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		crystal_khz = eax_base_mhz * 1000 *
-			eax_denominator / ebx_numerator;
+		info.crystal_khz = eax_base_mhz * 1000 *
+			info.denominator / info.numerator;
 	}
 
-	if (crystal_khz == 0)
+	if (!info.crystal_khz)
 		return 0;
 
 	/*
@@ -730,10 +751,10 @@ unsigned long native_calibrate_tsc(void)
 	 * lapic_timer_period here to avoid having to calibrate the APIC
 	 * timer later.
 	 */
-	lapic_timer_period = crystal_khz * 1000 / HZ;
+	lapic_timer_period = info.crystal_khz * 1000 / HZ;
 #endif
 
-	return crystal_khz * ebx_numerator / eax_denominator;
+	return info.crystal_khz * info.numerator / info.denominator;
 }
 
 static unsigned long cpu_khz_from_cpuid(void)
-- 
2.54.0.563.g4f69b47b94-goog

