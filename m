Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019768;
	b=jQSvc3RrHQQ0+10KYSUYcV2wcjt17DfUAJvvFKHDXlL4wfvzJ7Tsg9PlZlp+dAwnSWO0
	 FijCLNFPazUlxNj4g4/GxVX1c2jft73U5PWChGc3ym09RccOZSMKlFBnMySn2XYzf6enU
	 UglIbsXF0ESo5vhYRPTnz9WqhCXDkcLST4JAq+E77oL53aio7pjB94L9cqy0Q2Ln3OwzM
	 CP1WwJiX0uhe8/Bwk9oaDUrHzTl+Xf6n9DgFMbNrTUbaecTmh/qTcX+GlsPLJo8+sZtxC
	 AjKyrFW0AK3f6i6U/1YoSi3LUX0kDElN3g2L9OftPlXbixnZdz9vlTA+oa0vL0jpqtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019768;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Pre-Result:X-Rspamd-Server:
	 X-Spamd-Result:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Pre-Result:X-Rspamd-Action;
	bh=zQc5EyICwi/WW/kWrbTagUCxV3C3Ca0wfz47B+uZJxc=;
	b=BAu20qBhFJJK11pjZsBOFBC6mnCLBNiNkecF878G28CoVOCMS3sneAeh1OSdyY5Y1LZU
	 rvTSbR2duBBgppF+zWyjPjkND+p+xfcjguvkTZrDy5E0NIihG26eolpRRWW2D08aSbAW/
	 VYHOQVD0Zos4voakp+gB8tut5M0WMJwSgfPpEvaYThYoM4Z2cX0wzxyhqxOYHZXznHYUH
	 6AQijLG8dnUO6qRQdjFV5R5Vu7h6EnFteJP7YgmtQPZYZwEd8jMqlJoZaZv8Pye/NV5iV
	 +B4BhZonprVMMDFjGDJN35g+npvU88oUM3g/XdqVRb3Hfx5uafrUvnHOPELCBmx5wOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB5606A320
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 13:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DFB5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78932222B7;
	Mon, 26 Oct 2026 13:02:45 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0682513408;
	Mon, 26 Oct 2026 13:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ShNgM3RP32oUWwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 26 Oct 2026 13:02:45 +0000
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
Subject: [PATCH v5 03/12] x86/msr: Remove rdmsr_safe()
Date: Mon, 26 Oct 2026 14:02:14 +0100
Message-ID: <20261026130223.773129-4-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026130223.773129-1-jgross@suse.com>
References: <20261026130223.773129-1-jgross@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 78932222B7
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

rdmsr_safe() has no users left. Delete it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h      | 10 ----------
 arch/x86/include/asm/paravirt.h | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 6fb7125608c7..776a2daa2ba2 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -205,16 +205,6 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 	return native_write_msr_safe(msr, val);
 }
 
-/* rdmsr with exception handling */
-#define rdmsr_safe(msr, low, high)				\
-({								\
-	u64 __val;						\
-	int __err = native_read_msr_safe((msr), &__val);	\
-	(*low) = (u32)__val;					\
-	(*high) = (u32)(__val >> 32);				\
-	__err;							\
-})
-
 static inline int rdmsrq_safe(u32 msr, u64 *p)
 {
 	return native_read_msr_safe(msr, p);
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 0591aa38fd85..97b082095572 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -177,16 +177,6 @@ static inline int wrmsrq_safe(u32 msr, u64 val)
 	return paravirt_write_msr_safe(msr, val);
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
 static __always_inline int rdmsrq_safe(u32 msr, u64 *p)
 {
 	return paravirt_read_msr_safe(msr, p);
-- 
2.56.0

