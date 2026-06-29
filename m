Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA53BE628
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 06:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716204; cv=none; b=ktbxKhttBzd0Nah2CpJhS7HDWYWZU32/ohc+nEPrWgdUp2n+A5QajR79B8nz2y94oTZaaQTMDzj96DdAKWe3ux43zKrn48y/6Hjoegn+NftAylGK0fxvQiaFEvXVPkVuuhcVOtSnatTptcGwAujtxShVEeq2Vnu/5jj06NVd2aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716204; c=relaxed/simple;
	bh=VUsjghlI2PYdlS+o6TpxTHb+d2YBI1opjh8FxNWDX/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAnIMUYDQ5boDXmFMyi5sPR/yutWUXRdDuxeNTGEFHtWiOfEENyALGaQGjIbiPJ0XavrVaeJ7TRjN5IwqxsbAF1CDGGG7PAx0PHVJF8r0GOvrf2/h9I5qSQ5CcTMBN1xwvzfvLM2CpryFxf/1PVzfTwDpsJqL5uBAvv7yeBRs8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BVxyvCRX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BVxyvCRX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BVxyvCRX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BVxyvCRX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C69875D29;
	Mon, 29 Jun 2026 06:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYUUbCv4W++LsKYf3CE5u9alLMrEYfr9izNLmQIXn4E=;
	b=BVxyvCRXOPqiPPfn0aubeK4nDk7N5YrntOoT/XZTPoiIsENUTHqxKWZWuMB7u51YC2C4aF
	nBqfo7ufs0vBSS4u1E78gqG8hPmtmS1YvZnkf5lHXnaSXbvLzNtLzQfvrsfX1txdPTmXiC
	M0M8q1K62mejlkSetOzcbcUjdfFpiQY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782716199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYUUbCv4W++LsKYf3CE5u9alLMrEYfr9izNLmQIXn4E=;
	b=BVxyvCRXOPqiPPfn0aubeK4nDk7N5YrntOoT/XZTPoiIsENUTHqxKWZWuMB7u51YC2C4aF
	nBqfo7ufs0vBSS4u1E78gqG8hPmtmS1YvZnkf5lHXnaSXbvLzNtLzQfvrsfX1txdPTmXiC
	M0M8q1K62mejlkSetOzcbcUjdfFpiQY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DFA9779A8;
	Mon, 29 Jun 2026 06:56:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PgY4HSYXQmreQQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:56:38 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev,
	llvm@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Xin Li <xin@zytor.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH v4 09/18] x86/msr: Make wrmsrns() a first class citizen
Date: Mon, 29 Jun 2026 08:55:35 +0200
Message-ID: <20260629065544.3643253-10-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629065544.3643253-1-jgross@suse.com>
References: <20260629065544.3643253-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TAGGED_RCPT(0.00)[lkml];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:email,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_CC(0.00)[suse.com,zytor.com,kernel.org,redhat.com,alien8.de,linux.intel.com,broadcom.com,gmail.com,google.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -5.30

Today wrmsrns() is - apart from the potential use of the wrmsrns
instruction - equivalent to __wrmsrq(). Change that by supporting
MSR write trace entries and a safe variant.

wrmsrns() and wrmsrns_safe() will be the "normal" interfaces like
wrmsrq() and wrmsrq_safe(). They will call write_msrns[_safe]() and
conditionally create trace entries via do_trace_write_msr().

write_msrns[_safe]() are different between paravirt and non-paravirt
cases. For the paravirt case they will (for now) only use the wrmsr
paravirt functions, while for non-paravirt they call native_wrmsrns()
and native_wrmsrns_safe().

native_wrmsrns() is like wrmsrns() today, native_wrmsrns_safe() is just
the safe variant of it. The both rely on __wrmsrns(), which will use
the ALTERNATIVE*() macros for selecting WRMSR or WRMSRNS (with or
without an immediate operand specifying the MSR register) depending on
availability.

Switch the wrmsrns() call in fred_update_rsp0() to native_wrmsrns() in
order to avoid a change of functionality. The wrmsrns() call in
vmx_write_guest_host_msr() can be kept, as it has replaced a wrmsrq()
call, so eventually creating a trace entry is obviously fine here.

Originally-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- new patch, partially taken from "[RFC PATCH v2 21/34] x86/msr: Utilize
  the alternatives mechanism to write MSR" by Xin Li.
V4:
- don't modify __wrmsrq(), but create __wrmsrns().
---
 arch/x86/include/asm/fred.h     |   2 +-
 arch/x86/include/asm/msr.h      | 150 +++++++++++++++++++++++++++++---
 arch/x86/include/asm/paravirt.h |  10 +++
 3 files changed, 148 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 18a2f811c358..0a6773b76968 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -101,7 +101,7 @@ static __always_inline void fred_update_rsp0(void)
 	unsigned long rsp0 = (unsigned long) task_stack_page(current) + THREAD_SIZE;
 
 	if (cpu_feature_enabled(X86_FEATURE_FRED) && (__this_cpu_read(fred_rsp0) != rsp0)) {
-		wrmsrns(MSR_IA32_FRED_RSP0, rsp0);
+		native_wrmsrns(MSR_IA32_FRED_RSP0, rsp0);
 		__this_cpu_write(fred_rsp0, rsp0);
 	}
 }
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 266298b3d201..91d6f481732b 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -7,11 +7,11 @@
 #ifndef __ASSEMBLER__
 
 #include <asm/asm.h>
