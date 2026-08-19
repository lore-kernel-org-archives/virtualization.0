Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CB44AB9E
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135020; cv=none; b=VUslwNQw3boHXxIq0kZBaCp/AUonDfw/sPb8OKnq6w6OeuA23jr2bxNSTonyxpSLaOGju0yJH8GfP9PZnAQb5Im/IRP1hOrSJ6KLpDAFlWQVY5sQ1NxAjJyRNIxUpMpkCxvDGg1qfkqJLxStDmjqrgniU27Esk35j1rs0T8mzkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135020; c=relaxed/simple;
	bh=OXckmZoORfCfsw1UPiKwxm+X1mTqVlMFf6dIPLsq7Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T78Rx5awpu05SniGtan67ooE/SofyI4ns7DwNyH5aVijGvDSBHJCffZ5qK3yTeJfbz6AVHj3GkKZnMCRivjvOt3bmOW/fjJaYeMYoiiRYGeHdkQED4ckfSFdjjhavj2qpkYLvdVf+T/UotmvgKdi+LZsci9o9hm2Jh4IAbjKa1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75C7484A93;
	Wed, 19 Aug 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3050F2F81;
	Wed, 19 Aug 2026 10:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wm+oCiiEhWorEgAAD6G6ig
	(envelope-from <jgross@suse.com>); Wed, 19 Aug 2026 10:23:36 +0000
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
Subject: [PATCH v2 03/13] x86/msr: Remove rdmsr_safe()
Date: Wed, 19 Aug 2026 12:23:04 +0200
Message-ID: <20260819102314.1499258-4-jgross@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 75C7484A93
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
2.55.0

