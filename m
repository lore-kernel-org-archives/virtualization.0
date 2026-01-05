Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EE229B18
	for <virtualization@lists.linux.dev>; Mon,  5 Jan 2026 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767606002; cv=none; b=nboXBbI5tRN57NABTF/SAc7JxXg4d55e1Y+KP8r9uC4MdODa+odgyFvegZ7PPxvxG89v77oHvpVrTwF6aLhDcYBlnp4rV9yjWjZNGIJnVgzI+fciGwJ4/ahKtZWePgcT5S6RGn4rGj5html1QrRJMLv+G+rzlcWXjiOV9wL2Pms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767606002; c=relaxed/simple;
	bh=J2XildmQCfxVlEApYCEkMybtj7PoWd1UBnxH99WhVGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivafp7LkfQqHiv8b7BlcD2gyOHLsTYt1UOHgFWbS6vIAIbNPQ4wx47kjQwvArqHFAiveA6exjAGcNxodEAfRUfCNOZQzbtQvHU0Vt2WULr8iLdAQKHCKFxB0OWoUAyzWPEvNT+QKytSxtDgGRNJyJVkP3Ngkqui4LeeMve/ADNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3kc/sEL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3kc/sEL"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7cee045187so297816366b.0
        for <virtualization@lists.linux.dev>; Mon, 05 Jan 2026 01:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767605996; x=1768210796; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ejPTV1YQlINaF0NnGqx/E3gWzKj3Gu6SnBl5RjerbsA=;
        b=h3kc/sELuE8h+btSKkvvT3XQ0Nf2APt3Dpu2Nhpce15b6a8IeU56A6qApTXRqEDa8J
         c4XrsW877OK7kC5ZdXU8MJ/rsJWnnRKKMm2GcVBX/qw90H7aT4nGoq0GwxMwZRzYL+uU
         332IujstWtodzHMyELFtkEZxV5triKYkvLvMAyxY+yvtTP3Pq612AYlXkXRQpGNbcFop
         M45iET8lRuMYQy1YH6aDFDNb+EOB4deiST0eO7PAvuzpzq9mZ0WE/9dAFpPewoJ9H9/s
         HUG9WmLynn3/65MIFTwH1qq3jy0GZrRqu4MuS1hqsLHp2gkejHM84O2f4wUAUpFv636m
         fF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767605996; x=1768210796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejPTV1YQlINaF0NnGqx/E3gWzKj3Gu6SnBl5RjerbsA=;
        b=pWbzQMUTlQzV+cSiG7p3K6pb8P50C8XIkUknhTwdjLtvJDOQT0z5/Nm9uwMjWFfMGB
         8wG2rOW6rP0hhJWk62JEizOzmrNTR7BIea6PupFtIFYCEhk5H2O8ZjwNLvndRC9+oPdw
         LSTo+f/6kXsAQx77ZaEPERtj0hICXVRIEootFZjvrrq1Rj/dPX+StCV2SQOeDRrjJ60J
         YwYuSHU9sUQ8zWddEMiWAghGLd77aMUvZPcXp2UI5DuxtJmwj3yNVv6GEvQyWy5h/4rV
         GAXLdTU7QY+7nCRAm/3QKyHBUyRtSH7Fgm/2nGY16ViFlf127ngy0/8XFmsRD2iI2kir
         sx7A==
X-Forwarded-Encrypted: i=1; AJvYcCVnE8iC+5vZNfGeaMgR1NXV2VtHqA67xWpIaWliKVJA0dmydiVb9pdl5ltHeMkZISBmStrIh7DgazVmKHWLpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjI89gVbx9BTnNXhecBKf04f5wayAGUWv6rHewgsCqFyq44wHN
	x1KADj1897ez2879HW0WI0mDOXuUK9CJyVl6x5fOMvk+ls1d20ngKIzy
X-Gm-Gg: AY/fxX6zaOp+tgk0MKDYdsZ76mCX/6SlMWSOg+MyLPnCxsh1vLs3rzVSqBTVT//JCUb
	VI8jv5vbxcd8KUIjg3R4yn1CU1RW9Mm150/jEubhguhX8zTgYQ4OHrA5AX2sRGNomm1jPD54KCw
	rvUdw9E7ZHNUiwsqwQpYb1DCQUOsWss4bdUiC9YKLKr2uRGE5u/+K48KIOQbIyZFpmznO89hiW6
	AuyNzOiydA6/ngou+4j0+nCyYnQU2pCAsGiX1eBpi7OZdwd4iBDXCiHeHpOBQKBmlOzU3EXn3Jt
	UcNKI4u0WfGa/8YwDODH6dPJdYtEr7RrJi2vrf1f7bV85SR2IccXdIfcPZepXwWKm9NTYXduGkE
	Ub1BdPdjB3XTbrmxOKk1AwiGHItnD7V/JX7RE1QE+JwlQ1P5uxyx2xXB7uNy9SYv/H+vwXp3bpq
	MjSwyAJN+FNBO95V5F0eR8UGFYOEQg4PLW8SjMb+DgXtHT4GcujM2a+A==
