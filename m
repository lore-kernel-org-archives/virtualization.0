Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B5B4A1CBC
	for <virtualization@lists.linux.dev>; Thu,  6 Aug 2026 23:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059416; cv=none; b=XrbZBIV0Eohbs2NLUiK99O9YxsEvogWuwGsRd+mUmIIcX6l8UGtoiLP0Vh0cAmqhAUY4Yd7aoC03NOIJwKoyfVfiM3dCLw8kJEp0AdRnQDvfe9sLtfa1ppErcxgCMaJxJQ/LPuT5OYwzPlas0WPJZqyXsLUvzfKZ0wD4UpdFfQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059416; c=relaxed/simple;
	bh=4ILgpsXZ3J+MDpjYL5bz0ooI2SmcUBqM1FeGA0GNQQ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NasCxUOPIhtKqRtmMuivlQGK5eBtLBcBxybZ6f2OoOcPNR7h5QZZIzAG1Fzfygg6hedHw9crqTFIZaRc4F+WJN0e7tghFlUalNE/yucO1CsOmxuH7Otq4eZXRzbnd5oUlmMQCjuct2J+dkxXDdZKrvqaO5Fn13i3/6U2vmP206M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fopP9Wx5; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fopP9Wx5"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb6dd278512so1611916a12.3
        for <virtualization@lists.linux.dev>; Thu, 06 Aug 2026 16:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059413; x=1786664213; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gK3sjM001OyHimEt3r9e3MTxT5BkhagjBxMzBV7doNU=;
        b=fopP9Wx5fAZNgZ3Fb363yJ0GwSjAEbkU6lYkg3X0qsnrJXANrbW9F/VPIsE0VDA8aS
         2UiscWz97jzwz3tdOkGLqNAmrmLLfxzvuO1YGARcw/SnCvK239csQC3xGn6dVO7DosGX
         fNgIPOImFq1cP9GcPKatrIBPf21KESyy37xx4w84NSCqGt63fh5IIo7vfH3hj9GYV/E3
         kziFkMJC9wfVOUIrUV4/NdyR9eIYh1f2QFE9dPxismnrnAOGie0a0d6W8Yu33I2ZEam/
         JODav25mzV86Y7VcERq7A869SabatBjGZ+7PRXAlWr2rzH4kDy2bM+gPlUaafyde1vFT
         N3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059413; x=1786664213;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gK3sjM001OyHimEt3r9e3MTxT5BkhagjBxMzBV7doNU=;
        b=QeGgmJp09rnTJ48UiY+z8nU3DCVjCYxJbj8jmQVEBHYJ23F404Jm5DtBJ+U2gVT5Ll
         n31BsWBnW1RGEvuZB/B2X2wLsI2jWHeMPsf7FCvum1iaLdrdWnd70anB2CRDzupC5dbw
         tRijswxp0Q5b1BY1izDMvKOy3OowFPIq81aMHHYuWJ7ZGUCvieJGwq8HQI3hnjFOUKgU
         3FADEHwcbQ+jfKtSR11HVj918vQNXpUBBnhNSp7U/yZ9LGmUc6O2/SvdW2AkUvPkiB8I
         N/4c5A2iu/bhssIC/SK4+mY5aaMgd5DeKVkLkmyKwr6RNB6R7qnOkojgqq0wegrhWlGC
         fmfg==
X-Forwarded-Encrypted: i=1; AHgh+RoMNPdC/5farSkX3bkyIn9fbOkPbCeqC9Od1hJRyqq88CK307kTQdtiBfv3O55IxgbJdIX/eRduasA1F5YiHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyH8/Yv8IyH5M57Fc822BHoPP69k0QrXUQiGOoTMzKAmqGSAtFh
	LkgIFavKZIkwZB34/oXTzRdhIRhaptoDBtMkqGcwohYrYnbnzh48ra59rVBc6LSM3zLkaHKsyJM
	Mow3jFw==
X-Received: from pglu1.prod.google.com ([2002:a63:1401:0:b0:c99:aff5:7078])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6da8:b0:3c3:bee9:8eec
 with SMTP id adf61e73a8af0-3cbadc10910mr5429156637.19.1786059412806; Thu, 06
 Aug 2026 16:36:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:40 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-24-seanjc@google.com>
Subject: [PATCH v6 23/51] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
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

Extract the guts of cpu_khz_from_cpuid() to a standalone helper that
doesn't restrict the usage to Intel CPUs.  This will allow sharing the
core logic with KVM-as-a-guest, as KVM generally doesn't restrict CPUID
based on vendor.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 31 +++++++++++++++----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index c09ec485abcd..cb682f097ea7 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -88,6 +88,7 @@ struct cpuid_tsc_info {
 	unsigned int crystal_khz;
 };
 extern int cpuid_get_tsc_info(struct cpuid_tsc_info *info);
+extern unsigned int __cpu_khz_from_cpuid(void);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d95e4f059f17..4c5328d19ebe 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -668,6 +668,18 @@ int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
 	return 0;
 }
 
+unsigned int __cpu_khz_from_cpuid(void)
+{
+	unsigned int eax_base_mhz, ebx, ecx, edx;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+		return 0;
+
+	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
+
+	return eax_base_mhz * 1000;
+}
+
 /**
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
@@ -703,12 +715,8 @@ static unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
-		unsigned int eax_base_mhz, ebx, ecx, edx;
-
-		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		info.crystal_khz = eax_base_mhz * 1000 * info.denominator / info.numerator;
-	}
+	if (!info.crystal_khz)
+		info.crystal_khz = __cpu_khz_from_cpuid() * info.denominator / info.numerator;
 
 	if (!info.crystal_khz)
 		return 0;
@@ -733,19 +741,10 @@ static unsigned long native_calibrate_tsc(void)
 
 static unsigned long cpu_khz_from_cpuid(void)
 {
-	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
-
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
-		return 0;
-
-	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
-
-	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
-
-	return eax_base_mhz * 1000;
+	return __cpu_khz_from_cpuid();
 }
 
 /*
-- 
2.55.0.679.g6767b8d81c-goog

