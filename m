Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852D3F20FF
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065902; cv=none; b=j5eLY6x7sUSQ9n4lEXMiOeOeAbpiUO6L8uSxS3Ikyxke5T3LNIHocCvNcNpeLCpYYVFbVzOJWCD/vR1/vPYXcOaDcc52ExWCcaZE/Btlz6MQL9Htvi53HneOUIWsUjOIl/7Xi1wCXgiejjD4UJ/JfKRMTDRaS/ZWKVMqdcNyLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065902; c=relaxed/simple;
	bh=TCbPuelZQalWyWRyEio9w/7ygp+vdU+hVQlhlKu+ORI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u5P/ccKoOurE/THUn4zSZK1UPM9S7w6LJtc7DSFfY2nG2Ru5UC5lUv9vN1B9xa43PNPU28IKq+7elgpl6dtNqZH+CtWl+UnkGQsbbGlOkdTttxhUKt0KUsD6oiHEZFgsTkpEJ3xRata3hHoc3gl+fWbNquN+TdMTPlMgDAhdwow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VPWRGS6Y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VPWRGS6Y"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so11442134a91.1
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 07:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780065900; x=1780670700; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaZwo5N6cl7Wcn+YII8G1Z7wxMBnsUseTYI23WvaSW8=;
        b=VPWRGS6YroiDY44u5cYcmmCu3uHPmFxbAGXju77t5iRZlpzTBT/7jxfVZoe6lh3h60
         QyHkhMC2COnmXRc9lbvZpJXkCHFEKOLDiafXev41sh1LJYARGgdsZo4+rUU/0yuBfhlo
         PEcP/OzqAK9K3vnpHM2LHrTGhb78D56c65TRfyGY3miJUgzMHqzIXjfPBMIe4Mh3S1AH
         /e7H9MY9sp+kcgZb3/OfNcGK4ExCh5npEuSERse672OXcnJrRWleRaJEle6RzbdV8zOJ
         zsX1sSvVcZx09D7j711l9Buan3AQE0B4AgDuhyRQAkZmMxr9QlCTGEPrb1q/lZ6HaQbb
         +z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065900; x=1780670700;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DaZwo5N6cl7Wcn+YII8G1Z7wxMBnsUseTYI23WvaSW8=;
        b=SPOzFUVrUFMDoZwXomQnXTqrS3/gy3Yvm6E1srG41HNFa4A3FZi5C6h3A1ruN5SWi7
         pfJHPj3TzOEHpGPGhJgpdvrpwBf27Jgq5N+KiXiuiYdRzsNf7VTeVDD/eteDsvDzhAk9
         GIYU6wlLvZrIV1yWNsSPLRDH/mfefrj+eFe5ndLt0E40B2Q9QoTmzVpmTH10PTLZEZFC
         nLx25ZKOgaVGVIipczKMc0jTyijO0QgQe7c2jHUnLjH2RbC9dmIa/7hUmInc6dj6oHGX
         HrWTf1IT4lpxbbjd6seY+arT7SLCk9vCqMrzgg7D6zH87xUUqBtVhKPBKKmVFpCV8aeL
         D60Q==
X-Forwarded-Encrypted: i=1; AFNElJ+gF7D9NY4jwTN/okzOdQT5ZcC8J7mHchnCrGlpO1IIay4i+LL+ptPoscj/SOT95Nb0DqbM6sHV5JfN41ejhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxeKC6V+thb0E9xdJTGkseGigWJVUaWfO26Xmn23UIoTlLsR0da
	iMuRehBoMP2F+mzZPUKoohqS0NSLP2XV18Wm3e/FCJYDI3d7g2udVpAXCQe6FWgPpmY1DZD6/YA
	iGOoZCw==
