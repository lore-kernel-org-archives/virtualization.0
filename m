Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854397;
	b=031y/zJanhj8lx4KIgbic/hcEqVUeeapfkR/PgZ6/eyFFoKrmsIqzIEIqvfb0+kKaB5s
	 KXhTVpv2eIft7ghpA9GcGnrQn+idfuIXIpRbjIhZOESG8fpCBxewmaFtK8U0z2gwCUx3D
	 slOStI5rnImyniFWNvjwJPXw/g2yF3j5jp8GmCSqKtoeqgd6QGkGQ5c6ApoBafCTC8YGr
	 64GKL8imBEK9qoB8X6KkaSP0iwRVAf8vfoyy7tdC+mSlk8tK5EPff4wg8G4bN5hHOsjoK
	 vfwcnEIMMqx1H0R0BJUePOYc3y1Rc9tN2rMuLwZ919ija3kn3tqRxcywjp+s7qo7fug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854397;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Spamd-Result:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=YrZlqpeiECcrbafJiZi9IW20LouiSCc507NrmbFWSoU=;
	b=ah/CkBiut+cC7eqBkF0VUa4f4ArPYnIntVSIBiIGMyzwFWGwEUJBx/mEEa16eEw+SX/Q
	 jpVuSHKn7sko19yDi+64cggBE3ngZG98m6iyPTzQX9KOe6RIPC66qaIENwycdRSoVIz2H
	 cijH2zY3x2Rk87UQM+RVmu6GxxqNiVuxkjRl0BIW1E2CPIRjmQuYwynnkCpsN94hVQ6R0
	 YEc3xvtS6UKuvYllNOWkgSGj6JKSPwCrxM27W4c/m88cEehW77lOo+kcIK7YkDmn7YpB0
	 gthVLTIk5l4v70VR8aWxcG2rZObexuk5mjz+IZ5GDpkoZGkJyBSOOpkXmS7h32uWASg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=XHW4Xlza;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=XHW4Xlza;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93B606A32A;
	Mon, 16 Nov 2026 18:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A93B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=XHW4Xlza;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=XHW4Xlza
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3A7E21F8AE;
	Mon, 16 Nov 2026 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrZlqpeiECcrbafJiZi9IW20LouiSCc507NrmbFWSoU=;
	b=XHW4XlzaTzitwv6a5EU3TDD4r5sQrffRQUgbdHGlYxWEpUg7QlBGtTLyVb8pPXF+DgCZqw
	0OFI/rx42/S2G/9NvafZ+a7o8nU3IBN7IUIToavALJ/OYWCepzbdQDnK2R8dPJvosJypJd
	uqALe73sjqyiAi5OwkNXMdg1Bu76Eqs=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XHW4Xlza
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrZlqpeiECcrbafJiZi9IW20LouiSCc507NrmbFWSoU=;
	b=XHW4XlzaTzitwv6a5EU3TDD4r5sQrffRQUgbdHGlYxWEpUg7QlBGtTLyVb8pPXF+DgCZqw
	0OFI/rx42/S2G/9NvafZ+a7o8nU3IBN7IUIToavALJ/OYWCepzbdQDnK2R8dPJvosJypJd
	uqALe73sjqyiAi5OwkNXMdg1Bu76Eqs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92D651334C;
	Mon, 16 Nov 2026 18:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QiIJGvpN+2pweAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 18:39:54 +0000
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
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH v6 08/17] x86/msr: Make wrmsrns() a first class citizen
Date: Mon, 16 Nov 2026 19:38:56 +0100
Message-ID: <20261116183905.1591611-9-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116183905.1591611-1-jgross@suse.com>
References: <20261116183905.1591611-1-jgross@suse.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim,zytor.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:email,suse.com:email,suse.com:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 3A7E21F8AE

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
V6:
- add instruction delimiter in macro (Shreshth Srivastava)
---
 arch/x86/include/asm/fred.h     |   2 +-
 arch/x86/include/asm/msr.h      | 158 ++++++++++++++++++++++++++++----
 arch/x86/include/asm/paravirt.h |  10 ++
 3 files changed, 152 insertions(+), 18 deletions(-)

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
index be23d30ad0b0..99d4e07165e9 100644
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
+	" .byte 0xc4,0xe7,0x7a,0xf6,0xc0; .long %c[msr]\n\t"
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
 
@@ -149,7 +261,6 @@ static inline u64 native_read_pmc(int counter)
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
-#include <linux/errno.h>
 static __always_inline u64 read_msr(u32 msr)
 {
 	return native_read_msr(msr);
@@ -170,6 +281,16 @@ static __always_inline int write_msr_safe(u32 msr, u64 val)
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
 static __always_inline u64 do_rdpmc(int counter)
 {
 	return native_read_pmc(counter);
@@ -222,6 +343,24 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 	return err;
 }
 
+static __always_inline void wrmsrns(u32 msr, u64 val)
+{
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
+}
+
 static __always_inline u64 rdpmc(int counter)
 {
 	u64 val;
@@ -233,21 +372,6 @@ static __always_inline u64 rdpmc(int counter)
 	return val;
 }
 
-/* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
-#define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
-
-/* Non-serializing WRMSR, when available.  Falls back to a serializing WRMSR. */
-static __always_inline void wrmsrns(u32 msr, u64 val)
-{
-	/*
-	 * WRMSR is 2 bytes.  WRMSRNS is 3 bytes.  Pad WRMSR with a redundant
-	 * DS prefix to avoid a trailing NOP.
-	 */
-	asm volatile("1: " ALTERNATIVE("ds wrmsr", ASM_WRMSRNS, X86_FEATURE_WRMSRNS)
-		     "2: " _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_WRMSR)
-		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)));
-}
-
 struct msr __percpu *msrs_alloc(void);
 void msrs_free(struct msr __percpu *msrs);
 int msr_set_bit(u32 msr, u8 bit);
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 615f0c42a881..c79522588842 100644
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
2.56.0

