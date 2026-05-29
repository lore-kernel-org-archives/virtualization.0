Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE23FF1C0
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065917; cv=none; b=t0AwJ8yv0+biqvehNf9/PbG+R3ECBwyMM+bcAXOHtcfSX+Gt8HZlzt5UZZAQk1x4maW4MlLXy8LmyRXWphtmWpB9R4mQvMuaVTbUQJrOK9zJ4lA2DlyJo/dnngTpJwOjk3P4leBwunevvK12d8B1TyZrO7Y9c+bwNqbdP2eeXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065917; c=relaxed/simple;
	bh=KyB0Txj56NS/h0Juiajq3RnH9IfQJxHtRnFzyefeuUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CZM+L874vG0zg6hkIPip2JLBJ6HLLKFTCa8pKnLvvpWy/zbxIUCelaOrQWJEej7Pbm+rIlzvyIglHcUVEnp1Vxy180Ga9UkfVwEysyIDREWHXHTQ3r7jJH52TNBhifVam2MUuOKd3uDXaSp5HC8fwbD2TyurwamxWJDrQZ/FNwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vo6l/qPg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vo6l/qPg"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf2bc4371bso2856585ad.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065915; x=1780670715; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=33AEblmPZenCG7ncxIbBQYlPZl7MWXLQcjQTaHUg1Zw=;
        b=vo6l/qPgWiog7ip65062K6RCsvkbpNyFwF1qMSXqawh8P2/FAS1/rsE1ASJw6RkM2G
         jkbqgcJ9ZaVSu96FyFznC0E79dEd88SKPCdcr+cyY/4403ujlSjUTRu3WqvBLIiur9CJ
         NHlsT00QVQnl8T0sopnBPbYHZ1kHus34Ln6AhG2S09/oWAhFuAX/rj/rUbcn4m7EHPkq
         rAaJbafoHfUYBlFfF+Dr1Y5I3FTRjGC98EXL0+6rN8PH0k0cvJtbI6M6yvuVdjjM87+Y
         TZ4kRXq+VE6gfMzJgNXaoGV6uRuA0EG13rEI0n2OIzET+jcIk/jhsqA7gbvMa9e70P6d
         ZVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065915; x=1780670715;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=33AEblmPZenCG7ncxIbBQYlPZl7MWXLQcjQTaHUg1Zw=;
        b=AgUE1mMDoF1PSUlrpDS3nntA/j/MwVJkRk5/Jcaz0ICzmoTcy+zHfks6auqz4UNPS6
         3yTY2IAIE6JIOlxcVwMAvpAimbXtvwB3OSQ75UqK1ykJKfOQWxZVdDs+pEdVlQt4hDO/
         6COB2ThVfAWWMICBW4PDo/rafyveCddXpi4TUIU1Csytu8McD4HknVt4Ih89oeiqdH5/
         jtyzaAcLg86LfnWP48fTAQhmACsnWLZ67xDon9Z+t6Bz6XuLhVA1Jl5zG8a0ZlPo8BaS
         atTK+XL4Bl/0CuZYY5xTDYf6DnuEHD7P4NLRhMSToKWA/F5cuiwuxcjHpOh826iOP5BG
         uBrA==
X-Forwarded-Encrypted: i=1; AFNElJ8I87HBNFPIOCkdaLvwo2dvNoMOH+9B/gk13W1PGc0JuuyS4hN85NeHgPibFmmY9/4xMj89q0PczDyrGneeMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsv+8q9HvpkgXwULZdcmiWjtTpKJfpeAHH8WBq8Bs8QIDExzUk
	yDi7SciaDM3yIkhWNctxaQyvOeatGqs14bmyVh5t+riUKDGVm+aBZupha7Nu64vc8h4iF1OYN7A
	akuDmwA==
X-Received: from plaq13.prod.google.com ([2002:a17:903:204d:b0:2bf:68:53db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ffcb:b0:2b9:cabe:ce37
 with SMTP id d9443c01a7336-2bf204679c2mr35097225ad.1.1780065914467; Fri, 29
 May 2026 07:45:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:44:06 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-20-seanjc@google.com>
Subject: [PATCH v4 19/47] x86/tsc: Add standalone helper for getting CPU
 frequency from CPUID
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
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
 arch/x86/kernel/tsc.c      | 32 +++++++++++++++-----------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 4a224f99c3b9..7ff2bfdcdf38 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -90,6 +90,7 @@ struct cpuid_tsc_info {
 	unsigned int tsc_khz;
 };
 extern int __init cpuid_get_tsc_freq(struct cpuid_tsc_info *info);
+extern unsigned int __cpu_khz_from_cpuid(void);
 
 extern void tsc_early_init(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3e911f0f7364..bdff8c988866 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -692,6 +692,18 @@ int __init cpuid_get_tsc_freq(struct cpuid_tsc_info *info)
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
@@ -727,13 +739,8 @@ static unsigned long native_calibrate_tsc(void)
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
+	if (!info.crystal_khz)
+		info.crystal_khz = __cpu_khz_from_cpuid() * info.denominator / info.numerator;
 
 	if (!info.crystal_khz)
 		return 0;
@@ -760,19 +767,10 @@ static unsigned long native_calibrate_tsc(void)
 
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
2.54.0.823.g6e5bcc1fc9-goog

