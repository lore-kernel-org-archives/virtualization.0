Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F7D5336D
	for <virtualization@lists.linux.dev>; Sat,  1 Feb 2025 02:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738376253; cv=none; b=GDngahCpZ7sYaPFxfsdqbe9ArLZ7+zFj7SldooQanx+s4K2iS6qFixt79iTKG23xfuj4XViU6gBD8jgxRa98OZeU0UE5QgGQoBLSs50+iksBxof/meNBSjg/a3AMAyW3Sd6ALuaYctEAMXGONKe4fnZGdV3lN/xKVlfPRnxNmOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738376253; c=relaxed/simple;
	bh=TyPGGnI+qvESlCqTdnx/2r6KTTCSxp5Z/qlgDjzTlP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BmXHfnq3kgD5rLhypVYN1Q9J8vxDeQ+OB0APyP34zicFhBqZo3P4jzM+Pp0fVYt7+DpN5L+s8F7/pqbdYBhQx3NVsxvlcTcRKf/vBafecce7zWWQdOpDiUh3awA8/UQnwuNEqFnP8tjI+motNHBipjiag7yyhsL+NZ0aers7ddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcEtKHEQ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcEtKHEQ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216387ddda8so55340375ad.3
        for <virtualization@lists.linux.dev>; Fri, 31 Jan 2025 18:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738376251; x=1738981051; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=E0C6rmJeK4TduAmeKIdyYwLof9bH1hCIL8jVX3VQ6HM=;
        b=jcEtKHEQqhuzqefckjy3fXjM/Dx0BScIC0rVLQdjxe7UIvMytfoaIL6kYBu8WP/2Ra
         K+DY1AWwnT92MFfyhgJB3MWN0zOu1EfKC2Sfd6Ej7/GV6XZRwPNL2oAQEb+Daq2p6/k0
         gorXkOeq/81G3fBF4KtL2secsjRGXdwEger+9nGM5OHw6hurd/jL3aysRgHuMaqxh6Qj
         eIYt2BtLcS3Mwcg0ABk08b6/+/mxb+Kg35QTcmWYGDqkABo4tWWcjxXLi1OlFENDZuo6
         1d8f8Nh0RRW3NNMXLUh5S6y7zPdHjAx7Lu1McbsNdmm7YGcBovpUzh5Cq4VoA9j/8yPL
         uAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738376251; x=1738981051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E0C6rmJeK4TduAmeKIdyYwLof9bH1hCIL8jVX3VQ6HM=;
        b=t3YjIeXlFwaeQRGVzDWdUvfAg/a+qzxQEwe3rrYeav07DuTZD/ISmMAs9j9u2s7vzb
         FCav4i0b5Xp49B/ozSRRdxX6uwQtwi736tN7taxuK5e1lEhQLZc5XtR7XWCrWILs6eiS
         r7rmzeuZ9DLvElSRdl24KOc305a6H06cdc1j5mUiX215lXe3eFBZOxLiI3+glhoE4quR
         5iEMe1PJ2/g1k5CE1xEXS1n+hJSAXMWqAuPdtJFSEo78gsaUidyAb46ysgDNfVxhGv7j
         +6NUjUckzfalFZ/J0sI7MBIYOtqgICpSSJNN90PSW7Kw8TZ9aw3XxkAoPWKcDk+Q/t1L
         +fPg==
X-Forwarded-Encrypted: i=1; AJvYcCWNMi6b3JHKxNQI1eCwwjam0HtSRoIbzWkU0IZeXrk3Xe25Cw2qvO6uQ7AN/AMdjSM1nMo5A1EerBMDuYqTWw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3eVN7A6A9V0PwyjBXo70OvLXUdqvSyLM3lezXfJfuiIeLcfai
	1oXUCqx44ZymNGUtu1/DRxrRYyuWDjeq44iyywnwc/YbUO7Whyxec2bsEkHwRnmNwztU1G4xogY
	3Mg==
X-Google-Smtp-Source: AGHT+IFlvWiOED1ZYXsClK6j8veie9a9mJfZCZQPkiq0i15PJ6F5P2kJWMXEZplyquyEAP3l8GbEgk3YB0s=
X-Received: from pghg16.prod.google.com ([2002:a63:e610:0:b0:ad0:f8ff:b90d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:6713:b0:1e0:d766:8da1
 with SMTP id adf61e73a8af0-1ed7a6e12f1mr21226332637.39.1738376250763; Fri, 31
 Jan 2025 18:17:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 31 Jan 2025 18:17:04 -0800
In-Reply-To: <20250201021718.699411-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250201021718.699411-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250201021718.699411-3-seanjc@google.com>
Subject: [PATCH 02/16] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
From: Sean Christopherson <seanjc@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Juergen Gross <jgross@suse.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Alexey Makhalov <alexey.amakhalov@broadcom.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, 
	jailhouse-dev@googlegroups.com, kvm@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Sean Christopherson <seanjc@google.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"

Extract the guts of cpu_khz_from_cpuid() to a standalone helper that
doesn't restrict the usage to Intel CPUs.  This will allow sharing the
core logic with kvmclock, as (a) CPUID.0x16 may be enumerated alongside
kvmclock, and (b) KVM generally doesn't restrict CPUID based on vendor.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h | 16 ++++++++++++++++
 arch/x86/kernel/tsc.c      | 21 ++++++---------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 14a81a66b37c..540e2a31c87d 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -69,6 +69,22 @@ static inline int cpuid_get_tsc_freq(unsigned int *tsc_khz,
 	return 0;
 }
 
+static inline int cpuid_get_cpu_freq(unsigned int *cpu_khz)
+{
+	unsigned int eax_base_mhz, ebx, ecx, edx;
+
+	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+		return -ENOENT;
+
+	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
+
+	if (!eax_base_mhz)
+		return -ENOENT;
+
+	*cpu_khz = eax_base_mhz * 1000;
+	return 0;
+}
+
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index e3faa2b36910..4fc633ac5873 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -662,7 +662,7 @@ static unsigned long quick_pit_calibrate(void)
 unsigned long native_calibrate_tsc(void)
 {
 	unsigned int eax_denominator, ebx_numerator;
-	unsigned int crystal_khz;
+	unsigned int crystal_khz, cpu_khz;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
@@ -692,13 +692,8 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
-		unsigned int eax_base_mhz, ebx, ecx, edx;
-
-		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		crystal_khz = eax_base_mhz * 1000 *
-			eax_denominator / ebx_numerator;
-	}
+	if (crystal_khz == 0 && !cpuid_get_cpu_freq(&cpu_khz))
+		crystal_khz = cpu_khz * eax_denominator / ebx_numerator;
 
 	if (crystal_khz == 0)
 		return 0;
@@ -725,19 +720,15 @@ unsigned long native_calibrate_tsc(void)
 
 static unsigned long cpu_khz_from_cpuid(void)
 {
-	unsigned int eax_base_mhz, ebx_max_mhz, ecx_bus_mhz, edx;
+	unsigned int cpu_khz;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < CPUID_LEAF_FREQ)
+	if (cpuid_get_cpu_freq(&cpu_khz))
 		return 0;
 
-	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
-
-	cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
-
-	return eax_base_mhz * 1000;
+	return cpu_khz;
 }
 
 /*
-- 
2.48.1.362.g079036d154-goog

