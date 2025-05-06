Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3F2264612
	for <virtualization@lists.linux.dev>; Tue,  6 May 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523250; cv=none; b=BrHBfASkGvg8L9ljicay3NHbSYXCa0hKomh+mozGqc/J+1W1dMBPD38cNadu0a+KXamLKcTk1s2wXYEfJlMe/oLF3TQbBjxzQ5GMahrHZLfx1/YDY49pzW0JHFgtuhzo5FJMBP6v1zFFUNt3N6R4X6RFAkR4YKGUmzY717A2aWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523250; c=relaxed/simple;
	bh=oDTTGA8uXpO9qySegO3KM8xPb/HKk4ekq7QRkfocVBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEZ88Tu/7WKglaZHUo9xw4dp3FqdgDblXMCvp28J35lfdjyJ7iaraP9ZYkBccCUo4Mpg8p65BXDBGBTcVtEt3vAVnhCa33iQju7Mb5YgYhnliRyfWavcXYkG9hIuLB5wWCXE13tK0JNpywnX94d90gnkQGUTANZSLa5iiicL770=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qSf4JTBY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qSf4JTBY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qSf4JTBY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qSf4JTBY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD22D1F395;
	Tue,  6 May 2025 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746523246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1UsYlsYPKJkC5A0IWcoH/TBNwug3KwO3TAHM/SwaTE=;
	b=qSf4JTBY8v1MjwwQxh5kJNcKb0KffmBUq1AxKkZINorFFT0D/0bAXjbTGgXCjNWHB57cc1
	jnvSCg3V/mFf9U+fBqbKmHnc3R7fZyW3iLvsvz4vlYAAU2p4m3qd9zlg362OuO7FwHrRks
	zRkMYuPGea/C0OMA7zk7xp44CQQeEU8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1746523246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P1UsYlsYPKJkC5A0IWcoH/TBNwug3KwO3TAHM/SwaTE=;
	b=qSf4JTBY8v1MjwwQxh5kJNcKb0KffmBUq1AxKkZINorFFT0D/0bAXjbTGgXCjNWHB57cc1
	jnvSCg3V/mFf9U+fBqbKmHnc3R7fZyW3iLvsvz4vlYAAU2p4m3qd9zlg362OuO7FwHrRks
	zRkMYuPGea/C0OMA7zk7xp44CQQeEU8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C335137CF;
	Tue,  6 May 2025 09:20:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KBf9FG7UGWgpbAAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 06 May 2025 09:20:46 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: xin@zytor.com,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH 4/6] x86/msr: Move MSR trace calls one function level up
Date: Tue,  6 May 2025 11:20:13 +0200
Message-ID: <20250506092015.1849-5-jgross@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506092015.1849-1-jgross@suse.com>
References: <20250506092015.1849-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

In order to prepare paravirt inlining of the MSR access instructions
move the calls of MSR trace functions one function level up.

Introduce helpers {read|write}_msr[_safe]() helpers allowing to have
common definitions in msr.h doing the trace calls.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h      | 102 ++++++++++++++++++++------------
 arch/x86/include/asm/paravirt.h |  38 +++---------
 2 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index a9ce56fc8785..3a94cffb6a3e 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -103,14 +103,7 @@ static __always_inline u64 native_rdmsrq(u32 msr)
 
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
@@ -123,8 +116,6 @@ static inline int native_read_msr_safe(u32 msr, u64 *p)
 		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_RDMSR_SAFE, %[err])
 		     : [err] "=r" (err), EAX_EDX_RET(val, low, high)
 		     : "c" (msr));
-	if (tracepoint_enabled(read_msr))
-		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), err);
 
 	*p = EAX_EDX_VAL(val, low, high);
 
@@ -135,9 +126,6 @@ static inline int native_read_msr_safe(u32 msr, u64 *p)
 static inline void notrace native_write_msr(u32 msr, u64 val)
 {
 	native_wrmsrq(msr, val);
-
-	if (tracepoint_enabled(write_msr))
-		do_trace_write_msr(msr, val, 0);
 }
 
 /* Can be uninlined because referenced by paravirt */
@@ -151,8 +139,6 @@ static inline int notrace native_write_msr_safe(u32 msr, u64 val)
 		     : [err] "=a" (err)
 		     : "c" (msr), "0" ((u32)val), "d" ((u32)(val >> 32))
 		     : "memory");
-	if (tracepoint_enabled(write_msr))
-		do_trace_write_msr(msr, val, err);
 	return err;
 }
 
@@ -173,59 +159,96 @@ static inline u64 native_read_pmc(int counter)
 #include <asm/paravirt.h>
 #else
 #include <linux/errno.h>
+static __always_inline u64 read_msr(u32 msr)
+{
+	return native_read_msr(msr);
+}
+
+static __always_inline int read_msr_safe(u32 msr, u64 *p)
+{
+	return native_read_msr_safe(msr, p);
+}
+
+static __always_inline void write_msr(u32 msr, u64 val)
+{
+	native_write_msr(msr, val);
+}
+
+static __always_inline int write_msr_safe(u32 msr, u64 val)
+{
+	return native_write_msr_safe(msr, val);
+}
+
+static __always_inline u64 rdpmc(int counter)
+{
+	return native_read_pmc(counter);
+}
+
+#endif	/* !CONFIG_PARAVIRT_XXL */
+
 /*
  * Access to machine-specific registers (available on 586 and better only)
  * Note: the rd* operations modify the parameters directly (without using
  * pointer indirection), this allows gcc to optimize better
  */
 
