Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C21A26B955
	for <virtualization@lists.linux.dev>; Mon,  6 Oct 2025 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759736887; cv=none; b=NZQGKEuxAMmsHe8+L4r5T3yMSQOaoQrCJazLAU37eBamz03Cm2Kw6ynKhVXDQk1Gqj079864PfK3YfR6N8XQ8OdWSp1i+QCGJYzmvGlERpKbtQHb9nEMkwqBLZy9lEDqA2+9TEWA9686+Jm+BOZ69YgJFQhYKUT8Iw9k3MPH/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759736887; c=relaxed/simple;
	bh=KhS2hR8yS4ddPWKetGb5Mg/+66yHTxjFfkIrs4V1taA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZl1WaUePXSX0DCwLiqcC/t2kVpmvXoXpaYBEOuX3HuBsSEeHLHaeb/Ew58mwNHeH41J1wZHhXrwjZkM5xemybST7NljMtrHJB/Orv66J55rsRNFkPRrYwVB9jkJ85oc4ZWNKdb1ybXMYMBpyBAgY07pC8JU+d2AcjzxUG5JCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YtyShZrL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YtyShZrL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YtyShZrL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YtyShZrL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 82DB01F452;
	Mon,  6 Oct 2025 07:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88n5mUbHShWHoW/2+l8tGp7eL9ycecbkhiJbnud3hQM=;
	b=YtyShZrLIID74Da5EDkfRRxc4MBHA1LH1gfj9PimwkuNZpfJP7C2b5N3996VmcPouk2jXz
	d8NdNOn91gF5unD9XAAXch9EeqBxXtS4htCJmVDD07upRrKBf3ZANTgPif26vNJlvWadKm
	MIWqUmZyPOquZWLwSL6oUppD/Py+Ggo=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1759736884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88n5mUbHShWHoW/2+l8tGp7eL9ycecbkhiJbnud3hQM=;
	b=YtyShZrLIID74Da5EDkfRRxc4MBHA1LH1gfj9PimwkuNZpfJP7C2b5N3996VmcPouk2jXz
	d8NdNOn91gF5unD9XAAXch9EeqBxXtS4htCJmVDD07upRrKBf3ZANTgPif26vNJlvWadKm
	MIWqUmZyPOquZWLwSL6oUppD/Py+Ggo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C74313A7E;
	Mon,  6 Oct 2025 07:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +rsVATR042jHHgAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 06 Oct 2025 07:48:04 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	virtualization@lists.linux.dev
Cc: Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 19/21] x86/paravirt: Allow pv-calls outside paravirt.h
Date: Mon,  6 Oct 2025 09:46:04 +0200
Message-ID: <20251006074606.1266-20-jgross@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006074606.1266-1-jgross@suse.com>
References: <20251006074606.1266-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

In order to prepare for defining paravirt functions outside of
paravirt.h, don't #undef the paravirt call macros.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 62399f5d037d..ba6b14b6f36a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -588,22 +588,6 @@ static __always_inline unsigned long arch_local_irq_save(void)
 }
 #endif
 
-
-/* Make sure as little as possible of this mess escapes. */
-#undef PARAVIRT_CALL
-#undef __PVOP_CALL
-#undef __PVOP_VCALL
-#undef PVOP_VCALL0
-#undef PVOP_CALL0
-#undef PVOP_VCALL1
-#undef PVOP_CALL1
-#undef PVOP_VCALL2
-#undef PVOP_CALL2
-#undef PVOP_VCALL3
-#undef PVOP_CALL3
-#undef PVOP_VCALL4
-#undef PVOP_CALL4
-
 void native_pv_lock_init(void) __init;
 
 #else  /* __ASSEMBLER__ */
-- 
2.51.0

