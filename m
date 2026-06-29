Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3A3BBFC5
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782716181; cv=none; b=Hw6A8osW4EQvC2OZfVvbyHVT7pZn02s1YJLaD6YMIyz41QakEdgQpAc66EnPoRXCLUwGPGfhdMWCAVfnO4nmCZzwnfK0CrlhO89iVKeQaZls+Nva5HPbinzH6w2OmAxoN9NdlV8k0x+GkOuhgqKqIiCit3fWRVOa2m5RDBvh+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782716181; c=relaxed/simple;
	bh=mWU5qlQdF5arQ91n/ymqfm/BFgn0HWaJXD7wAZlCRkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0gC7DmHfHGl8dAh3307Ajwk7Gol99JAw85I33p8iPCxgjiUf89tNNeyw84L3dsu02keaSR9FOdOFWjBtmCmMg0rZ4wuVksB7rB6E4LuBfbe0qFXXtGl+6U2YLkbctNI08RrRL/evF8IgFNnY0EUpd4W8sCTXm4IPI1NaS+NupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E228E71266;
	Mon, 29 Jun 2026 06:56:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88360779A8;
	Mon, 29 Jun 2026 06:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bWWiHw8XQmqyQQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:56:15 +0000
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
Subject: [PATCH v4 05/18] x86/msr: Move MSR trace calls one function level up
Date: Mon, 29 Jun 2026 08:55:31 +0200
Message-ID: <20260629065544.3643253-6-jgross@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E228E71266
X-Rspamd-Action: no action

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
2.54.0

