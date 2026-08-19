Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C2844A412
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135072; cv=none; b=ACpA83txnBbWZjsMmQ6zWImI8r+1+wsg/t/e58tf52MiHkGN+pEWiUh8gqi+MNqeVmuoA4tO9LEkUDVYbZHd2lEr4uQ/tbIFttPTH1tMLiVghfRp4o2bg53C4kivgXSJJm1F866e08hC3/iuv+2Sdz8AIZsB5jpUV9TxRDFX9rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135072; c=relaxed/simple;
	bh=rzLwArAda9EFnuuP3t+Y981C2O1OrmodTAiCAeP5NPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0onquz1EpyYN8SCKVgJaYBpwlaUqf+4Zt2bXEAnPOWMCrDOvgOtKcRgmgj/8SmOVfSCOrmO2GCRWJQi+WpOYn8nxgZVCByYlBS4gnuVr5WvUrSSvyFnP9zCPJD3o8sdNL+F5EVrF+k3Qh2+gMs9oH2vplfhH9LYIe8RdSn0Pz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jiVvuIQk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sIu4ScTW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jiVvuIQk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sIu4ScTW"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7371F84A8C;
	Wed, 19 Aug 2026 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787135064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtSBOhbPSYfOorSkQqHi63N9+clGucYRe7dUwXwwSqA=;
	b=jiVvuIQkEZZgZSl/ZLUrM5bQdmYRP8+cSgZI3XdW0qTP1O1VLQQfRJGTyZ/55mw3gnVbyB
	dGaiCCMgjh3d5JMRz6CDvxkfTRTX1VRQHjQCqKcANMAOoxsQRvGG1HYE6raHHp7VPJe+hC
	YtdCmcktu/V1QgsTaYqbjoWxbk+rG34=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1787135060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtSBOhbPSYfOorSkQqHi63N9+clGucYRe7dUwXwwSqA=;
	b=sIu4ScTWThmEa80YPiGbMcoKYqwWtt5uTf896vweW5gs+KkVprgjQYT0Gk3aPrOnDp7hAz
	WCiiJZz4Igr70BMlqZg9I79LolmXW5YE9G2GcIBm22Q75N9o9LnLbewqLQfuVjX/55T3Xa
	KMwQQbMXIpk+yfr8p3lzdoZuVFDJlkY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A4F0367A;
	Wed, 19 Aug 2026 10:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PJ0fCVSEhWrgEgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 19 Aug 2026 10:24:20 +0000
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
Subject: [PATCH v2 11/13] x86/msr: Remove rdmsr()
Date: Wed, 19 Aug 2026 12:23:12 +0200
Message-ID: <20260819102314.1499258-12-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819102314.1499258-1-jgross@suse.com>
References: <20260819102314.1499258-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

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
2.55.0

