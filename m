Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E5A4570FE
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112810; cv=none; b=ZCo7QIR12921dtyf7pPt8bgJ80y3CGedvzhNBQ8A6XVIQa/xN/NazYgg+a9mq3pC6lqCiHTtofRxxGNZwT7CtSTbU6RXzeKZw94DTtlKxKBJYAmpLWCl+fuX5lThY4c1laOh0DyPIS+FXmBhLX3gpK/GpxlTG02rK3jOKYhhJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112810; c=relaxed/simple;
	bh=rzLwArAda9EFnuuP3t+Y981C2O1OrmodTAiCAeP5NPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3Frbtyz6XrPAgtMr6XIlJZGDIpKkIgQ0UmTa/QZRwvPKzCpvF2ErHYaEpkk50UwcrA0TfXjOOxz/Udm7OmHLnwTLQTOOWPm7DRIk0MpcXiodxZtfArroYt1YbiSbiZ3i+x2zUxCVYWAy2gUlCOwV6OYoh5FlkVI8By8aVhQpOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=m8t7E/hM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sisoI7hE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="m8t7E/hM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sisoI7hE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 971D71FDA8;
	Fri, 11 Sep 2026 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789112802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtSBOhbPSYfOorSkQqHi63N9+clGucYRe7dUwXwwSqA=;
	b=m8t7E/hMl7CLejAP/U0B9YNsx6aOw+mBds45cNoU+2wDINOZzmGBxSrj0nu7+6UKU7ikss
	e+jAyDOOuX2KngBmsTaXKSb6A7jATAoifurHdxkpEmybJxuVubcvjxCCSwdZzKYRpq/ROq
	imkRKzJl3WkAngNM1LRHPfLa6rKOI6g=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1789112798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DtSBOhbPSYfOorSkQqHi63N9+clGucYRe7dUwXwwSqA=;
	b=sisoI7hEPtq829r05JKMiBpwSTxNNq4KQxXstqFj4cN2a+uZl4nYGtachGkNdmIUrK4C4U
	U1ASPYS6RUrDMC7lFqvwa1xo5we3oh/GSEbtw2DYMurTLuTH6DDTYdRhjxW5oKrcKFqf9p
	pfrMdEPo1dcnnp0+P6G1AU6VgxwP8po=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2400413770;
	Fri, 11 Sep 2026 07:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K0Z8B96xo2roWQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 11 Sep 2026 07:46:38 +0000
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
Subject: [PATCH v3 11/13] x86/msr: Remove rdmsr()
Date: Fri, 11 Sep 2026 09:45:28 +0200
Message-ID: <20260911074530.3140830-12-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911074530.3140830-1-jgross@suse.com>
References: <20260911074530.3140830-1-jgross@suse.com>
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
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

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

