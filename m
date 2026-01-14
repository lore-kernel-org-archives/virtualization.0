Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7113587AA
	for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425605; cv=none; b=G6OT1rqsrWSw7o3a4oy2018zj8GhlM7DyY7lR3zhXWJU/LTNUh9JvtwnGrXPbEC5RpqeeuuFxmTksjvJvm03WBUKZhHOjUaofyBuDEirrMWthGhzFP19xKKDOq3nEm3ukz1sfjn9ca6gN+iNKx2vyFMffsTtCGs5Wvs8+XusZKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425605; c=relaxed/simple;
	bh=kpkq2j5rxRipq/uytTDNI6/jUQtKyAbYri7acGHzUwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSWjKeV4Xr3kwHLDHLbJT4+V8rUKJpE6waU9UpDAhNSIDGbe9qpRGLmHGmpm0OXrIRFAdCw71NQPjZlC6S2zSAREbYqAybtRIb27qBCSJ2pbn3fvMHIixjY7zezk6nGynNY1A8CPO2gu5igWhXEqntIjYwJYXVCL9OaAPLdTzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5XzRDDb; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5XzRDDb"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b871b6e0c70so42436266b.2
        for <virtualization@lists.linux.dev>; Wed, 14 Jan 2026 13:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768425601; x=1769030401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IIN3WvlmSxyI6hejD78KoAYfFiS9lOjkAKs4i0jX9j8=;
        b=f5XzRDDbxXzZx8a/LQymzY7ffdpVb1pnTevFbcGbKh5AA6w5U37UWZgevX3BhIN1dB
         eu8qNU+Cv6uJAnFqHscPvdiqLhbGi4zizEO5kNItOPViUJ5rhI8UcvinJd5O2hIl87jX
         jAt4nDR2pBh2W2yQ+7I/2HJpy+gdt/r20qMS+jzHHzHq8pzBiyju1pLEfKvy7KlIYyjT
         Hu9G5LqQZL7o+o04jRTtSfDmG6r7XdWHZMPEvZ/rrJsKCE63tvyub39URZXaYFiXI4/2
         tWYI2khIOoSeqlYnEoboj9D5kd3Pc3BYqWpYzD7PUH6Cn+1RoVXimDz/l9imo132ztup
         oF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768425601; x=1769030401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIN3WvlmSxyI6hejD78KoAYfFiS9lOjkAKs4i0jX9j8=;
        b=MGDRsC+La2bQlaFmho6NhxcDw3IlcVHD6ZWRnQvzrK7okZHGME1ZwBYMlPwgkkAYCx
         6jUZMj3jmiBqcRtjaYNiu6Nvg+auu7IY7Ng3NV9GQiDRhqT8Rk4sGnAU5gBiaSBn9os5
         ySzoFkTDrkYJMLO1P6bItjW0wTBgA3duat6yPUiCgk5cI6bBqt9cSsTqriBJGqlYaZkw
         3Bx665+Wkt4vfHbdD+941g3Bejr8egjUvFKEMzOL0OYWQK8hcc9MoEHqWHBs67CFcqae
         CBYi42HOdxot8Onwu/ASglgWVwWTEtwEC/odgHIzEpg7M9N149WMfPjTwKEOs0aYxWbT
         tJ6A==
X-Forwarded-Encrypted: i=1; AJvYcCUESLTljkpuZUL4KVQQ1+9Po1xr6C3g0Cs0RyeHmN16X9BFYp+RA5Kr84MQnlxzxzjcXvBdQKjUcg3Il3pP7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyy8/5znezcWEz7gsMHBnjLc3BPCoIhHM8m+3kK74KtfcVVXwnV
	94p5AD27Eg7DwCn347OhOnhv+iYr/Wid66r6PG9cvOqZV3SGSZk36SvG
X-Gm-Gg: AY/fxX7qtV2QRW2s4U4VPc7Fu0Q5+HI1kf/s8RJpwx6P5j3cPEcoXTe6HxGx+UrQmSF
	isUPBOLKKBewrMUNhnnhKamctXUBkWrkgTd2ueBfNMLWuTQ8YJK1qHq9+hWwYu+IPYclN2ZECZa
	oaxAzDPf0skbXzGx8Zd8e2g7YenlrPa2UnMcOPDDofIdlSI8cCJEhhTJDZZlOh/cEoG9TRhPgNX
	aBJE+o1Atp8w1hcSSII9bagnjpKV3oj1IB4u844dPwlByiuGiurjPl2EOEAkOVrEHOKHn5mgz0X
	755Iv1xl7dWQj1gljKAPqCIv2YrzaVB3fzRv3/p+p4r+JzRTfilshP0nENvA9lNzj42Xs6pzgD2
	Av/LE3iSJ9voWspE9gRyaq3LMN/w4ahxGxenBldH6P7s876k3E5djWU/w38rEoJpqlBMvTw9kqE
	JX+AsC2KsebYHPpdBKyidM9H6Ge48Eqp+y9ge4oqbcKpA=
