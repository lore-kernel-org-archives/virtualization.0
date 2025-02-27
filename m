Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E917A30F
	for <virtualization@lists.linux.dev>; Thu, 27 Feb 2025 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622756; cv=none; b=szkrF2uMt/chBXk3CozrR/5aXiDMaEa4S5SVZXR8oWohAA1UJXomw5WZZcBHkBR6gcVOpTaQ6ZD6pxwPB/I4QXFQRYRZE2yF/pWX/dN/37ihpt/s1o35+d3FRE/sj+QNg1JeYcF8OJcexuBB8W8iwFPCOfJwGNXC0+tfyg9CMzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622756; c=relaxed/simple;
	bh=B8tyPzR9PoDE2Pr64h/qBiff7qyIpoEROZEEit/hX78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r59Umboe7DF8W2p4C3E0nWmQP7B6NAoygMid+ZUfJmoZOVHEEqfNC7F+VdiL0ycYDViba7n4JBTAwtJclPPlJj9YmD/rB074DCeop/uTi4fPrBa/SB6Z14AqBwEhZrjE8nkIU+XhoLBYEJi6MLhSM2w1rUic950cgE5IDGJ92sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVoqd+PN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVoqd+PN"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-220e04e67e2so10180935ad.2
        for <virtualization@lists.linux.dev>; Wed, 26 Feb 2025 18:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622754; x=1741227554; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yramOYZYSvDmgSz8M8zEvByRhd31043Cze2FYqM0HuQ=;
        b=uVoqd+PN9fMPhIytilW3JPDMr7lx9Tosw4DbaCnPszxH7NpM/gdb+PfK6+QwtJwtQI
         Zc5hUD126xEzjLMkofyEYkXw60k8TqTVssYSt10OtSOcBtFF7h+k7L8aZ6LzQu95kHY5
         4BeWeedSiD8CNItLPQrco6UbH7JyrL7J+K+vWooXlECyrjM8SicfvY9NXX1cOH8oDy2Z
         be5XkETDtJfETxyBU0TO85KKsj2u7qp9I85ooObqg+gG/zVyT5uvc7dgXYZS/nne8PBs
         hVxQYLkSpmBCIoKuq1yukb1JM7mEFGUnQOA7PbLVhKBaW5ISJQqAYpuzsUFuq8vzha1z
         GOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622754; x=1741227554;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yramOYZYSvDmgSz8M8zEvByRhd31043Cze2FYqM0HuQ=;
        b=hZ435uOVyZy4J/YVaRPZp3ZD9kRJt/cFzZGzxjM5USP5Po3nWUJ6aNKy0/iAy0YG4r
         3GGiGhFDfpMHEWlEfJP1mxYCyEkhqw6eRAQTya9UZBUeLd0dNyHTnUyN7ynIf7zOGiGr
         7EbE46BBxLJPutddhAavE7L/qNPLtN8aO0JLiid2VQuJq+NyuOnzu+GZkdRqV0oayjxK
         CZPQbmUzE3besJOLbOsdGPZ9mujurFzEXPD/ZlAEaUTL/KooMih519IUC2IBOcHXfGyY
         VhelYDO2/508FjzWO4bsOhChtj8ArqJlUBnetE90dGlpaclHqK6UcvuNcfcnxfg5LSBk
         Wazg==
X-Forwarded-Encrypted: i=1; AJvYcCXXULxauymSq3qq1k/BBqZynPMBiKlQS/9Ms/HHuGxxkxN3muRinMACadeqDuInjnFnDDgx4ekv7k+u67yGCA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRc1XPoTn1J105Jlx26EhSzJxjYHnS25Y0/590KcCZBHWt/Idy
	r/eWTHZXw6bg3gRVcPa325UlQGNEK5Ts1CggSIHTV9zhaSL6CcyY0GNc2eAcyrYohiR5qSnegep
	UNA==
