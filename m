Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841393;
	b=5lKuVLEnm6ZrJkbwD/ZX6yyDFja1iy1WrR5/ufKyvwVr4IekoEnV4qinUf1pOMrso0fn
	 +YRPu3HkIyTqR5Y/VX54sQU+8WqQ+uZLb3XL/yPp1rHI15/sy1aOwMZ8Tvzv8WLa9xKZB
	 vm9qcH7SMCyRYfc13nUKBteSZzbiUbP1m30+LlqIcRKBfif70B1KlN/0wf8zGYKbOO5uU
	 ppudsUClj6Sg6ddAfivfURtOwBFuKrryKMA3g7oCcmFm02z+Hzu6FtIQ27KV0q/bRC5L0
	 iBkmn6LN9Q+7WxLMxhjch+vKEgRWTV/OVagnNgfgu2pPGRLls4Jjyw7gPzE7DXZ6lmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841393;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=ZvB6CQUyU0qwhXLGQ9Zg9p3eNUmNqnTiT6p23t0PuUI=;
	b=FoTuyJBwTMsZ/epLYWOiP3qZOkxH+iLUfQ2ETgvq5wVMdGx4HRY69EXr9RN9XnwZ8SYR
	 KX79v/5JODWBvO1E9V7T5rRR3g4RF7YWn3sEayVGnYLmJ4ijJ9hydeqOqqGn+pHxzhJqO
	 QV64TIXKc7tc4pvcTYPyZ9oFvIJalT65UsyzwaTTSeI3Y1yinFUIhHUUMrwuYAtNSitAL
	 4YNSXOJ+P/KEUy3QBFL6SEWweHRy6jFOHIDgYevsYGxzN1M3tV4zzeqqnDY8lMNWXj7Yp
	 hjoScG0po9Gu5IJt7BZQL7qcT70AoweYh691hR8PoSlQb20iTpx+mZFvOp0CZ4nBypg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BhZYL7WE;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BhZYL7WE;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5854606A883
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 15:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5854606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BhZYL7WE;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=BhZYL7WE
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3550F1F818;
	Mon, 16 Nov 2026 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794841391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvB6CQUyU0qwhXLGQ9Zg9p3eNUmNqnTiT6p23t0PuUI=;
	b=BhZYL7WE2fAV3sjwkJ9dzzBkx+GVz/Fq6pA/PwFYerOQYuK3j9CLxPbqPYNiLYudiI265U
	S6TqdDUzMlSaAhl2lidLhAF1sZ74aE6k7bH1DYODp2wAuow3GvQV2KcPSRCwq8rE5OCjaW
	wuFRlPQAolxFcA+orYd3glxXD1nC/fU=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BhZYL7WE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794841391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZvB6CQUyU0qwhXLGQ9Zg9p3eNUmNqnTiT6p23t0PuUI=;
	b=BhZYL7WE2fAV3sjwkJ9dzzBkx+GVz/Fq6pA/PwFYerOQYuK3j9CLxPbqPYNiLYudiI265U
	S6TqdDUzMlSaAhl2lidLhAF1sZ74aE6k7bH1DYODp2wAuow3GvQV2KcPSRCwq8rE5OCjaW
	wuFRlPQAolxFcA+orYd3glxXD1nC/fU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B16E113408;
	Mon, 16 Nov 2026 15:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9rq8IS4b+2qgEAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 15:03:10 +0000
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
Subject: [PATCH v6 10/12] x86/msr: Remove rdmsr()
Date: Mon, 16 Nov 2026 16:02:06 +0100
Message-ID: <20261116150208.1572254-11-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116150208.1572254-1-jgross@suse.com>
References: <20261116150208.1572254-1-jgross@suse.com>
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
X-Rspamd-Queue-Id: 3550F1F818
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
	URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.01

rdmsr() has no users left. Delete it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h      | 7 -------
 arch/x86/include/asm/paravirt.h | 7 -------
 2 files changed, 14 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index badab5762f3a..6d7bab33af71 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -179,13 +179,6 @@ static inline u64 native_read_pmc(int counter)
  * pointer indirection), this allows gcc to optimize better
  */
 
-#define rdmsr(msr, low, high)					\
-do {								\
-	u64 __val = native_read_msr((msr));			\
-	(void)((low) = (u32)__val);				\
-	(void)((high) = (u32)(__val >> 32));			\
-} while (0)
-
 #define rdmsrq(msr, val)			\
 	((val) = native_read_msr((msr)))
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 47d4e36d14cb..93754aa60d5e 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -150,13 +150,6 @@ static inline int paravirt_write_msr_safe(u32 msr, u64 val)
 	return PVOP_CALL2(int, pv_ops, cpu.write_msr_safe, msr, val);
 }
 
-#define rdmsr(msr, val1, val2)			\
-do {						\
-	u64 _l = paravirt_read_msr(msr);	\
-	val1 = (u32)_l;				\
-	val2 = _l >> 32;			\
-} while (0)
-
 #define rdmsrq(msr, val)			\
 do {						\
 	val = paravirt_read_msr(msr);		\
-- 
2.56.0

