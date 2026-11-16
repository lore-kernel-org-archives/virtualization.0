Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854374;
	b=VWb5XdPZsXm2tRLQPhGHrELjkHSSRP07/cxWfbORDDUmjPXtlEDMGrSBKbPBmgiGk0o4
	 2DkByZxYTFdhb7INAGdu9rrBjFpS5ysuHKjux7j1Vb74TL2mR9hZHGucAJigsyZn9oXQq
	 zEG9QvIX1K3asjgUH8GnAOVUx2TnKk9J1u/RZuJzmw77YhASh3P9zdxQmUF4FDcXMpF8a
	 XgRbu7T2RMXdpC+lBYK9ggYyMqq2wsLvvTnoLa/ZY+L+M7894HtUtuwqlgTLuOPkKTQDw
	 maZuWtb0cTZerfsA+QbECwQBM89x8li9SHbU0PW+crrxO7iT0dpzZnSetas7q3VARkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854374;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=3kBzDAxpATBZHUMk5PM+OY+gTX4GNJhZQKOQMqM/Ar4=;
	b=GeKndNm6PmbRvNxqiATX/sn2RZM0P01v6o9iIyYU7vhjCBCLWfDV0hIUX2eEue09xqcf
	 ZUuNEEBpFFAa7IaNnmBF/rlYPFtfuflPxrSQMPvmlpd+IfC137DlDRkstMcaWknaTWmq6
	 X/njKZED1FwNzp2i72trpfSJhAm6fVrFnJGCLbY9VLyIvlr9ABs8479Cz1igbsuEGoGBG
	 2MEoposttlZZUEzHwjHCpY1GdL2mhc6Qe/2+eS8jFASg0irjkA/H/ppgm6ly6zaCO/IMt
	 bxvaTuKrb/uzFbroz3tzMMgCKRJsm6qzAQAnWOxsquMa5wUH3qID5Cs6kyVzM/h1zdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b="l4/yekp1";
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=o+3jmBsa;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9845606A322
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 18:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9845606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=l4/yekp1;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=o+3jmBsa
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D1D141F8AE;
	Mon, 16 Nov 2026 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kBzDAxpATBZHUMk5PM+OY+gTX4GNJhZQKOQMqM/Ar4=;
	b=l4/yekp1JOEteMb5w/+OMLyLuAxJb/wh48u2cWSvKcth05oifUZutA7wRuAETyIkkkJXEt
	ZpE8r0Sd5IucXa+Cg/Q3ZpdfaYLdhm/gb5XuyqnM+6TkDhTEvqnxXZh/HTP7dR0k1b/fSj
	P4M7QnxyaePt4rvN3cvejke5vTXptp4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=o+3jmBsa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794854371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3kBzDAxpATBZHUMk5PM+OY+gTX4GNJhZQKOQMqM/Ar4=;
	b=o+3jmBsaFwTUnUyvlsswvaTuww+QorqzlFnfh0PyWprqf+4LeWk4lxTa5tBzP+LtpqJ+E6
	ETFBCuqV/HKKdiuxRPqJsZaC0n4XPRjKImyXeY0By8aU4wOcF3yvvW0/nTf2VR19zcuFCo
	DJ53/UIafHYQNq+qMFtSsVWyUm6jVJY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A5241334C;
	Mon, 16 Nov 2026 18:39:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZUTcDONN+2prdwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 18:39:31 +0000
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
Subject: [PATCH v6 04/17] x86/msr: Move MSR trace calls one function level up
Date: Mon, 16 Nov 2026 19:38:52 +0100
Message-ID: <20261116183905.1591611-5-jgross@suse.com>
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
X-Rspamd-Queue-Id: D1D141F8AE
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
	RCPT_COUNT_TWELVE(0.00)[12];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,zytor.com:email,suse.com:dkim,suse.com:email]
X-Spam-Score: -12.01

In order to prepare paravirt inlining of the MSR access instructions
move the calls of MSR trace functions one function level up.

Introduce {read|write}_msr[_safe]() helpers allowing to have common
definitions in msr.h doing the trace calls.

Do the same for rdpmc(), which up to now didn't support tracing under
Xen PV.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
V4:
- some modifications removed due to rebase
V6:
- cover rdpmc() as well (Shreshth Srivastava)
---
 arch/x86/include/asm/msr.h      | 91 +++++++++++++++++++++++----------
 arch/x86/include/asm/paravirt.h | 10 ++--
 2 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 3b33d432bc24..be23d30ad0b0 100644
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
 
@@ -156,8 +142,7 @@ static inline u64 native_read_pmc(int counter)
 	EAX_EDX_DECLARE_ARGS(val, low, high);
 
 	asm volatile("rdpmc" : EAX_EDX_RET(val, low, high) : "c" (counter));
-	if (tracepoint_enabled(rdpmc))
-		do_trace_rdpmc(counter, EAX_EDX_VAL(val, low, high), 0);
+
 	return EAX_EDX_VAL(val, low, high);
 }
 
@@ -165,36 +150,88 @@ static inline u64 native_read_pmc(int counter)
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
+static __always_inline u64 do_rdpmc(int counter)
+{
+	return native_read_pmc(counter);
+}
+#endif /* !CONFIG_PARAVIRT_XXL */
 
 /* Access to machine-specific registers (available on 586 and better only) */
 
 static __always_inline u64 rdmsrq(u32 msr)
 {
-	return native_read_msr(msr);
+	u64 val = read_msr(msr);
+
+	if (tracepoint_enabled(read_msr))
+		do_trace_read_msr(msr, val, 0);
+
+	return val;
+}
+
+/* rdmsr with exception handling */
+static inline int rdmsrq_safe(u32 msr, u64 *p)
+{
+	int err;
+
+	err = read_msr_safe(msr, p);
+
+	if (tracepoint_enabled(read_msr))
+		do_trace_read_msr(msr, *p, err);
+
+	return err;
 }
 
 static inline void wrmsrq(u32 msr, u64 val)
 {
-	native_write_msr(msr, val);
+	write_msr(msr, val);
+
+	if (tracepoint_enabled(write_msr))
+		do_trace_write_msr(msr, val, 0);
 }
 
 /* wrmsr with exception handling */
 static inline int wrmsrq_safe(u32 msr, u64 val)
 {
-	return native_write_msr_safe(msr, val);
-}
+	int err;
 
-static inline int rdmsrq_safe(u32 msr, u64 *p)
-{
-	return native_read_msr_safe(msr, p);
+	err = write_msr_safe(msr, val);
+
+	if (tracepoint_enabled(write_msr))
+		do_trace_write_msr(msr, val, err);
+
+	return err;
 }
 
 static __always_inline u64 rdpmc(int counter)
 {
-	return native_read_pmc(counter);
-}
+	u64 val;
 
-#endif	/* !CONFIG_PARAVIRT_XXL */
+	val = do_rdpmc(counter);
+	if (tracepoint_enabled(rdpmc))
+		do_trace_rdpmc(counter, val, 0);
+
+	return val;
+}
 
 /* Instruction opcode for WRMSRNS supported in binutils >= 2.40 */
 #define ASM_WRMSRNS _ASM_BYTES(0x0f,0x01,0xc6)
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 19442bc3af37..615f0c42a881 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -150,27 +150,27 @@ static inline int paravirt_write_msr_safe(u32 msr, u64 val)
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
 
-static __always_inline u64 rdpmc(int counter)
+static __always_inline u64 do_rdpmc(int counter)
 {
 	return PVOP_CALL1(u64, pv_ops, cpu.read_pmc, counter);
 }
-- 
2.56.0