X-Google-Smtp-Source: AGHT+IEj/1REcONxv6g8r36LvNpCxOj7lRlC5Gm8UGTSETJJJpMqJ2Q+yEo6DBGNGx6TMjORq5yBRC/aLmE=
X-Received: from pfbf4.prod.google.com ([2002:a05:6a00:ad84:b0:730:94db:d304])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dacc:b0:220:d6ac:b5a3
 with SMTP id d9443c01a7336-22320214b94mr83920905ad.51.1740622753535; Wed, 26
 Feb 2025 18:19:13 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 26 Feb 2025 18:18:22 -0800
In-Reply-To: <20250227021855.3257188-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250227021855.3257188-1-seanjc@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250227021855.3257188-7-seanjc@google.com>
Subject: [PATCH v2 06/38] x86/tdx: Override PV calibration routines with
 CPUID-based calibration
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
Content-Transfer-Encoding: quoted-printable

When running as a TDX guest, explicitly override the TSC frequency
calibration routine with CPUID-based calibration instead of potentially
relying on a hypervisor-controlled PV routine.  For TDX guests, CPUID.0x15
is always emulated by the TDX-Module, i.e. the information from CPUID is
more trustworthy than the information provided by the hypervisor.

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

Deliberately leave the CPU frequency calibration routine as is, since the
TDX-Module doesn't provide any guarantees with respect to CPUID.0x16.

Opportunistically add a comment explaining that CoCo TSC initialization
needs to come after hypervisor specific initialization.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/coco/tdx/tdx.c    | 30 +++++++++++++++++++++++++++---
 arch/x86/include/asm/tdx.h |  2 ++
 arch/x86/kernel/tsc.c      |  8 ++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32809a06dab4..42cdaa98dc5e 100644
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
@@ -1063,9 +1064,6 @@ void __init tdx_early_init(void)
=20
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
=20
-	/* TSC is the only reliable clock in TDX guest */
-	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-
 	cc_vendor =3D CC_VENDOR_INTEL;
=20
 	/* Configure the TD */
@@ -1122,3 +1120,29 @@ void __init tdx_early_init(void)
=20
 	tdx_announce();
 }
+
+static unsigned long tdx_get_tsc_khz(void)
+{
+	struct cpuid_tsc_info info;
+
+	if (WARN_ON_ONCE(cpuid_get_tsc_freq(&info)))
+		return 0;
+
+	lapic_timer_period =3D info.crystal_khz * 1000 / HZ;
+
+	return info.tsc_khz;
+}
+
+void __init tdx_tsc_init(void)
+{
+	/* TSC is the only reliable clock in TDX guest */
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	/*
+	 * Override the PV calibration routines (if set) with more trustworthy
+	 * CPUID-based calibration.  The TDX module emulates CPUID, whereas any
+	 * PV information is provided by the hypervisor.
+	 */
+	tsc_register_calibration_routines(tdx_get_tsc_khz, NULL);
+}
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b4b16dafd55e..621fbdd101e2 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -53,6 +53,7 @@ struct ve_info {
 #ifdef CONFIG_INTEL_TDX_GUEST
=20
 void __init tdx_early_init(void);
+void __init tdx_tsc_init(void);
=20
 void tdx_get_ve_info(struct ve_info *ve);
=20
@@ -72,6 +73,7 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 #else
=20
 static inline void tdx_early_init(void) { };
+static inline void tdx_tsc_init(void) { }
 static inline void tdx_safe_halt(void) { };
=20
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return fals=
e; }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6a011cd1ff94..472d6c71d3a5 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -32,6 +32,7 @@
 #include <asm/topology.h>
 #include <asm/uv/uv.h>
 #include <asm/sev.h>
+#include <asm/tdx.h>
=20
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -1563,8 +1564,15 @@ void __init tsc_early_init(void)
 	if (is_early_uv_system())
 		return;
=20
+	/*
+	 * Do CoCo specific "secure" TSC initialization *after* hypervisor
+	 * platform initialization so that the secure variant can override the
+	 * hypervisor's PV calibration routine with a more trusted method.
+	 */
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		snp_secure_tsc_init();
+	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		tdx_tsc_init();
=20
 	if (!determine_cpu_tsc_frequencies(true))
 		return;
--=20
2.48.1.711.g2feabab25a-goog

