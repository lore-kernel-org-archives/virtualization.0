Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F70468C1F
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116169; cv=none; b=Um5ZnY/EHzMaPRj/xd3GSTYzcDoIfkp91v7d5Xh/laUYRXm4qwQTsOs7iqS3gK9BSqEwbVmxLbghEBHgCJL4VXW1e+MHPCXriB52o4OelBpvrtWmcZ35gt/ghq5B5SwwiGKzTIXtOdO6ZQRhVC6K3HSupjCui8J/1qnHmLzokEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116169; c=relaxed/simple;
	bh=f9UwdrxepqNciTBtXdG+aQLn0gQQY2X+Gi6KFho8Ayk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXdrU0iqQXcsqPvtAN6cxxvQVpTIFYWdkvtfhXCVnXDrK7CjRt8QLgRQ4WO6zgnZ0golZZ9xskfB54ZO/skjeQfaoLm4sjsEKayiqCCt6R+joAX5vpqyqQDDPEbyOFaPZo2dbhA1wTB8eHxnCP0AK47YbrUXb9jHY+WT+UGR86I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mZNROXAZ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FafZXVRY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mZNROXAZ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FafZXVRY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 609861FD88;
	Fri, 11 Sep 2026 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789116161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7i07tuKBTRpDmnSfBdf/nH8VXSfkXu6CTmWxxIIUWs=;
	b=mZNROXAZMokjRQu11ZS/9ZKgn1SQq3UAVRP8b1nUU2L09XJVM/00PBAhfk4dh91v+LdnD5
	WwbhFx29zjFUorQu4Ykrr95yPX+IGdL6+pyO81X1aBLILenksU9tGD4y4P9Gyon6V4qxky
	kGOJxYycfy3jiNB+rcEbQ+7kqMUHAMM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789116157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7i07tuKBTRpDmnSfBdf/nH8VXSfkXu6CTmWxxIIUWs=;
	b=FafZXVRYcRpGlHY/ptZOuwF9ACs7Av7WclY6/DsDJG6Z/jrIorjkjtUu0C2qj7OQW7P3oR
	KgLy1NPrVW259ceZHOSicOHuF9gb95EgcISRqFrKhYdqdFLiCNQyqBk+PlhnkCtyv3Pjz4
	hLrIb8nnvdQEsDubGRunmKjtcIKl8wc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2C4513715;
	Fri, 11 Sep 2026 08:42:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XZkUNvy+o2oiFQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 11 Sep 2026 08:42:36 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH v5 04/17] x86/msr: Move MSR trace calls one function level up
Date: Fri, 11 Sep 2026 10:41:58 +0200
Message-ID: <20260911084211.3149957-5-jgross@suse.com>
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
X-Spam-Score: -6.80
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

In order to prepare paravirt inlining of the MSR access instructions
move the calls of MSR trace functions one function level up.

Introduce {read|write}_msr[_safe]() helpers allowing to have common
definitions in msr.h doing the trace calls.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
V4:
- some modifications removed due to rebase
---
 arch/x86/include/asm/msr.h      | 79 ++++++++++++++++++++++-----------
 arch/x86/include/asm/paravirt.h |  8 ++--
 2 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 3b33d432bc24..266298b3d201 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -95,14 +95,7 @@ static __always_inline void native_wrmsrq(u32 msr, u64 val)
 
 static inline u64 native_read_msr(u32 msr)
 {
-	u64 val;
-
-	val = __rdmsr(msr);
-
-	if (tracepoint_enabled(read_msr))
-		do_trace_read_msr(msr, val, 0);
-
-	return val;
+	return __rdmsr(msr);
 }
 
 static inline int native_read_msr_safe(u32 msr, u64 *p)
@@ -115,8 +108,6 @@ static inline int native_read_msr_safe(u32 msr, u64 *p)
 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_RDMSR_SAFE, %[err])
 		     : [err] "=r" (err), EAX_EDX_RET(val, low, high)
 		     : "c" (msr));
-	if (tracepoint_enabled(read_msr))
-		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), err);
 
 	*p = EAX_EDX_VAL(val, low, high);
 