+#define rdmsrq(msr, val)			\
+do {						\
+	(val) = read_msr(msr);			\
+	if (tracepoint_enabled(read_msr))	\
+		do_trace_read_msr(msr, val, 0);	\
+} while (0)
+
 #define rdmsr(msr, low, high)					\
 do {								\
-	u64 __val = native_read_msr((msr));			\
+	u64 __val;						\
+	rdmsrq(msr, __val);					\
 	(void)((low) = (u32)__val);				\
 	(void)((high) = (u32)(__val >> 32));			\
 } while (0)
 
-static inline void wrmsr(u32 msr, u32 low, u32 high)
+/* rdmsr with exception handling */
+static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
-	native_write_msr(msr, (u64)high << 32 | low);
-}
+	int err;
 
-#define rdmsrq(msr, val)			\
-	((val) = native_read_msr((msr)))
+	err = read_msr_safe(msr, p);
 
-static inline void wrmsrq(u32 msr, u64 val)
-{
-	native_write_msr(msr, val);
-}
+	if (tracepoint_enabled(read_msr))
+		do_trace_read_msr(msr, *p, err);
 
-/* wrmsr with exception handling */
-static inline int wrmsrq_safe(u32 msr, u64 val)
-{
-	return native_write_msr_safe(msr, val);
+	return err;
 }
 
-/* rdmsr with exception handling */
 #define rdmsr_safe(msr, low, high)				\
 ({								\
 	u64 __val;						\
-	int __err = native_read_msr_safe((msr), &__val);	\
+	int __err = rdmsrq_safe((msr), &__val);			\
 	(*low) = (u32)__val;					\
 	(*high) = (u32)(__val >> 32);				\
 	__err;							\
 })
 
-static inline int rdmsrq_safe(u32 msr, u64 *p)
+static inline void wrmsrq(u32 msr, u64 val)
 {
-	return native_read_msr_safe(msr, p);
+	write_msr(msr, val);
+
+	if (tracepoint_enabled(write_msr))
+		do_trace_write_msr(msr, val, 0);
 }
 
-static __always_inline u64 rdpmc(int counter)
+/* wrmsr with exception handling */
+static inline int wrmsrq_safe(u32 msr, u64 val)
 {
-	return native_read_pmc(counter);
-}
+	int err;
 
-#endif	/* !CONFIG_PARAVIRT_XXL */
+	err = write_msr_safe(msr, val);
+
+	if (tracepoint_enabled(write_msr))
+		do_trace_write_msr(msr, val, err);
+
+	return err;
+}
 
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
@@ -242,6 +265,11 @@ static __always_inline void wrmsrns(u32 msr, u64 val)
 		     : : "c" (msr), "a" ((u32)val), "d" ((u32)(val >> 32)));
 }
 
+static inline void wrmsr(u32 msr, u32 low, u32 high)
+{
+	wrmsrq(msr, (u64)high << 32 | low);
+}
+
 /*
  * Dual u32 version of wrmsrq_safe():
  */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 03f680d1057a..a463c747c780 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -195,46 +195,24 @@ static inline int paravirt_write_msr_safe(u32 msr, u64 val)
 	return PVOP_CALL2(int, cpu.write_msr_safe, msr, val);
 }
 
-#define rdmsr(msr, val1, val2)			\
-do {						\
-	u64 _l = paravirt_read_msr(msr);	\
-	val1 = (u32)_l;				\
-	val2 = _l >> 32;			\
-} while (0)
-
-static __always_inline void wrmsr(u32 msr, u32 low, u32 high)
+static __always_inline u64 read_msr(u32 msr)
 {
-	paravirt_write_msr(msr, (u64)high << 32 | low);
+	return paravirt_read_msr(msr);
 }
 
-#define rdmsrq(msr, val)			\
-do {						\
-	val = paravirt_read_msr(msr);		\
-} while (0)
-
-static inline void wrmsrq(u32 msr, u64 val)
+static __always_inline int read_msr_safe(u32 msr, u64 *p)
 {
-	paravirt_write_msr(msr, val);
+	return paravirt_read_msr_safe(msr, p);
 }
 
-static inline int wrmsrq_safe(u32 msr, u64 val)
+static __always_inline void write_msr(u32 msr, u64 val)
 {
-	return paravirt_write_msr_safe(msr, val);
+	paravirt_write_msr(msr, val);
 }
 
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr, a, b)				\
-({							\
-	u64 _l;						\
-	int _err = paravirt_read_msr_safe((msr), &_l);	\
-	(*a) = (u32)_l;					\
-	(*b) = (u32)(_l >> 32);				\
-	_err;						\
-})
-
-static __always_inline int rdmsrq_safe(u32 msr, u64 *p)
+static __always_inline int write_msr_safe(u32 msr, u64 val)
 {
-	return paravirt_read_msr_safe(msr, p);
+	return paravirt_write_msr_safe(msr, val);
 }
 
 static __always_inline u64 rdpmc(int counter)
-- 
2.43.0

