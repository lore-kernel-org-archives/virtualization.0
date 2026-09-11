Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7D46AEFA;
	Fri, 11 Sep 2026 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116238; cv=none; b=b/MyXzLKseEtNS6ry5kAUY6VJ6IA/yeInoUjvCQbZisTutZ33ctWq/YyS5KfMmC8VI+4sM9462ItecUfw8W+sG0GYFJb9D2l3nIYYpXFZw8xajjS9FMAITwk4AJ8hRIlJPc3o368+2LB81F9GTd3uua/QK9lVAqqSrqnWqh7kao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116238; c=relaxed/simple;
	bh=L6fq3kEpZkuKNSo3+GyojL3TtC2CnH5F7ppRdn5Fiqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETKtX+3fR2ji79lEKr1hSwPFj3fVfyPPwu1/KGya5ah9mWC36D39RBQwLnv+/w7zcNGfhcUbtLjM7PruLeVPRg+pjcBvCShzzibhOCtmhYaRse6QlhVjIa6NRxR8GrPogMB71enSIfTZczsknOpOYxAJ9Dg7SWLiwdT70pNcfo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PKqwMjD/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S9Qzwqfm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PKqwMjD/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S9Qzwqfm"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D7EEE1FBF2;
	Fri, 11 Sep 2026 08:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789116231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JrcJxbU/QzmQq8hvI++pMPjS7c5vgws1ybK5mlsL1M=;
	b=PKqwMjD/T9axlHPoYNslOaCHbp0XQY4zJxLuiwHiZPlQ1EYARgKzbpth6U7KuDDCfKOluQ
	g96omM5S8IgN4TPp2Fk31UhVYrLNcH6Ln5kTo76z5uiCj52+aTOK/JNAcbocjRnIJcYHi3
	cAhccXZbsONy0kdc/LTWkf38h9VMRp4=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789116226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/JrcJxbU/QzmQq8hvI++pMPjS7c5vgws1ybK5mlsL1M=;
	b=S9Qzwqfm7LWrnxW5Fx/HzSQp5NKo3snXmlj+Asde5n7c0IPVpowE1PqF2FHzFkzpr57GM6
	Q7haBwBw/shmE5gMsJfDZ222XmH26bOhHh3Y8oq9qNn9BmLMdT+hV2WSicatIBKsOaTSZu
	TxcYi8ZfBM2tlNQuxTWS8Oxk9CrYmgE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4863813715;
	Fri, 11 Sep 2026 08:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Dc6EEK/o2rXFgAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 11 Sep 2026 08:43:46 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	llvm@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH v5 16/17] x86/paravirt: Use alternatives for MSR access with paravirt
Date: Fri, 11 Sep 2026 10:42:10 +0200
Message-ID: <20260911084211.3149957-17-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911084211.3149957-1-jgross@suse.com>
References: <20260911084211.3149957-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -6.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]

When not running as Xen PV guest, patch in the optimal MSR instructions
via alternative and use direct calls otherwise.

This will especially have positive effects for performance when not
running as a Xen PV guest with paravirtualization enabled, as there
will be no call overhead for MSR access functions any longer.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
V4:
- fix build error with clang (kernel test robot)
---
 arch/x86/include/asm/paravirt-msr.h   | 136 ++++++++++++++++++++------
 arch/x86/include/asm/paravirt_types.h |   1 +
 2 files changed, 109 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/paravirt-msr.h b/arch/x86/include/asm/paravirt-msr.h
index 4b71a1cd780c..ba3ee64446db 100644
--- a/arch/x86/include/asm/paravirt-msr.h
+++ b/arch/x86/include/asm/paravirt-msr.h
@@ -27,67 +27,147 @@ extern struct pv_msr_ops pv_ops_msr;
 #define PV_CALLEE_SAVE_REGS_MSR_THUNK(func)		\
 	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text", MSR)
 
