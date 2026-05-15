Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442C389452
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872833; cv=none; b=cfycwiKyB8eSwmzjsl/743ifHb2fGtCF5tjbtfWYQz52+bARzZu1zkEjJHU6QoC6vt9wCnTv6qS3tbraoW3g4uK3qLsXbOf0m+P6BnqU4Q3Ex8KWGkRfnVxIls/XkqDzmycr9dVK9OdnxLgCNsGVaBjO9AGfq1IA7N9h+GziPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872833; c=relaxed/simple;
	bh=a/C0vtyL90QijKFqEXuRoJ0Idw3MprCujvV9iw9j0eQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jPXeTU9UFvdxBZO2Mwkcb6uXwEIImiAQBjghw9KNpnV7g55ERj34XhFFyFzCL7U71aWCBS+Hk/eQo6vIJDJPFtyyzRPSIRODzJSr4YAY9lHErrVxFth/La7Js0MOMi54U2lHiJkT79e8myufE6DbPTwjSxQu16lUvVQxp9Ii3yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOed9lYa; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOed9lYa"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bd15c00a1fso15031155ad.1
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 12:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872830; x=1779477630; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYn60803QiVrZ6qwk1MLFZ7C4I/KRQoL9rhTP31HXeM=;
        b=OOed9lYaj+ptmY+nGfKo1J9T8z/w+sM49EX3R84+chXkudurYnMyDBGe2fLZCFXzRa
         +GsXRUNSYaOcJVow1L2IxuZcUHf7UgC5gUAO/rOXeEcq8yzdtLo7Dd6JqWNz5Rt/F1Zm
         Ya1eyOJMH3/XGGdA3ZKnt+6USGUV0PtWc6pboIIEGbZTg4xTC+wT0MOYp5EIFCQUeL+c
         OyQNpHv0JIWgoxGlNtYnZDL/yE5vR6fmQd90g89jR5SmN0+EkUxYfO8pAjnnVJrJW6Az
         YHP1xrFbnmsJG85r5J+uu5jHR1sB8XcPZ6kKwGGo83QyR5yhJD4aO0LNt65cjj1NgiIZ
         fC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872830; x=1779477630;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uYn60803QiVrZ6qwk1MLFZ7C4I/KRQoL9rhTP31HXeM=;
        b=lcxZZ1bo+DCoq/E6s+8ZUTbdq42NRlgT8ad+d8Mzbm+lCDCu4qthGIIaRhXBXmm5o4
         TzG5Hp1zG2c52vJYsjjlF7uaWgHEc6nmzxXAQV2OOPa7owb7kVpqeNrcpFLcYRyJl8fN
         eWcTWWQKOTzpHEmd2IVmbb82rJdhrlzwy86Ygj5HbvLYozWEjKPSl0iOVPQNlUraFL5c
         /80tWc+5a9GcsNujv2jEsOd9bPElebHGXO+LwifRaVpZoABE64oM3WKh0IicsVCeZBkf
         qxCzuz9HolmeW1+wy1k6QSGE0i6E/GUQiKZvatFvh63h/bCdKA3JtH5UreUEYPhcECs4
         WDMg==
X-Forwarded-Encrypted: i=1; AFNElJ/341zd0+HecgubfIiGRGwSC/+nMVbgu/0dJl8lOUZY9fby72c+/9XG19FzlOrFpW3hi86pGdyRvnjIJg/Lsg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxc47LkQzJEP3Kfo0+PK6Pc+x3xm5YFtpFwWrgnJhQ7RxAidI8w
	SA1Mga47FJ0j8YxgPTGiQG410izuVQLuM6kIcP33kdDzxcr8vKkx3kgGgC9kFU/XvXgVz10Anqd
	j/T7w7Q==
X-Received: from plkj6.prod.google.com ([2002:a17:902:6906:b0:2bd:a0e6:1a81])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3843:b0:2b0:6068:4c5f
 with SMTP id d9443c01a7336-2bd526ed865mr87328355ad.8.1778872829653; Fri, 15
 May 2026 12:20:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:06 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-6-seanjc@google.com>
Subject: [PATCH v3 05/41] x86/tdx: Override PV calibration routines with
 CPUID-based calibration
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
index 29b6f1ed59ec..26890cea790b 100644
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
@@ -1195,3 +1193,29 @@ void __init tdx_early_init(void)
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
index 15eac89b0afb..60deab0ed979 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -57,6 +57,7 @@ struct ve_info {
 #ifdef CONFIG_INTEL_TDX_GUEST
=20
 void __init tdx_early_init(void);
+void __init tdx_tsc_init(void);
=20
 void tdx_get_ve_info(struct ve_info *ve);
=20
@@ -78,6 +79,7 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 #else
=20
 static inline void tdx_early_init(void) { };
+static inline void tdx_tsc_init(void) { }
 static inline void tdx_halt(void) { };
=20
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return fals=
e; }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 243999692aea..e00f53e3dd8d 100644
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
@@ -1559,8 +1560,15 @@ void __init tsc_early_init(void)
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
2.54.0.563.g4f69b47b94-goog

