Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A9224EA
	for <virtualization@lists.linux.dev>; Tue, 25 Feb 2025 00:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444445; cv=none; b=L1b2x4/ZKpdzHneOqhiU9RiXFPM51M1OBNrzRBdYShpWTD0ceTgv67mEIaeKDEKLXyMLcwfSlMXpITIZiq+D2Cb3VIx7mTpTeJ3GtK6PbXrNBgtWDJgLRJy2MBCZ64xyvWsVwK3vYm18JNmT9VwlAJzhsnSVsfz5taFS+KwS430=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444445; c=relaxed/simple;
	bh=iHJaUeFoAWphLfCjsYML3X/VoIYmwlw5kToWD4VsQ0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=i8caD1L+gweynbLVyd1at06f1mYQT0c8ieNpr7Ze/eaB7E5Y27JDyf0xl1C3FnKUV9p1ooOvdNaDBOhP+gL1uHj4OBJHaxNlKrOh7lnvSCfsjPXBXa/oV1wM/ZuWmnhHJmImW7UoMUIRIlsOfpSqhSEFzLOo8IUBh/tc2PLT07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=naGX/MF9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="naGX/MF9"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-220c1f88eb4so79808705ad.2
        for <virtualization@lists.linux.dev>; Mon, 24 Feb 2025 16:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740444443; x=1741049243; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GSwXzpaQg6jWvjSpCxDF7Wv8BuKNQfehCGdAdnzxu5w=;
        b=naGX/MF9gHmIJ2feiQzd+25NgHqFBVa55GbcHz22Cd4Qw+ijJk488Phfr9rZyRdU+F
         rcetbnv8dRz/hhaf8Ol1Hl3YR4Q1w13tzcRztVS7kNfZ/eiSKokv+igdMeuptFWCKZIe
         JRa9EAUwdsQm1vVnHV4YpyrOFBqXZqX9VLtHXcXo/AojKTaHZOvkLxOWlCm4pakrDE+T
         BS2Vnphw+2fvh+U/MsCNnGajDBCFOPjnbq8EsWlNfG++j8ZWx3Zc3Z/FQyMg/llrn6iX
         3xateYNqgLRrIsmQ1SR1UeHtUTCci96pk07Z/Xr8lNGzcLN0FcHrzORxv+Rsbe4ZPzz+
         IB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740444443; x=1741049243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSwXzpaQg6jWvjSpCxDF7Wv8BuKNQfehCGdAdnzxu5w=;
        b=nzaalW+ez5egPqA0G83p6YzufKlCx1MJ6CiybmtCUfM+jZf4ZRQnDXe3F6SojkgwT6
         zaB+Wq1Bk4CuW6FFek41wHBw9n4z91T8rfOW2BmFmeUSASzzzAu5sT83p1NKlbRJ7qX0
         wArH8qP+DpO+sGxVOus2E9RcGKbK5XbJY3fEqYSVxhPhsPjEoR/4Mzx8qaGORtLdnZWn
         sZ0sEFxvpD/gmjuZcYOdbc17g1WBtjmd7KY79G1UiIHj13ABRLB2EjQ2IvY1o0QMH0D8
         LEp/9JZu+RJmoHtVADewddvg44JsMhNabHL1v4X27V7NjMo4PQ6ISU5zDt1GFV6afCLu
         mwPg==
X-Forwarded-Encrypted: i=1; AJvYcCU1e7jNfzRPy3k9sn8iLwjqPdJU3xgf0cT/IegqM98ddsaro6+6sW+JILL/EWOeQjMyVLYLZQ3OWnWCCUMxWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx8V06TU931yFxVn1AeyicpevGD7kIrQokllHofyVao/dlm/G4q
	/nv7C1WcQ3kXlFvGHct5P72g7yjlD2RYj8bsThjRHQDf3T8XQbuZQgphv+ZXOdxiKPMiYdCa/iW
	o/THTWKwMY/7W/INZXA==
X-Google-Smtp-Source: AGHT+IENsRnPp7jn8IuysVjH0YnI4eclJId+egEJWA+BbEYzZDe3tiL9fs29LuBPMsnBKu2yRyxTuOgeH23qbt74
X-Received: from plfn11.prod.google.com ([2002:a17:902:e54b:b0:21f:4ecc:af8d])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f705:b0:220:d257:cdbd with SMTP id d9443c01a7336-2219ffbf52emr272898735ad.48.1740444442957;
 Mon, 24 Feb 2025 16:47:22 -0800 (PST)