X-Received: from pjte5.prod.google.com ([2002:a17:90a:c205:b0:36b:7748:4e7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3606:b0:36b:e109:1e63
 with SMTP id 98e67ed59e1d1-36be10928f2mr708703a91.27.1780065899626; Fri, 29
 May 2026 07:44:59 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 07:43:54 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529144435.704127-8-seanjc@google.com>
Subject: [PATCH v4 07/47] x86/tdx: Force TSC frequency with CPUID-based info
 provided by the TDX-Module
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
Content-Transfer-Encoding: quoted-printable

When running as a TDX guest, explicitly set the TSC frequency to a known
value, using CPUID-based information, instead of potentially relying on a
hypervisor-controlled PV routine.  For TDX guests, CPUID.0x15 is always
emulated by the TDX-Module, i.e. the information from CPUID is more
trustworthy than the information provided by the hypervisor.

To maintain backwards compatibility with TDX guest kernels that use native
calibration, and because it's the least awful option, retain
native_calibrate_tsc()'s stuffing of the local APIC bus period using the
core crystal frequency.  While it's entirely possible for the hypervisor
to emulate the APIC timer at a different frequency than the core crystal
frequency, the commonly accepted interpretation of Intel's SDM is that APIC
timer runs at the core crystal frequency when that latter is enumerated via
CPUID:

  The APIC timer frequency will be the processor=E2=80=99s bus clock or cor=
e
  crystal clock frequency (when TSC/core crystal clock ratio is enumerated
  in CPUID leaf 0x15).

If the hypervisor is malicious and deliberately runs the APIC timer at the
wrong frequency, nothing would stop the hypervisor from modifying the
frequency at any time, i.e. attempting to manually calibrate the frequency
out of paranoia would be futile.

Deliberately leave CPU frequency calibration as is, since the TDX-Module
doesn't provide any guarantees with respect to CPUID.0x16.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/tdx/tdx.c    | 20 +++++++++++++++++---
 arch/x86/include/asm/tdx.h |  2 ++
 arch/x86/kernel/tsc.c      |  3 +++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 29b6f1ed59ec..5d7976359220 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <asm/apic.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -1123,9 +1124,6 @@ void __init tdx_early_init(void)
=20
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
=20
-	/* TSC is the only reliable clock in TDX guest */
-	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-
 	cc_vendor =3D CC_VENDOR_INTEL;
=20
 	/* Configure the TD */
@@ -1195,3 +1193,19 @@ void __init tdx_early_init(void)
=20
 	tdx_announce();
 }
+
+unsigned int __init tdx_tsc_init(void)
+{
+	struct cpuid_tsc_info info;
+
+	if (WARN_ON_ONCE(cpuid_get_tsc_freq(&info)))
+		return 0;
+
+	lapic_timer_period =3D info.crystal_khz * 1000 / HZ;
+
+	/* TSC is the only reliable clock in TDX guest */
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	return info.tsc_khz;
+}
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index e5a9cf656c07..1d841d464aa4 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -67,6 +67,7 @@ struct ve_info {
 #ifdef CONFIG_INTEL_TDX_GUEST
=20
 void __init tdx_early_init(void);
+unsigned int __init tdx_tsc_init(void);
=20
 void tdx_get_ve_info(struct ve_info *ve);
=20
@@ -88,6 +89,7 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 #else
=20
 static inline void tdx_early_init(void) { };
+static inline unsigned int tdx_tsc_init(void) { return 0; }
 static inline void tdx_halt(void) { };
=20
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return fals=
e; }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 2b8f94c3fcc7..2603f136e29b 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -34,6 +34,7 @@
 #include <asm/topology.h>
 #include <asm/uv/uv.h>
 #include <asm/sev.h>
+#include <asm/tdx.h>
=20
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -1550,6 +1551,8 @@ void __init tsc_early_init(void)
 		known_tsc_khz =3D tsc_early_khz;
 	else if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		known_tsc_khz =3D snp_secure_tsc_init();
+	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		known_tsc_khz =3D tdx_tsc_init();
=20
 	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
 		return;
--=20
2.54.0.823.g6e5bcc1fc9-goog

