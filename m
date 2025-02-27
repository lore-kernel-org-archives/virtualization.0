Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A541ABEAC
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622749; cv=none; b=OQXRbjwxHRB9AM7rhEeVQmE4HbAVpg+029v4geUKKaW6dr9hifLaCwy1k5RyeQRhJzMtH5SI2SLc3m36hyC+Z0JNl9SADYRGGz4GfSzM0xT3BTcauran5wEcLZM/wRzC8J2weqxgRNrKpgUK9Dz2WKe/zqaR1UM96y6HHiXo8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622749; c=relaxed/simple;
	bh=YIm02xTVNm0eSDO98sEQL1tUrXbpItcdQ7Va1EiMjyI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m6wk8ltkxvrK7P6fuFlcsOWoGhgrBbN7Kp5imnct1zIksBaQlMygO/IMcL1FVvgZE3dm6QRFISZTwAs+tv4qjYHVTDdcB8ut/YEfQBn4mtVb51TKaqJEGyVAXQbHrmXfTSbHprL0Xbdh1r3KocLAPlgiJNfxeTymm7Y0xlOFQpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g+CcrUeG; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g+CcrUeG"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fe9527c041so1100240a91.0
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622746; x=1741227546; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Dwfv1w4tsOCmi3NCgULhIMD4IZcsOFfau2ULDYaMRLg=;
        b=g+CcrUeGgHuYEFvGh28bnO2BNyctTvD/HG2syWk0cFuRgSE7yVI4TWtmfrwM6aVmjh
         xpWdWm0PGCvR1YjCZz3BaOE1K6oEYq6BEgS8emN0tVQYZxScYXWNBFI+B8zFxwFfAsEd
         K39ENNb6PFBOCsInVqfqPAB2ORl+CDB/XKUjISwWy0lxrErXT7cPEw6zK/x/4sK3H/nY
         2IOw4r8WEoKqGEt3UnqS2VtzUKjG903ulOlLz8yLZji6Q8dWMBYBaEbnC3LSXwNND3nu
         XhwM8LtSZTCS2DJ6jx50jYmmJzVNJ26D5Gj0HW9iBJAH+ncbzxAMZy7QFfO82IxRY02z
         fp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622746; x=1741227546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dwfv1w4tsOCmi3NCgULhIMD4IZcsOFfau2ULDYaMRLg=;
        b=SD9yAz7RYsL1YiBG65eUPWmGyrTKqKGJzW2kW0rtg/MGAHbtkAK2stAod1ex3MERVS
         uNiRNJKiWdB1nb/bYqNQZW9Bs0CeZPyTQvy1D+7D4kLLECp44ZIy1stERiwGKFOb+Jxi
         Qhwo8ANkifGp5v87kR2dmUU2l0gUrzdITB/FtF9WaieXC7deSpjSIu4G2VXnCtZyVCgA
         Uy2W7k8K3Zr/m9JSf0bYli47ZKdr7noo3vOdKintYPjZ/9nMoc/VgPHyXq3l1l3tl9+f
         n0mnDyyX168UCOqmEbMs7PDHE+WkzsRV8oY0OSxGSER8UAFFgqq35An67OYNl/MdX0kp
         LUTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5aN4FCoNcGL+7XMzbwo5BVHbighfARXPrau3huayUabDi7NbXnjwgvwNKerVRUy/nNqf2vg7eOYBzuRwy+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxaqoTNAJVFg0DZUsBpE/PAJzd48xpfw2JUAqJSqKq7yAq0qp5o
	hWm2YtarElQvdcp99v9cgiGzrgEAIP2C1NpofX8kHV0Bn1rz0BQoiLg6d4XmbKmba3hWsnCbaMh
	ALw==
X-Google-Smtp-Source: AGHT+IH6wZ/mGewjHTQw2W+siQpDLDG/G2QvagXg40e21ebxNRSjKEBR8DQxe4UjV6eqsE0kkd3QFpygjvI=
X-Received: from pjbsn14.prod.google.com ([2002:a17:90b:2e8e:b0:2fc:15bf:92f6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d83:b0:2fc:3264:3666
 with SMTP id 98e67ed59e1d1-2fce7b221c3mr36215820a91.30.1740622746375; Wed, 26
 Feb 2025 18:19:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:18 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-3-seanjc@google.com>
Subject: [PATCH v2 02/38] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
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

Extract the guts of cpu_khz_from_cpuid() to a standalone helper that
doesn't restrict the usage to Intel CPUs.  This will allow sharing the
core logic with kvmclock, as (a) CPUID.0x16 may be enumerated alongside
kvmclock, and (b) KVM generally doesn't restrict CPUID based on vendor.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 37 +++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index a4d84f721775..c3a14df46327 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -36,6 +36,7 @@ struct cpuid_tsc_info {
 };
 extern int cpuid_get_tsc_info(struct cpuid_tsc_info *info);
 extern int cpuid_get_tsc_freq(struct cpuid_tsc_info *info);
+extern int cpuid_get_cpu_freq(unsigned int *cpu_khz);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 93713eb81f52..bb4619148161 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -688,6 +688,24 @@ int cpuid_get_tsc_freq(struct cpuid_tsc_info *info)
 	return 0;
 }
 
+int cpuid_get_cpu_freq(unsigned int *cpu_khz)
+{
+	unsigned int eax_base_mhz, ebx, ecx, edx;
+
+	*cpu_khz = 0;
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
 /**
  * native_calibrate_tsc - determine TSC frequency
  * Determine TSC frequency via CPUID, else return 0.
@@ -723,13 +741,8 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (!info.crystal_khz && boot_cpu_data.cpuid_level >= CPUID_LEAF_FREQ) {
-		unsigned int eax_base_mhz, ebx, ecx, edx;
-
-		cpuid(CPUID_LEAF_FREQ, &eax_base_mhz, &ebx, &ecx, &edx);
-		info.crystal_khz = eax_base_mhz * 1000 *
-			info.denominator / info.numerator;
-	}
+	if (!info.crystal_khz && !cpuid_get_cpu_freq(&cpu_khz))
+		info.crystal_khz = cpu_khz * info.denominator / info.numerator;
 
 	if (!info.crystal_khz)
 		return 0;
@@ -756,19 +769,15 @@ unsigned long native_calibrate_tsc(void)
 
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
2.48.1.711.g2feabab25a-goog

