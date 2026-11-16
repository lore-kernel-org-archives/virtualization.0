Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841387;
	b=g7J/DMgTOTAMNP7KqrrCOleFqxCFaVblCYwq+BUWrF/z1BRZhqdxhVqB9gEOtY8WdPET
	 UQ+7WVVwZFXeeFpfKmziDupRfRqVLtMdJtEdrwP40yEAuaHW4GdGMkUz9llUo3OeGo0oP
	 NkgqAf5/+OIWKu3RCiuKd7jb9iyGiKR560pQZ6SCLxQzUEwiNyyHZo0rCGA+rWhmiIWfn
	 FVzPw4uE73eXIetNRDg+ZSAOS7YC/mEphhBoAQDUV96sU8GpdQl3E7+M/xGjcTGkyfNyF
	 WDFx3aA2ly0KNV2eBzF8LcXTr87JCnCHrAhQn5YaGjvdCNfgNS9o6USq4hewaJW21Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841387;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-Spam-Flag:
	 X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=YnPuilh2RpPWZzk8l1KEkPhcgPz+FSvpgZ6Mkcple3g=;
	b=uE5T1s+RESGkBomuKoo2ZLDJV7wQ+6eKlFgYLt5pw2s8cQKdRRtk9lOSnp6Y+1JcsoQK
	 zuuNgdbsF88BYZ5SximuNkcFdga0cA2NRjky9PGfl3zXv3XnX5a8HJV48VFtN8VkEr+7v
	 Mefbs9k3h5UAMJuKZg7GoLKRiiCGVGK8DWdCS74d0kHFoeUTJYDKLdRpWOP4yyLRBeLMe
	 WLR47lyLWXHcN2b+kGveXpXb8VBtuP8USXFlhjWJLIHtbLxtSJYbogQsEP0Z90TMgpqFc
	 99jsWD4fDoaDMEIq4Ygp57BtGM0LQJRwRURBloNMkFNmjityKkGjQbk2/6UOBLCJ0BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=h65dbdks;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=h65dbdks;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C80606A8B3
	for <virtualization@lists.linux.dev>; Mon, 16 Nov 2026 15:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0C80606A8B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=h65dbdks;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=h65dbdks
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C58C1F7EA;
	Mon, 16 Nov 2026 15:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794841385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnPuilh2RpPWZzk8l1KEkPhcgPz+FSvpgZ6Mkcple3g=;
	b=h65dbdksAlmoY6e2lA00C2L0ojkrD647xzPdF2qFPPPUNwbts9jhVQ/zJ4u04Sd7XKOQXa
	Mmhyu1j8+Er5RDztIs+42OJSSR0EniGfVSUZFVc/Xp+h7sEdbPKDD95Dg+sQwT04p9c7Yg
	vks0XZhQWwcpz/G0x3UTVauiTzkmqjg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1794841385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnPuilh2RpPWZzk8l1KEkPhcgPz+FSvpgZ6Mkcple3g=;
	b=h65dbdksAlmoY6e2lA00C2L0ojkrD647xzPdF2qFPPPUNwbts9jhVQ/zJ4u04Sd7XKOQXa
	Mmhyu1j8+Er5RDztIs+42OJSSR0EniGfVSUZFVc/Xp+h7sEdbPKDD95Dg+sQwT04p9c7Yg
	vks0XZhQWwcpz/G0x3UTVauiTzkmqjg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E01A713408;
	Mon, 16 Nov 2026 15:03:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fu1yLCgb+2qWEAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 15:03:04 +0000
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
Subject: [PATCH v6 09/12] x86/msr: Remove wrmsr()
Date: Mon, 16 Nov 2026 16:02:05 +0100
Message-ID: <20261116150208.1572254-10-jgross@suse.com>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -11.80

wrmsr() has no users left. Delete it.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h      | 5 -----
 arch/x86/include/asm/paravirt.h | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 776a2daa2ba2..badab5762f3a 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -186,11 +186,6 @@ do {								\
 	(void)((high) = (u32)(__val >> 32));			\
 } while (0)
 
-static inline void wrmsr(u32 msr, u32 low, u32 high)
-{
-	native_write_msr(msr, (u64)high << 32 | low);
-}
-
 #define rdmsrq(msr, val)			\
 	((val) = native_read_msr((msr)))
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 97b082095572..47d4e36d14cb 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -157,11 +157,6 @@ do {						\
 	val2 = _l >> 32;			\
 } while (0)
 
-static __always_inline void wrmsr(u32 msr, u32 low, u32 high)
-{
-	paravirt_write_msr(msr, (u64)high << 32 | low);
-}
-
 #define rdmsrq(msr, val)			\
 do {						\
 	val = paravirt_read_msr(msr);		\
-- 
2.56.0

