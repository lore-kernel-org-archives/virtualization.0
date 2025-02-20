Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDC264630
	for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086196; cv=none; b=ZeWI1z58GhGPysQEjlKueFueSJot5amYMV5/D4215P4fZiWGFf+ahEoUIgpTMDuxBK2n9dmJ5chboxZUGVCGWlVwAvMGUQ3mdvlEMyfmuzOu5ecbdJ6oIucVyaLPPFyFbAGoNtiDB7SG+2a9TY/dPPRVUq8FJhzzgvZR7krRNxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086196; c=relaxed/simple;
	bh=j64/0D+IOGaTxz7ldob5ClxxcvWyfLbFUvwD5VjZvRI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VUq3Z3XiuqkH3rIY2TJ+o83L86WrFCIKXCD4NhRH0/PIlc35CZt/WJAU5wBec9pXZMQNPZVeam2LPlWo/lu4JcHRaNePWkJNKsCtlmlotqff5jXo8lCaQVRC+uC0pVCputTZvrhNjfqeyNsuSX6yEA7zRTt9fHE7Q0YB4RR/5oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ssvwZvcN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vannapurve.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssvwZvcN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc2e648da3so2728321a91.3
        for <virtualization@lists.linux.dev>; Thu, 20 Feb 2025 13:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740086194; x=1740690994; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jucUA/JQ/T9NlUFyZCz7f9ZdCRPjESGeAo7rjRd6P8s=;
        b=ssvwZvcNhzWebIMyeW7ED3YHQxbI5mDVajpYEBmJvOxYBRm7N2HUaSog4SsLBYSd/A
         hsy+SWDydPmq/VtU5BW1F/8eQ/8PKV9TLGYL/DYRR4XD7o1Pa7q3p9XiO+8Lm0ErBTyo
         oGAImsfwGtkV1Vc03sbh+aKnUcb1HwM2tiZCcE4ms9S5RX2EYo1LG10wZAfAzwwv3fd/
         vKQJNy/zNoAlTfyNSqI9FupTKcGAUYbJbU3/gVf2z1etGdbBHeunEvGSyGm2p58dvirZ
         oAB6pAg2/WapY0kUZvWdzYlge7Rl2BBQ+P4jIYtNz+dfLJTQp7kwYRJjKYnjI+pkwFA9
         jKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086194; x=1740690994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jucUA/JQ/T9NlUFyZCz7f9ZdCRPjESGeAo7rjRd6P8s=;
        b=mcIjSYvrvAYKMRfGofE0ZcfPE0o8GDSTEvDFsQD9/TPbfvNp+s5j7XzG9sEPqsku57
         tZAOOppn7ao83rrgC7PCLJfnpmPcFoCh4eZ2TV/+x2gcGhJN/UgiQdBimwglUvvCuQ3z
         7a74lVw924JITciGjq/3jfLY8p3yyQaLjEZuFbQN4t7Fm7eQdhZ3cr4zQvdDpH+cenBA
         Bh7WPoo8YRj91Chd5dbJK+NUFbAPDBHYnqrb12PoaBxSx/yxXMGNzREfaOXekeTOOOtG
         L906LLk9yolGLZAfLyPsWU0AVyEFFP8dvTTRMZrc9ZRi9cvKDOkESBilhCFi8sXl6Kxz
         LZdg==
X-Forwarded-Encrypted: i=1; AJvYcCVrFJBG0P8tKGS27BiBJOW+zQ7qQcLdrZJaN3Y0h6tikwQ7F9mjoczuyXhRkG0/mNOWvoBTt3EZx9k4JYqafQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/KdKI6iD+3Eemsq3SMu4u+r8ok8rywtmxL37Ub/i07CD/3X5o
	N3HZEzvHOUkusfaoKtaKN9lwho0Hw/oenE0CrunguoXYqp/FNpVu8oCY86NIkmuyrrlgTZIcfhq
	gBJOU9ArHGgC8tPZ3uQ==