-#include <asm/errno.h>
 #include <asm/cpumask.h>
 #include <uapi/asm/msr.h>
 #include <asm/shared/msr.h>
 
+#include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/percpu.h>
 
@@ -56,6 +56,36 @@ static inline void do_trace_read_msr(u32 msr, u64 val, int failed) {}
 static inline void do_trace_rdpmc(u32 msr, u64 val, int failed) {}
 #endif
 
+/* The GNU Assembler (Gas) with Binutils 2.40 adds WRMSRNS support */
+#if defined(CONFIG_AS_IS_GNU) && CONFIG_AS_VERSION >= 24000
+#define ASM_WRMSRNS		"wrmsrns\n\t"
+#else
+#define ASM_WRMSRNS		_ASM_BYTES(0x0f,0x01,0xc6)
+#endif
+
+/* The GNU Assembler (Gas) with Binutils 2.41 adds the .insn directive support */
+#if defined(CONFIG_AS_IS_GNU) && CONFIG_AS_VERSION >= 24100
+#define ASM_WRMSRNS_IMM				\
+	" .insn VEX.128.F3.M7.W0 0xf6 /0, %[val], %[msr]%{:u32}\n\t"
+#else
+/*
+ * Note, clang also doesn't support the .insn directive.
+ *
+ * The register operand is encoded as %rax because all uses of the immediate
+ * form MSR access instructions reference %rax as the register operand.
+ */
+#define ASM_WRMSRNS_IMM				\
+	" .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]"
+#endif
+
+#define PREPARE_RDX_FOR_WRMSR			\
+	"mov %%rax, %%rdx\n\t"			\
+	"shr $0x20, %%rdx\n\t"
+
+#define PREPARE_RCX_RDX_FOR_WRMSR		\
+	"mov %[msr], %%ecx\n\t"			\
+	PREPARE_RDX_FOR_WRMSR
+
 /*
  * __rdmsr() and __wrmsr() are the two primitives which are the bare minimum MSR
  * accessors and should not have any tracing or other functionality piggybacking
@@ -83,6 +113,78 @@ static __always_inline void __wrmsrq(u32 msr, u64 val)
 		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)) : "memory");
 }
 
+static __always_inline bool __wrmsrns_variable(u32 msr, u64 val, int type)
+{
+#ifdef CONFIG_X86_64
+	BUILD_BUG_ON(__builtin_constant_p(msr));
+#endif
+
+	/*
+	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
+	 * DS prefix to avoid a trailing NOP.
+	 */
+	asm_inline volatile goto(
+		"1:\n"
+		ALTERNATIVE("ds wrmsr",
+			    ASM_WRMSRNS,
+			    X86_FEATURE_WRMSRNS)
+		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])
+
+		:
+		: "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)), [type] "i" (type)
+		: "memory"
+		: badmsr);
+
+	return false;
+
+badmsr:
+	return true;
+}
+
+#ifdef CONFIG_X86_64
+/*
+ * Non-serializing WRMSR or its immediate form, when available.
+ *
+ * Otherwise, it falls back to a serializing WRMSR.
+ */
+static __always_inline bool __wrmsrns_constant(u32 msr, u64 val, int type)
+{
+	BUILD_BUG_ON(!__builtin_constant_p(msr));
+
+	asm_inline volatile goto(
+		"1:\n"
+		ALTERNATIVE_2(PREPARE_RCX_RDX_FOR_WRMSR
+			      "2: ds wrmsr",
+			      PREPARE_RCX_RDX_FOR_WRMSR
+			      ASM_WRMSRNS,
+			      X86_FEATURE_WRMSRNS,
+			      ASM_WRMSRNS_IMM,
+			      X86_FEATURE_MSR_IMM)
+		_ASM_EXTABLE_TYPE(1b, %l[badmsr], %c[type])	/* For WRMSRNS immediate */
+		_ASM_EXTABLE_TYPE(2b, %l[badmsr], %c[type])	/* For WRMSR(NS) */
+
+		:
+		: [val] "a" (val), [msr] "i" (msr), [type] "i" (type)
+		: "memory", "ecx", "rdx"
+		: badmsr);
+
+	return false;
+
+badmsr:
+	return true;
+}
+#endif
+
+static __always_inline bool __wrmsrns(u32 msr, u64 val, int type)
+{
+#ifdef CONFIG_X86_64
+	if (__builtin_constant_p(msr))
+		return __wrmsrns_constant(msr, val, type);
+#endif
+
+	return __wrmsrns_variable(msr, val, type);
+}
+
 static __always_inline u64 native_rdmsrq(u32 msr)
 {
 	return __rdmsr(msr);
@@ -134,6 +236,16 @@ static inline int notrace native_write_msr_safe(u32 msr, u64 val)
 	return err;
 }
 