X-Google-Smtp-Source: AGHT+IHvpCMV0KoZLws8GO2wNXuQMJhpok5nVP3HUVP+ojrDeqdgW6nq1JW6E4rt0jHjq8N4Ot0B+w==
X-Received: by 2002:a17:907:800e:b0:b83:3295:15d2 with SMTP id a640c23a62f3a-b83e2604430mr456511366b.30.1767605995615;
        Mon, 05 Jan 2026 01:39:55 -0800 (PST)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de11dasm5393543466b.35.2026.01.05.01.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 01:39:54 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RESEND 1/2] x86/paravirt: Remove trailing semicolons from alternative asm templates
Date: Mon,  5 Jan 2026 10:39:06 +0100
Message-ID: <20260105093944.52387-1-ubizjak@gmail.com>
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
Cc: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: Alexey Makhalov <alexey.makhalov@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/include/asm/paravirt.h       | 20 ++++++++++----------
 arch/x86/include/asm/paravirt_types.h |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index b5e59a7ba0d0..4f6ec60b4cb3 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -151,7 +151,7 @@ static inline void write_cr0(unsigned long x)
 static __always_inline unsigned long read_cr2(void)
 {
 	return PVOP_ALT_CALLEE0(unsigned long, mmu.read_cr2,
-				"mov %%cr2, %%rax;", ALT_NOT_XEN);
+				"mov %%cr2, %%rax", ALT_NOT_XEN);
 }
 
 static __always_inline void write_cr2(unsigned long x)
@@ -162,7 +162,7 @@ static __always_inline void write_cr2(unsigned long x)
 static inline unsigned long __read_cr3(void)
 {
 	return PVOP_ALT_CALL0(unsigned long, mmu.read_cr3,
-			      "mov %%cr3, %%rax;", ALT_NOT_XEN);
+			      "mov %%cr3, %%rax", ALT_NOT_XEN);
 }
 
 static inline void write_cr3(unsigned long x)
@@ -560,7 +560,7 @@ static __always_inline void pv_queued_spin_lock_slowpath(struct qspinlock *lock,
 static __always_inline void pv_queued_spin_unlock(struct qspinlock *lock)
 {
 	PVOP_ALT_VCALLEE1(lock.queued_spin_unlock, lock,
-			  "movb $0, (%%" _ASM_ARG1 ");",
+			  "movb $0, (%%" _ASM_ARG1 ")",
 			  ALT_NOT(X86_FEATURE_PVUNLOCK));
 }
 
@@ -577,7 +577,7 @@ static __always_inline void pv_kick(int cpu)
 static __always_inline bool pv_vcpu_is_preempted(long cpu)
 {
 	return PVOP_ALT_CALLEE1(bool, lock.vcpu_is_preempted, cpu,
-				"xor %%" _ASM_AX ", %%" _ASM_AX ";",
+				"xor %%" _ASM_AX ", %%" _ASM_AX,
 				ALT_NOT(X86_FEATURE_VCPUPREEMPT));
 }
 
@@ -657,18 +657,18 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 #ifdef CONFIG_PARAVIRT_XXL
 static __always_inline unsigned long arch_local_save_flags(void)
 {
-	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax;",
+	return PVOP_ALT_CALLEE0(unsigned long, irq.save_fl, "pushf; pop %%rax",
 				ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_disable(void)
 {
-	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli;", ALT_NOT_XEN);
+	PVOP_ALT_VCALLEE0(irq.irq_disable, "cli", ALT_NOT_XEN);
 }
 
 static __always_inline void arch_local_irq_enable(void)
 {
-	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti;", ALT_NOT_XEN);
+	PVOP_ALT_VCALLEE0(irq.irq_enable, "sti", ALT_NOT_XEN);
 }
 
 static __always_inline unsigned long arch_local_irq_save(void)
@@ -713,9 +713,9 @@ void native_pv_lock_init(void) __init;
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
index 3502939415ad..e82dba084198 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -250,7 +250,7 @@ extern struct paravirt_patch_template pv_ops;
  */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE "\n\t"			\
-	"call *%[paravirt_opptr];"
+	"call *%[paravirt_opptr]"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
-- 
2.52.0