Date: Tue, 25 Feb 2025 00:47:03 +0000
In-Reply-To: <20250225004704.603652-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250225004704.603652-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250225004704.603652-3-vannapurve@google.com>
Subject: [PATCH v6 2/3] x86/tdx: Fix arch_safe_halt() execution for TDX VMs
From: Vishal Annapurve <vannapurve@google.com>
To: dave.hansen@linux.intel.com, kirill.shutemov@linux.intel.com, 
	jgross@suse.com, ajay.kaher@broadcom.com, ak@linux.intel.com, 
	tony.luck@intel.com, thomas.lendacky@amd.com
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	pbonzini@redhat.com, seanjc@google.com, kai.huang@intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, 
	afranji@google.com, kees@kernel.org, jikos@kernel.org, peterz@infradead.org, 
	x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev, bcm-kernel-feedback-list@broadcom.com, 
	Vishal Annapurve <vannapurve@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Direct HLT instruction execution causes #VEs for TDX VMs which is routed
to hypervisor via TDCALL. If HLT is executed in STI-shadow, resulting #VE
handler will enable interrupts before TDCALL is routed to hypervisor
leading to missed wakeup events.

Current TDX spec doesn't expose interruptibility state information to
allow #VE handler to selectively enable interrupts. To bypass this
issue, TDX VMs need to replace "sti;hlt" execution with direct TDCALL
followed by explicit interrupt flag update.

Commit bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
prevented the idle routines from executing HLT instruction in STI-shadow.
But it missed the paravirt routine which can be reached like this as an
example:
        acpi_safe_halt() =>
        raw_safe_halt()  =>
        arch_safe_halt() =>
        irq.safe_halt()  =>
        pv_native_safe_halt()

To reliably handle arch_safe_halt() for TDX VMs, introduce explicit
dependency on CONFIG_PARAVIRT and override paravirt halt()/safe_halt()
routines with TDX-safe versions that execute direct TDCALL and needed
interrupt flag updates. Executing direct TDCALL brings in additional
benefit of avoiding HLT related #VEs altogether.

Cc: stable@vger.kernel.org
Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/Kconfig           |  1 +
 arch/x86/coco/tdx/tdx.c    | 26 +++++++++++++++++++++++++-
 arch/x86/include/asm/tdx.h |  2 +-
 arch/x86/kernel/process.c  |  2 +-
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be2c311f5118..933c046e8966 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -902,6 +902,7 @@ config INTEL_TDX_GUEST
 	depends on X86_64 && CPU_SUP_INTEL
 	depends on X86_X2APIC
 	depends on EFI_STUB
+	depends on PARAVIRT
 	select ARCH_HAS_CC_PLATFORM
 	select X86_MEM_ENCRYPT
 	select X86_MCE
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 32809a06dab4..6aad910d119d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -14,6 +14,7 @@
 #include <asm/ia32.h>
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
+#include <asm/paravirt_types.h>
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
 #include <asm/traps.h>
@@ -398,7 +399,7 @@ static int handle_halt(struct ve_info *ve)
 	return ve_instr_len(ve);
 }
 
-void __cpuidle tdx_safe_halt(void)
+void __cpuidle tdx_halt(void)
 {
 	const bool irq_disabled = false;
 
@@ -409,6 +410,16 @@ void __cpuidle tdx_safe_halt(void)
 		WARN_ONCE(1, "HLT instruction emulation failed\n");
 }
 
+static void __cpuidle tdx_safe_halt(void)
+{
+	tdx_halt();
+	/*
+	 * "__cpuidle" section doesn't support instrumentation, so stick
+	 * with raw_* variant that avoids tracing hooks.
+	 */
+	raw_local_irq_enable();
+}
+
 static int read_msr(struct pt_regs *regs, struct ve_info *ve)
 {
 	struct tdx_module_args args = {
@@ -1109,6 +1120,19 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
 	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
 
+	/*
+	 * Avoid "sti;hlt" execution in TDX guests as HLT induces a #VE that
+	 * will enable interrupts before HLT TDCALL invocation if executed
+	 * in STI-shadow, possibly resulting in missed wakeup events.
+	 *
+	 * Modify all possible HLT execution paths to use TDX specific routines
+	 * that directly execute TDCALL and toggle the interrupt state as
+	 * needed after TDCALL completion. This also reduces HLT related #VEs
+	 * in addition to having a reliable halt logic execution.
+	 */
+	pv_ops.irq.safe_halt = tdx_safe_halt;
+	pv_ops.irq.halt = tdx_halt;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b4b16dafd55e..393ee2dfaab1 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -58,7 +58,7 @@ void tdx_get_ve_info(struct ve_info *ve);
 
 bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
-void tdx_safe_halt(void);
+void tdx_halt(void);
 
 bool tdx_early_handle_ve(struct pt_regs *regs);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 6da6769d7254..d11956a178df 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -934,7 +934,7 @@ void __init select_idle_routine(void)
 		static_call_update(x86_idle, mwait_idle);
 	} else if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		pr_info("using TDX aware idle routine\n");
-		static_call_update(x86_idle, tdx_safe_halt);
+		static_call_update(x86_idle, tdx_halt);
 	} else {
 		static_call_update(x86_idle, default_idle);
 	}
-- 
2.48.1.658.g4767266eb4-goog