+static __always_inline void native_wrmsrns(u32 msr, u64 val)
+{
+	 __wrmsrns(msr, val, EX_TYPE_WRMSR);
+}
+
+static __always_inline int native_wrmsrns_safe(u32 msr, u64 val)
+{
+	return __wrmsrns(msr, val, EX_TYPE_WRMSR_SAFE) ? -EIO : 0;
+}
+
 extern int rdmsr_safe_regs(u32 regs[8]);
 extern int wrmsr_safe_regs(u32 regs[8]);
 
@@ -150,7 +262,6 @@ static inline u64 native_read_pmc(int counter)
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
-#include <linux/errno.h>
 static __always_inline u64 read_msr(u32 msr)
 {
 	return native_read_msr(msr);
@@ -171,6 +282,16 @@ static __always_inline int write_msr_safe(u32 msr, u64 val)
 	return native_write_msr_safe(msr, val);
 }
 
+static __always_inline void write_msrns(u32 msr, u64 val)
+{
+	native_wrmsrns(msr, val);
+}
+
+static __always_inline int write_msrns_safe(u32 msr, u64 val)
+{
+	return native_wrmsrns_safe(msr, val);
+}
+
 static __always_inline u64 rdpmc(int counter)
 {
 	return native_read_pmc(counter);
@@ -223,19 +344,22 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 	return err;
 }
 
-/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
-#define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
-
-/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR. */
 static __always_inline void wrmsrns(u32 msr, u64 val)
 {
-	/*
-	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
-	 * DS prefix to avoid a trailing NOP.
-	 */
-	asm volatile("1: " ALTERNATIVE("ds wrmsr", ASM_WRMSRNS, X86_FEATURE_WRMSRNS)
-		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
-		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)));
+	write_msrns(msr, val);
+
+	if (tracepoint_enabled(write_msr))
+		do_trace_write_msr(msr, val, 0);
+}
+
+static __always_inline int wrmsrns_safe(u32 msr, u64 val)
+{
+	int err = write_msrns_safe(msr, val);
+
+	if (tracepoint_enabled(write_msr))
+		do_trace_write_msr(msr, val, err);
+
+	return err;
 }
 
 struct msr __percpu *msrs_alloc(void);
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index a5a1fc4c88d1..b0c740316cf7 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -160,11 +160,21 @@ static inline void write_msr(u32 msr, u64 val)
 	paravirt_write_msr(msr, val);
 }
 
+static __always_inline void write_msrns(u32 msr, u64 val)
+{
+	paravirt_write_msr(msr, val);
+}
+
 static inline int write_msr_safe(u32 msr, u64 val)
 {
 	return paravirt_write_msr_safe(msr, val);
 }
 
+static __always_inline int write_msrns_safe(u32 msr, u64 val)
+{
+	return paravirt_write_msr_safe(msr, val);
+}
+
 static __always_inline int read_msr_safe(u32 msr, u64 *p)
 {
 	return paravirt_read_msr_safe(msr, p);
-- 
2.54.0

