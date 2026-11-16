Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854444;
	b=JIDPYUsvJCZig41y0hXvscDGFYxmBlAnKKehOVqCmE3bb52oyEDcxcp3p5P/X4sCAUsE
	 Q4OLxYKTwlCkL2I/ueDIAzJcgcKDxM2/msl++T554De4NS0MhUUVubKNk63R7Cw0F/oR7
	 QcN8ub2imx80bkCtiBqExBuipzrR/zSuwfchxmIy8KrZkX31FjVevuFY6zvt+Z+bIgkuV
	 jAQ+V3u7kVswRArVZ/B73/7Trc9TEFqsbTKMqnDJfJxigFcVq7LlaOhwGBKNGlmswVNce
	 Y4sF66HzK9uhoGUhBMq+uNFfPuAVfeayI9659/zqI4je50MAiR4OHKJy0O4MFVXTtqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854444;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=bW+N6M5VBiGaPpTGAq3tyvEmQIBYUtGPyL5eNMej44k=;
	b=xUdoQesLMBOaVM9LSLTN3pbWUs8GYUE8PPkrQQUJeqG/MCOmK/zD09OV/xHMSc4EkgPs
	 ZH6FUQuFoRtsKinvHwWhnitcJX1zeD1BXq+E1CT3cfpAC75kxoooZ9K2HSOmXyYCzl33N
	 vr6z2s6DcjU+ZjV8UOVG4STjnxvRfDqeNvNkmlbpzO4nlgBGiFU7upjJwqn2RChtzwfX1
	 /iu9p9vUitb/MJY8Mqy/9p8ldePAkqE70TZXS/JgPnBLFpRsjnyjI5yUAJn9gA5y42Z0r
	 +mj8Eru3HOmuw+Jgu0iC9+sBoYKR8fQTryqRHbjrg0hOpp7sBh3EUOlfrnge0Pby3Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=j3WjPL9S;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=j3WjPL9S;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D089606A323;
	Mon, 16 Nov 2026 18:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D089606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=j3WjPL9S;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=j3WjPL9S
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C13962230D;
	Mon, 16 Nov 2026 18:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bW+N6M5VBiGaPpTGAq3tyvEmQIBYUtGPyL5eNMej44k=;
	b=j3WjPL9SLm5UEruYv4nBQkfZVw/CvFQat0weEOQm937tsM6aLNagNzSNp/bmQUbt24YIJU
	Wt1MLN8Uk/7NXEqIO8cnIUnKw/n/UXlLvIUa+TPEm6K5hfoisFDdFcJtRbBTee0R3Hmed/
	RjdfXyaAHeFtQyTHoDNyOJdTPw7Bvvo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=j3WjPL9S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bW+N6M5VBiGaPpTGAq3tyvEmQIBYUtGPyL5eNMej44k=;
	b=j3WjPL9SLm5UEruYv4nBQkfZVw/CvFQat0weEOQm937tsM6aLNagNzSNp/bmQUbt24YIJU
	Wt1MLN8Uk/7NXEqIO8cnIUnKw/n/UXlLvIUa+TPEm6K5hfoisFDdFcJtRbBTee0R3Hmed/
	RjdfXyaAHeFtQyTHoDNyOJdTPw7Bvvo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F27E1334C;
	Mon, 16 Nov 2026 18:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bghDAilO+2rVeAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 18:40:41 +0000
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
Subject: [PATCH v6 16/17] x86/paravirt: Use alternatives for MSR access with paravirt
Date: Mon, 16 Nov 2026 19:39:04 +0100
Message-ID: <20261116183905.1591611-17-jgross@suse.com>
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
X-Rspamd-Queue-Id: C13962230D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.01

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
index afd9f7abec61..beb6ed47d797 100644
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
2.56.0