@@ -127,9 +118,6 @@ static inline int native_read_msr_safe(u32 msr, u64 *p)
 static inline void notrace native_write_msr(u32 msr, u64 val)
 {
 	native_wrmsrq(msr, val);
-
-	if (tracepoint_enabled(write_msr))
-		do_trace_write_msr(msr, val, 0);
 }
 
 /* Can be uninlined because referenced by paravirt */
@@ -143,8 +131,6 @@ static inline int notrace native_write_msr_safe(u32 msr, u64 val)
 		     : [err] "=a" (err)
 		     : "c" (msr), "0" ((u32)val), "d" ((u32)(val >> 32))
 		     : "memory");
-	if (tracepoint_enabled(write_msr))
-		do_trace_write_msr(msr, val, err);
 	return err;
 }
 
@@ -165,36 +151,77 @@ static inline u64 native_read_pmc(int counter)
 #include <asm/paravirt.h>
 #else
 #include <linux/errno.h>
-
-/* Access to machine-specific registers (available on 586 and better only) */
-
-static __always_inline u64 rdmsrq(u32 msr)
+static __always_inline u64 read_msr(u32 msr)
 {
 	return native_read_msr(msr);
 }
 
-static inline void wrmsrq(u32 msr, u64 val)
+static __always_inline int read_msr_safe(u32 msr, u64 *p)
+{
+	return native_read_msr_safe(msr, p);
+}
+
+static __always_inline void write_msr(u32 msr, u64 val)
 {
 	native_write_msr(msr, val);
 }
 
-/* wrmsr with exception handling */
-static inline int wrmsrq_safe(u32 msr, u64 val)
+static __always_inline int write_msr_safe(u32 msr, u64 val)
 {
 	return native_write_msr_safe(msr, val);
 }
 
+static __always_inline u64 rdpmc(int counter)
+{
+	return native_read_pmc(counter);
+}
+#endif /* !CONFIG_PARAVIRT_XXL */
+
+/* Access to machine-specific registers (available on 586 and better only) */
+
+static __always_inline u64 rdmsrq(u32 msr)
+{
+	u64 val = read_msr(msr);
+
+	if (tracepoint_enabled(read_msr))
+		do_trace_read_msr(msr, val, 0);
+
+	return val;
+}
+
+/* rdmsr with exception handling */
 static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
-	return native_read_msr_safe(msr, p);
+	int err;
+
+	err = read_msr_safe(msr, p);
+
+	if (tracepoint_enabled(read_msr))
+		do_trace_read_msr(msr, *p, err);
+
+	return err;
 }
 
-static __always_inline u64 rdpmc(int counter)
+static inline void wrmsrq(u32 msr, u64 val)
 {
-	return native_read_pmc(counter);
+	write_msr(msr, val);
+
+	if (tracepoint_enabled(write_msr))
+		do_trace_write_msr(msr, val, 0);
 }
 
-#endif	/* !CONFIG_PARAVIRT_XXL */
+/* wrmsr with exception handling */
+static inline int wrmsrq_safe(u32 msr, u64 val)
+{
+	int err;
+
+	err = write_msr_safe(msr, val);
+
+	if (tracepoint_enabled(write_msr))
+		do_trace_write_msr(msr, val, err);
+
+	return err;
+}
 
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 19442bc3af37..a5a1fc4c88d1 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -150,22 +150,22 @@ static inline int paravirt_write_msr_safe(u32 msr, u64 val)
 	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
 }
 
-static __always_inline u64 rdmsrq(u32 msr)
+static __always_inline u64 read_msr(u32 msr)
 {
 	return paravirt_read_msr(msr);
 }
 
-static inline void wrmsrq(u32 msr, u64 val)
+static inline void write_msr(u32 msr, u64 val)
 {
 	paravirt_write_msr(msr, val);
 }
 
-static inline int wrmsrq_safe(u32 msr, u64 val)
+static inline int write_msr_safe(u32 msr, u64 val)
 {
 	return paravirt_write_msr_safe(msr, val);
 }
 
-static __always_inline int rdmsrq_safe(u32 msr, u64 *p)
+static __always_inline int read_msr_safe(u32 msr, u64 *p)
 {
 	return paravirt_read_msr_safe(msr, p);
 }
-- 
2.55.0

