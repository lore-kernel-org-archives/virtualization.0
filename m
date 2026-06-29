Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF538AC79
	for <virtualization@lists.linux.dev>; Mon, 29 Jun 2026 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713283; cv=none; b=i7yRkn8ce8PNcDYBZb2mGTs74uZp3FMXdA+hXb/kZF1nzB4t9VQ3VLB5YxhcVVWjCS4pPQeRnVecUJ+KB8UVCoqlsCGcPYRwOk1T49Gu4+/xYjeu9V96UEcsouRNAFszhtojcmoM5gSoZVnngchoI2Eepc4fG6561XEznWWf058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713283; c=relaxed/simple;
	bh=CybF/SeRTXijn6ocSgXLAx1fhOdpFp5Rl/id9sTsV44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwVMWjmpJ1mvP5bzVGjmOwj7LooyAxgaxp9s0ZbPCFrROylZepjvs2vgi03Z1g0IeMgv8M5xcVsh6Crift1eOwdEmr4hQRh+wd2w02zAUuaTMkBBaOf93M9tD8SQ+qxOgagBnK52cNFRVpQ3rPKMRMmBaHiP4BXnBmoUbUb0GcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B2Ry71OF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=B2Ry71OF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B2Ry71OF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="B2Ry71OF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8916B759C5;
	Mon, 29 Jun 2026 06:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crHx+IijfMHbzsvgrmzDfA8IoHjdQtsjQA7Y/OoDh1o=;
	b=B2Ry71OFRrwJz8obVCOHSxOH48SNpqs2do1ytg/i3jTk+TFSRPceZ6ZyNKNY/ua9WRkNk5
	OUWi/VK50GLbcFDoT12OEgV8dxocHxoF8n9NAiYH/Yo6x8nUlFh1rXM+tKM040GJaenPYT
	9328r35ms1em34MrDOUecgOMtlKG4+I=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1782713279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crHx+IijfMHbzsvgrmzDfA8IoHjdQtsjQA7Y/OoDh1o=;
	b=B2Ry71OFRrwJz8obVCOHSxOH48SNpqs2do1ytg/i3jTk+TFSRPceZ6ZyNKNY/ua9WRkNk5
	OUWi/VK50GLbcFDoT12OEgV8dxocHxoF8n9NAiYH/Yo6x8nUlFh1rXM+tKM040GJaenPYT
	9328r35ms1em34MrDOUecgOMtlKG4+I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FAA5779A8;
	Mon, 29 Jun 2026 06:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6xw0Cr8LQmroEwAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:07:59 +0000
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
Subject: [PATCH 26/32] x86/msr: Remove wrmsr()
Date: Mon, 29 Jun 2026 08:05:17 +0200
Message-ID: <20260629060526.3638272-27-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -6.80

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
2.54.0

