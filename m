Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF3200C2
	for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 19:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763666246; cv=none; b=tP+8IXiqhGlm40UFLDA1GFrveKOGvgcwOP+WFq9Jb5Aga2QpF3SzuZmV21/BYSFdE187h/cfoVnSIzMn0ul5QVtXhJC8rC7RWnIXp6/Cao/YEk2lFR4kzAg7IvkT9a4fQFrAc8UB66yMDBcGPRFvcNnfSJXFbSHgqG1ygvdqNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763666246; c=relaxed/simple;
	bh=q3Kw3XV8cBkwLRWp8yVPvV6ZXUA19bUX68B0j5RmOZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fuoOgy65GEWFPftFg7lRotCmvasWbfltTV6AJvsDEJ429V86ZAkSVtvdAA+okZdw1FPctsc7hfTt92vUmPMBHCxQz9IA94FqAddPI8oOnX/uiCch8O1ut9qoE5QVZsn+bvsQ+LVuBONOwZzUeIMZk9flxclwZeVyolLfJdacaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Frg89oAu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Frg89oAu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso7963505e9.1
        for <virtualization@lists.linux.dev>; Thu, 20 Nov 2025 11:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763666243; x=1764271043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XRko4q1orSub0e4VtMMAI1/u1lvbIzCyrJxF0XZvcNc=;
        b=Frg89oAuUwS5LD+bg04dvKrVqTFAA2HEx6ugxBM0JuJbsZCALa22yBTAOhiMNni9zo
         F1EaNbyfqVTr+5x8XYAmmwW2fE8LSaJy8L9keAzXti42C8Ma9i+ET/Y3t7UfWCfLVUh5
         llI+THWYVYGrymOi1148nbgnihjjaCMt9mqJxXt6ZknyPMWtVYyWzOwR1pUjuPWUTYdM
         EyMjtCmczop0b5oYBHZXgyvw58uIH8EimQgf7ugWC6UurJyxuU7KYBt6QHErF6vYRI3e
         knjbH9ItZBCYL1Iu6mzhOkTzWwIqd5ctT9/oSAQb+6H7rQeZrOaoyKqN9KSUeTl6S2ZI
         22AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763666243; x=1764271043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRko4q1orSub0e4VtMMAI1/u1lvbIzCyrJxF0XZvcNc=;
        b=pEmnaSTolVWZdFsgy1VEn/IYjWcvfgIXSJx/nG8tniNzG73jjD/jVeYjsjl8lCmPQy
         AFwq0ADu8cfISsghCNqgTv/hkk/Jqu4Ydg94uJ3jvZoHCXmj+8qsGBzCX0ISUtnSMJut
         lSZE8G642B2XE/hnq0PLjlvEE9d3xX29Ao+ri0v1GS/dRUhv4X26BWLs5QGeXg5UUPiL
         q8hSZgK0HAvBZcVeVRYSZarx/f0/POG/op9EF8RWbnrS2wprdnRml9r6kL49jxZ7m3eH
         44Oq36jNMTGbnet48FWGgAf9YVjdzeTQD5X/j284uq6u0/r/Lj1ZtXofHWcLGBV2iGlp
         /NjA==
X-Forwarded-Encrypted: i=1; AJvYcCU2zN8ETPJ6Ppcoy8QXVPfrvbXAJBtBTeMA1HYBTArtisvRQT4KD2sMiEsa23oFXynszUJCiaX6pivVHi1vHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxTfjqsJCSjsuVsidQci4iunw+nW7alSaLlxeOuuFqN0Hdexjcu
	/gqwGSrFSQcxfTSWJJsn28FgFAXJPSngbVpFWaoDyzho7CwO1PRQJFRN
X-Gm-Gg: ASbGncu84U/4G2dkNJSnev2pwCf44nL8G0c8bfNfNHpRh+DvVFmDEZSZCB7ucTGobEH
	PfL7iWa2VJt2aUIPtJqJ2bOdi6QPXsR7Kalh1T4Ra8sLFWI4HWspUNOcCgIzCxoU5YQsVcg5IH8
	0EJbZIj8R09sU8NLfgTpWunu2kRLywJvlPNtpHrPyAYmM/UeGuBpyKoXcqBGtvg0ZVQdM9AtNal
	yEtCypHc62wrqls/7wfIWk+pWgw4TnT+Yp6Qq/R6xhsUzMqYGSGm0UaszBU7Mq8TPfhePQGZjYf
	5ER4jXxIc8aptZOdlzH2wC5kcScXtyh8wWTwzlbmbgqZ7FHzi5m1b+e3KTZL5qqdkEYfe+HAumJ
	MMCA6f9VKdDyMX5VhLggo87EsAsU+L78hJquiSqWHP2Xm+zxmKkShUFzBD+1xSnMpMga+4DICl4
	Xgy/6OsIn0rR0=
X-Google-Smtp-Source: AGHT+IG2YemRSlSQD+gY5a/LIUJZNjE3QmOQv7qcGRO13SB/nU8fHO1qR+z2O/sEYw6FiUmqgd5aAA==
X-Received: by 2002:a05:600c:1c14:b0:477:8b2e:aa7d with SMTP id 5b1f17b1804b1-477b8aa0ed3mr60928205e9.30.1763666242535;
        Thu, 20 Nov 2025 11:17:22 -0800 (PST)
Received: from fedora ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f363b0sm7117884f8f.13.2025.11.20.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 11:17:21 -0800 (PST)
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
Subject: [PATCH 1/2] x86/paravirt: Remove trailing semicolons from alternative asm templates
Date: Thu, 20 Nov 2025 20:15:56 +0100
Message-ID: <20251120191716.124642-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.51.1
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
Cc: Juergen Gross <jgross@suse.com>
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
index 37a8627d8277..c957e56af3a1 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -250,7 +250,7 @@ extern struct paravirt_patch_template pv_ops;
  */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%[paravirt_opptr];"
+	"call *%[paravirt_opptr]"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
-- 
2.51.1