X-Google-Smtp-Source: AGHT+IHh3x3EGS74NK++hfT4v9NtijBoByW8UYHF5iGLBomtROq0LcUnyfxIslhZqBj2B6aLVfi3E50UL6QRSyPs
X-Received: from pjz8.prod.google.com ([2002:a17:90b:56c8:b0:2fc:c98:ea47])
 (user=vannapurve job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3904:b0:2ee:c918:cd60 with SMTP id 98e67ed59e1d1-2fce78cda3fmr1090173a91.20.1740086194135;
 Thu, 20 Feb 2025 13:16:34 -0800 (PST)
Date: Thu, 20 Feb 2025 21:16:25 +0000
In-Reply-To: <20250220211628.1832258-1-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250220211628.1832258-1-vannapurve@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220211628.1832258-2-vannapurve@google.com>
Subject: [PATCH V5 1/4] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
From: Vishal Annapurve <vannapurve@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	virtualization@lists.linux.dev
Cc: pbonzini@redhat.com, seanjc@google.com, erdemaktas@google.com, 
	ackerleytng@google.com, jxgao@google.com, sagis@google.com, oupton@google.com, 
	pgonda@google.com, kirill@shutemov.name, dave.hansen@linux.intel.com, 
	chao.p.peng@linux.intel.com, isaku.yamahata@gmail.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, jgross@suse.com, 
	ajay.kaher@broadcom.com, alexey.amakhalov@broadcom.com, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, stable@vger.kernel.org, 
	Andi Kleen <ak@linux.intel.com>, Tony Luck <tony.luck@intel.com>, 
	Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
other VM guest types, features supported under CONFIG_PARAVIRT
are self sufficient. CONFIG_PARAVIRT mainly provides support for
TLB flush operations and time related operations.

For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
most of its requirement except the need of HLT and SAFE_HLT
paravirt calls, which is currently defined under
CONFIG_PARAVIRT_XXL.

Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
like platforms, move HLT and SAFE_HLT paravirt calls under
CONFIG_PARAVIRT.

Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
break any functionality for current users of CONFIG_PARAVIRT.

Cc: stable@vger.kernel.org
Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/kernel/paravirt.c            | 14 ++++++----
 4 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index cf7fc2b8e3ce..1c2db11a2c3c 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -76,6 +76,28 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 
 #endif
 
+#ifndef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static __always_inline void arch_safe_halt(void)
+{
+	native_safe_halt();
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static __always_inline void halt(void)
+{
+	native_halt();
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
@@ -97,24 +119,6 @@ static __always_inline void arch_local_irq_enable(void)
 	native_irq_enable();
 }
 
-/*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static __always_inline void arch_safe_halt(void)
-{
-	native_safe_halt();
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static __always_inline void halt(void)
-{
-	native_halt();
-}
-
 /*
  * For spinlocks, etc:
  */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 041aff51eb50..29e7331a0c98 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -107,6 +107,16 @@ static inline void notify_page_enc_status_changed(unsigned long pfn,
 	PVOP_VCALL3(mmu.notify_page_enc_status_changed, pfn, npages, enc);
 }
 
+static __always_inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(irq.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(irq.halt);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -170,16 +180,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static __always_inline void arch_safe_halt(void)
-{
-	PVOP_VCALL0(irq.safe_halt);
-}
-
-static inline void halt(void)
-{
-	PVOP_VCALL0(irq.halt);
-}
-
 static inline u64 paravirt_read_msr(unsigned msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index fea56b04f436..abccfccc2e3f 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -120,10 +120,9 @@ struct pv_irq_ops {
 	struct paravirt_callee_save save_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
+#endif
 	void (*safe_halt)(void);
 	void (*halt)(void);
-#endif
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 1ccaa3397a67..c5bb980b8a67 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -110,6 +110,11 @@ int paravirt_disable_iospace(void)
 	return request_resource(&ioport_resource, &reserve_ioports);
 }
 
+static noinstr void pv_native_safe_halt(void)
+{
+	native_safe_halt();
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static noinstr void pv_native_write_cr2(unsigned long val)
 {
@@ -125,11 +130,6 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
 {
 	native_set_debugreg(regno, val);
 }
-
-static noinstr void pv_native_safe_halt(void)
-{
-	native_safe_halt();
-}
 #endif
 
 struct pv_info pv_info = {
@@ -186,9 +186,11 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(pv_native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
+#endif /* CONFIG_PARAVIRT_XXL */
+
+	/* Irq HLT ops. */
 	.irq.safe_halt		= pv_native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
-- 
2.48.1.601.g30ceb7b040-goog