X-Received: by 2002:a17:907:1c26:b0:b73:b05c:38fd with SMTP id a640c23a62f3a-b87612796ccmr367472866b.50.1768425601165;
        Wed, 14 Jan 2026 13:20:01 -0800 (PST)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8731f071e4sm683374166b.66.2026.01.14.13.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:20:00 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND 1/2]  x86/paravirt: Remove trailing semicolons from alternative asm templates
Date: Wed, 14 Jan 2026 22:18:14 +0100
Message-ID: <20260114211948.74774-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC inline asm treats semicolons as instruction separators, so a
semicolon after the last instruction is not required.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/paravirt-spinlock.h |  4 ++--
 arch/x86/include/asm/paravirt.h          | 16 ++++++++--------
 arch/x86/include/asm/paravirt_types.h    |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/paravirt-spinlock.h b/arch/x86/include/asm/paravirt-spinlock.h
index a5011ef3a6cc..458b888aba84 100644
--- a/arch/x86/include/asm/paravirt-spinlock.h
+++ b/arch/x86/include/asm/paravirt-spinlock.h
@@ -38,14 +38,14 @@ static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
 static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
 	PVOP_ALT_VCALLEE1(pv_ops_lock, queued_spin_unlock, lock,
-			  "movb $0, (%%" _ASM_ARG1 ");",
+			  "movb $0, (%%" _ASM_ARG1 ")",
 			  ALT_NOT(X86_FEATURE_PVUNLOCK));
 }
 
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
 	return PVOP_ALT_CALLEE1(bool, pv_ops_lock, vcpu_is_preempted, cpu,
-				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
+				"xor %%" _ASM_AX ", %%" _ASM_AX,
 				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
 }
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b21072af731d..3d0b92a8a557 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -117,7 +117,7 @@ static inline void write_cr0(unsigned long x)
 static __always_inline unsigned long read_cr2(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, mmu.read_cr2,
-				"mov %%cr2, %%rax;", ALT_NOT_XEN);
+				"mov %%cr2, %%rax", ALT_NOT_XEN);
 }
 
 static __always_inline void write_cr2(unsigned long x)
@@ -128,7 +128,7 @@ static __always_inline void write_cr2(unsigned long x)
 static inline unsigned long __read_cr3(void)
 {
 	return PVOP_ALT_CALL0(unsigned long, pv_ops, mmu.read_cr3,
-			      "mov %%cr3, %%rax;", ALT_NOT_XEN);
+			      "mov %%cr3, %%rax", ALT_NOT_XEN);
 }
 
 static inline void write_cr3(unsigned long x)
@@ -516,18 +516,18 @@ static inline void __set_fixmap(unsigned /* enum fixed_addresses */ idx,
 
 static __always_inline unsigned long arch_local_save_flags(void)
 {
-	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, irq.save_fl, "pushf; pop %%rax;",
+	return PVOP_ALT_CALLEE0(unsigned long, pv_ops, irq.save_fl, "pushf; pop %%rax",
 				ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_disable(void)
 {
-	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_disable, "cli;", ALT_NOT_XEN);
+	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_disable, "cli", ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_enable(void)
 {
-	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_enable, "sti;", ALT_NOT_XEN);
+	PVOP_ALT_VCALLEE0(pv_ops, irq.irq_enable, "sti", ALT_NOT_XEN);
 }
 
 static __always_inline unsigned long arch_local_irq_save(void)
@@ -553,9 +553,9 @@ static __always_inline unsigned long arch_local_irq_save(void)
 	call PARA_INDIRECT(pv_ops+PV_IRQ_save_fl);
 .endm
 
-#define SAVE_FLAGS ALTERNATIVE_2 "PARA_IRQ_save_fl;",			\
-				 "ALT_CALL_INSTR;", ALT_CALL_ALWAYS,	\
-				 "pushf; pop %rax;", ALT_NOT_XEN
+#define SAVE_FLAGS ALTERNATIVE_2 "PARA_IRQ_save_fl",			\
+				 "ALT_CALL_INSTR", ALT_CALL_ALWAYS,	\
+				 "pushf; pop %rax", ALT_NOT_XEN
 #endif
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 7ccd41628d36..9bcf6bce88f6 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -210,7 +210,7 @@ extern struct paravirt_patch_template pv_ops;
  */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE "\n\t"			\
-	"call *%[paravirt_opptr];"
+	"call *%[paravirt_opptr]"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
-- 
2.52.0