+#define ASM_CLRERR	"xor %[err],%[err]\n"
+
+#define PV_RDMSR_VAR(__msr, __val, __type, __func, __err)		\
+	asm volatile(							\
+		"1:\n"							\
+		ALTERNATIVE_2(PARAVIRT_CALL,				\
+			RDMSR_AND_SAVE_RESULT ASM_CLRERR, X86_FEATURE_ALWAYS, \
+			ALT_CALL_INSTR, ALT_XEN_CALL)			\
+		"2:\n"							\
+		_ASM_EXTABLE_TYPE_REG(1b, 2b, __type, %[err])		\
+		: [err] "=d" (__err), [val] "=a" (__val),		\
+		  ASM_CALL_CONSTRAINT					\
+		: paravirt_ptr(pv_ops_msr, __func), "c" (__msr)		\
+		: "cc")
+
+#define PV_RDMSR_CONST(__msr, __val, __type, __func, __err)		\
+	asm volatile(							\
+		"1:\n"							\
+		ALTERNATIVE_3(PARAVIRT_CALL,				\
+			RDMSR_AND_SAVE_RESULT ASM_CLRERR, X86_FEATURE_ALWAYS, \
+			ASM_RDMSR_IMM ASM_CLRERR, X86_FEATURE_MSR_IMM,	\
+			ALT_CALL_INSTR, ALT_XEN_CALL)			\
+		"2:\n"							\
+		_ASM_EXTABLE_TYPE_REG(1b, 2b, __type, %[err])		\
+		: [err] "=d" (__err), [val] "=a" (__val),		\
+		  ASM_CALL_CONSTRAINT					\
+		: paravirt_ptr(pv_ops_msr, __func),			\
+		  "c" (__msr), [msr] "i" (__msr)			\
+		: "cc")
+
+#define PV_WRMSR(__msr, __val, __type, __func, __err)			\
+({									\
+	unsigned long rdx = rdx;					\
+	asm volatile(							\
+		"1:\n"							\
+		ALTERNATIVE_2(PARAVIRT_CALL,				\
+			"wrmsr;" ASM_CLRERR, X86_FEATURE_ALWAYS,	\
+			ALT_CALL_INSTR, ALT_XEN_CALL)			\
+		"2:\n"							\
+		_ASM_EXTABLE_TYPE_REG(1b, 2b, __type, %[err])		\
+		: [err] "=a" (__err), "=d" (rdx), ASM_CALL_CONSTRAINT	\
+		: paravirt_ptr(pv_ops_msr, __func),			\
+		  "0" (__val), "1" ((__val) >> 32), "c" (__msr)		\
+		: "memory", "cc");					\
+})
+
+#define PV_WRMSRNS_VAR(__msr, __val, __type, __func, __err)		\
+({									\
+	unsigned long rdx = rdx;					\
+	asm volatile(							\
+		"1:\n"							\
+		ALTERNATIVE_3(PARAVIRT_CALL,				\
+			"wrmsr;" ASM_CLRERR, X86_FEATURE_ALWAYS,	\
+			ASM_WRMSRNS ASM_CLRERR, X86_FEATURE_WRMSRNS,	\
+			ALT_CALL_INSTR, ALT_XEN_CALL)			\
+		"2:\n"							\
+		_ASM_EXTABLE_TYPE_REG(1b, 2b, __type, %[err])		\
+		: [err] "=a" (__err), "=d" (rdx), ASM_CALL_CONSTRAINT	\
+		: paravirt_ptr(pv_ops_msr, __func),			\
+		  "0" (__val), "1" ((__val) >> 32), "c" (__msr)		\
+		: "memory", "cc");					\
+})
+
+#define PV_WRMSRNS_CONST(__msr, __val, __type, __func, __err)		\
+({									\
+	unsigned long rdx = rdx;					\
+	asm volatile(							\
+		"1:\n"							\
+		ALTERNATIVE_4(PARAVIRT_CALL,				\
+			"wrmsr;" ASM_CLRERR, X86_FEATURE_ALWAYS,	\
+			ASM_WRMSRNS ASM_CLRERR, X86_FEATURE_WRMSRNS,	\
+			ASM_WRMSRNS_IMM ASM_CLRERR, X86_FEATURE_MSR_IMM,\
+			ALT_CALL_INSTR, ALT_XEN_CALL)			\
+		"2:\n"							\
+		_ASM_EXTABLE_TYPE_REG(1b, 2b, __type, %[err])		\
+		: [err] "=a" (__err), "=d" (rdx), ASM_CALL_CONSTRAINT	\
+		: paravirt_ptr(pv_ops_msr, __func),			\
+		  [val] "0" (__val), "1" ((__val) >> 32),		\
+		  "c" (__msr), [msr] "i" (__msr)			\
+		: "memory", "cc");					\
+})
+
 static __always_inline u64 read_msr(u32 msr)
 {
 	u64 val;
+	u64 err;
 
-	asm volatile(PARAVIRT_CALL
-		     : "=a" (val), ASM_CALL_CONSTRAINT
-		     : paravirt_ptr(pv_ops_msr, read_msr), "c" (msr)
-		     : "rdx");
+	if (__builtin_constant_p(msr))
+		PV_RDMSR_CONST(msr, val, EX_TYPE_RDMSR, read_msr, err);
+	else
+		PV_RDMSR_VAR(msr, val, EX_TYPE_RDMSR, read_msr, err);
 
 	return val;
 }
 
 static __always_inline void write_msr(u32 msr, u64 val)
 {
-	asm volatile(PARAVIRT_CALL
-		     : ASM_CALL_CONSTRAINT
-		     : paravirt_ptr(pv_ops_msr, write_msr), "c" (msr), "a" (val)
-		     : "memory", "rdx");
+	u64 err;
+
+	PV_WRMSR(msr, val, EX_TYPE_WRMSR, write_msr, err);
 }
 
 static __always_inline void write_msrns(u32 msr, u64 val)
 {
-	asm volatile(PARAVIRT_CALL
-		     : ASM_CALL_CONSTRAINT
-		     : paravirt_ptr(pv_ops_msr, write_msr), "c" (msr), "a" (val)
-		     : "memory", "rdx");
+	u64 err;
+
+	if (__builtin_constant_p(msr))
+		PV_WRMSRNS_CONST(msr, val, EX_TYPE_WRMSR, write_msr, err);
+	else
+		PV_WRMSRNS_VAR(msr, val, EX_TYPE_WRMSR, write_msr, err);
 }
 
 static __always_inline int read_msr_safe(u32 msr, u64 *val)
 {
-	int err;
+	u64 err;
 
-	asm volatile(PARAVIRT_CALL
-		     : [err] "=d" (err), "=a" (*val), ASM_CALL_CONSTRAINT
-		     : paravirt_ptr(pv_ops_msr, read_msr_safe), "c" (msr));
+	if (__builtin_constant_p(msr))
+		PV_RDMSR_CONST(msr, *val, EX_TYPE_RDMSR_SAFE, read_msr_safe, err);
+	else
+		PV_RDMSR_VAR(msr, *val, EX_TYPE_RDMSR_SAFE, read_msr_safe, err);
 
 	return err ? -EIO : 0;
 }
 
 static __always_inline int write_msr_safe(u32 msr, u64 val)
 {
-	int err;
+	u64 err;
 
-	asm volatile(PARAVIRT_CALL
-		     : [err] "=a" (err), ASM_CALL_CONSTRAINT
-		     : paravirt_ptr(pv_ops_msr, write_msr_safe),
-			"c" (msr), "a" (val)
-		     : "memory", "rdx");
+	PV_WRMSR(msr, val, EX_TYPE_WRMSR_SAFE, write_msr_safe, err);
 
 	return err ? -EIO : 0;
 }
 
 static __always_inline int write_msrns_safe(u32 msr, u64 val)
 {
-	int err;
+	u64 err;
 
-	asm volatile(PARAVIRT_CALL
-		     : [err] "=a" (err), ASM_CALL_CONSTRAINT
-		     : paravirt_ptr(pv_ops_msr, write_msr_safe),
-			"c" (msr), "a" (val)
-		     : "memory", "rdx");
+	if (__builtin_constant_p(msr))
+		PV_WRMSRNS_CONST(msr, val, EX_TYPE_WRMSR_SAFE, write_msr_safe, err);
+	else
+		PV_WRMSRNS_VAR(msr, val, EX_TYPE_WRMSR_SAFE, write_msr_safe, err);
 
 	return err ? -EIO : 0;
 }
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 740ea819bbab..54f7c3d8fadf 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -442,6 +442,7 @@ extern struct paravirt_patch_template pv_ops;
 #endif	/* __ASSEMBLER__ */
 
 #define ALT_NOT_XEN	ALT_NOT(X86_FEATURE_XENPV)
+#define ALT_XEN_CALL	ALT_DIRECT_CALL(X86_FEATURE_XENPV)
 
 #ifdef CONFIG_X86_32
 /* save and restore all caller-save registers, except return value */
-- 
2.55.0

