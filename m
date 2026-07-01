Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A74D90CA
	for <virtualization@lists.linux.dev>; Wed,  1 Jul 2026 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934364; cv=none; b=AHRDkmdtltGsiIkfGFmIh4jdzXASaRecuRXeoVqwrBzAtJLU1vlpPFILozWvnlhJskeoZHaoR6sUBrxb1e+2Oq9IUbf95MNsNey7Ev5aSVuYaXD5lZrM1NOElECZdPLCfVRWkVzCWxZY4Ka4snIH73CxoP7kJSuDBiCYP1avNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934364; c=relaxed/simple;
	bh=TSqYUQkRbJlpxrOkrZmCMz7zJ2lM6jVmciyHqTKBboc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WE+oHER61D/MMzRTn3uAOjQSM8lZ56e2UoQpVXyfr6eG0IcZO39fVX8AjxcwYDecFDHZT0BR4RhCNxEdejj18Dm3VW+nTXq7woMBDTdI33kVwqN9J3xzdVLhwYwllauPPSbOrMN/UYOjZySpu/PXSp2jpkt129D98N5r9/mpITc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lZgGwecs; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lZgGwecs"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c88d7a75507so1270149a12.1
        for <virtualization@lists.linux.dev>; Wed, 01 Jul 2026 12:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934358; x=1783539158; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dPlSt+N6Lt/Y9ZvBDGnN+olGzf3s7mk8869JKIa0HY=;
        b=lZgGwecsiaQPTGTTMUQ/wK0tGAF6oUlnTUVIraiKNdc4MHzRNFmjU+sC1S6LL194uN
         B0iRWFgk4JDvhpy28l+3iRqTVh91CFA8d1EXWpkJ7hOSDrxQrJRdrVCcN+nl+n7JH3kX
         0xEtFDy389cx39ldG1rJOrFSBJOwVjuvYFi6fETMOlycX2LpD/IiHH97qlTcXetEs5s4
         9wstafEoh0VO8UaFKcWgigMYllneEgATUmIfa+YpzIxjlpmIQMdh/Ik13uIjXdqmwVhG
         Pk5jH8tTG6wLlTmRdO/peK64zPjdeJOOjdHFzPyIdks5y9YcSdrWd0V7dekvG8jci41Y
         fgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934358; x=1783539158;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5dPlSt+N6Lt/Y9ZvBDGnN+olGzf3s7mk8869JKIa0HY=;
        b=Erimmx60stFI68R+u0wZ7hyj910el5Dn6TvELBHN71WCDZRVKk6DRzPBsVaEGFs1EG
         XxVYO3KRhsNd/0aOdySZSV/Shr9ibJjg2UDD/GCz3MObUT+iNbrvfoKaxwIbmWLdnn2/
         9XXa+tiwM/OSD9mOzk4WsPc8pXwxE0PS81jZL5oMRvJ3hipsnaWxgsV7RK5gu+lzYBDe
         vrVtqYXQwUUe4uxwdY8MfRXxd1xJSarG+nQGOdPK1JlcVf+DgtgmyGJkRBpZlTHI1jQX
         FCq2MUPMiFd5vAN1L7sigtaJEU4FTacoRCbIRXTNE7kK102aob3VJHQrng5cRwBfAtEi
         ARwQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0kn3JSvqrcBiqkG7uZaIHGYUumXnkqtI5ij3uFlgtlxPodlHhMfta7n4+Fua5Dgb3ABfes9HYNvTwZJIkSA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzrVBmrNXUC/h54xgmkFKhVSSrVRd48vllqx27muupc2LZQwpXt
	YRRCxDLKjNPsnn/7XGqnKS95IuZvUKhm3dHhqhs+XDkrCl4Ipp2ixSiIEiq4DeDsSddn9mLj2PU
	eLqH9rA==
X-Received: from pgmo11.prod.google.com ([2002:a63:5d4b:0:b0:c9e:63b8:11b5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d10e:b0:3b4:61f:1fec
 with SMTP id adf61e73a8af0-3bfed1c323amr3402841637.2.1782934358113; Wed, 01
 Jul 2026 12:32:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:31 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-11-seanjc@google.com>
Subject: [PATCH v5 10/51] x86/tdx: Force TSC frequency with CPUID-based info
 provided by the TDX-Module
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

Expose and use cpuid_get_tsc_info() instead of providing a wrapper to
get the TSC and core crystal frequency, as TDX is the only anticipated
user outside of the TSC code, i.e. adding a helper to dedup the math won't
actually dedup anything.  Having TDX use "struct cpuid_tsc_info" also
avoids the temptation of declaring a local "tsc_khz" variable and thus
unintentionally creating a shadow of the global "tsc_khz".

Cc: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++--
 arch/x86/coco/tdx/tdx.c                       | 20 ++++++++++++++++---
 arch/x86/include/asm/tdx.h                    |  2 ++
 arch/x86/include/asm/tsc.h                    |  7 +++++++
 arch/x86/kernel/tsc.c                         | 11 ++++------
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 181149f633c3..490e6aa72fc2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7947,8 +7947,8 @@ Kernel parameters
 			Format: <unsigned int>
=20
 			Note, tsc_early_khz is ignored if the TSC frequency is
-			provided by trusted firmware when running as an SNP
-			guest.
+			provided by trusted firmware when running as an SNP or
+			TDX guest.
=20
 	tsx=3D		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 29b6f1ed59ec..ae2d35f2ef33 100644
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
+	if (WARN_ON_ONCE(cpuid_get_tsc_info(&info) || !info.crystal_khz))
+		return 0;
+
+	apic_set_timer_period_khz(info.crystal_khz, "TDX-Module via CPUID");
+
+	/* TSC is the only reliable clock in TDX guest */
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	return info.crystal_khz * info.numerator / info.denominator;
+}
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d8..d23ff06db41a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -68,6 +68,7 @@ struct ve_info {
 #ifdef CONFIG_INTEL_TDX_GUEST
=20
 void __init tdx_early_init(void);
+unsigned int __init tdx_tsc_init(void);
=20
 void tdx_get_ve_info(struct ve_info *ve);
=20
@@ -89,6 +90,7 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 #else
=20
 static inline void tdx_early_init(void) { };
+static inline unsigned int tdx_tsc_init(void) { return 0; }
 static inline void tdx_halt(void) { };
=20
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return fals=
e; }
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 4d2d2f21ff06..b6b86e24e1bf 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -82,6 +82,13 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
=20
+struct cpuid_tsc_info {
+	unsigned int denominator;
+	unsigned int numerator;
+	unsigned int crystal_khz;
+};
+extern int cpuid_get_tsc_info(struct cpuid_tsc_info *info);
+
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 12043812c8f5..86384a83a5f6 100644
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
@@ -645,13 +646,7 @@ static unsigned long quick_pit_calibrate(void)
 	return delta;
 }
=20
-struct cpuid_tsc_info {
-	unsigned int denominator;
-	unsigned int numerator;
-	unsigned int crystal_khz;
-};
-
-static int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
+int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
 {
 	unsigned int ecx_hz, edx;
=20
@@ -1529,6 +1524,8 @@ void __init tsc_early_init(void)
=20
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		known_tsc_khz =3D snp_secure_tsc_init();
+	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		known_tsc_khz =3D tdx_tsc_init();
=20
 	/*
 	 * Ignore the user-provided TSC frequency if the exact frequency was
--=20
2.55.0.rc0.799.gd6f94ed593-goog

